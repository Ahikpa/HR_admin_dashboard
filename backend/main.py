import oracledb
import os
from fastapi import FastAPI, HTTPException
from contextlib import asynccontextmanager
from dotenv import load_dotenv

# Charger les variables d'environnement à partir du fichier .env
load_dotenv()
from datetime import datetime

# --- Database Configuration ---
# It's recommended to use environment variables for security in a real project.
# For now, we use the provided credentials with a fallback.
DB_USER = os.environ.get("DB_USER")
DB_PASSWORD = os.environ.get("DB_PASSWORD")
DB_DSN = os.environ.get("DB_DSN")

pool = None

# --- Lifespan management for the connection pool ---
@asynccontextmanager
async def lifespan(app: FastAPI):
    global pool
    print("FastAPI application starting up...")
    try:
        pool = oracledb.create_pool(
            user=DB_USER,
            password=DB_PASSWORD,
            dsn=DB_DSN,
            min=2,
            max=5,
            increment=1
        )
        print("Database connection pool created successfully.")
    except oracledb.Error as e:
        print(f"Error creating connection pool: {e}")
        pool = None
    
    yield
    
    if pool:
        print("Closing database connection pool.")
        pool.close()
        print("Connection pool closed.")

# --- FastAPI App ---
app = FastAPI(
    title="HR Admin Dashboard API",
    description="API to manage the HR database.",
    version="0.1.0",
    lifespan=lifespan
)

@app.get("/")
def read_root():
    return {"message": "Welcome to the HR Admin Dashboard API"}

@app.get("/api/employees")
async def get_employees():
    """
    Retrieves the list of employees from the Oracle database.
    """
    if not pool:
        raise HTTPException(status_code=500, detail="Database connection is not available.")

    try:
        with pool.acquire() as connection:
            cursor = connection.cursor()
            # Select only a few columns for brevity and limit rows
            cursor.execute("SELECT employee_id, first_name, last_name, email, hire_date, job_id, salary FROM employees FETCH FIRST 20 ROWS ONLY")
            
            # Fetch column names from the cursor description
            columns = [col[0].lower() for col in cursor.description]
            
            # Fetch all rows and create a list of dictionaries
            employees = []
            for row in cursor.fetchall():
                emp_dict = dict(zip(columns, row))
                # Convert datetime objects to string
                if 'hire_date' in emp_dict and isinstance(emp_dict['hire_date'], datetime):
                    emp_dict['hire_date'] = emp_dict['hire_date'].strftime('%Y-%m-%d')
                employees.append(emp_dict)

            return employees
    except oracledb.Error as e:
        print(f"Error while fetching employees: {e}")
        raise HTTPException(status_code=500, detail=f"Error fetching data from the database: {e}")
