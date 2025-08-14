import oracledb
import os
from typing import Optional
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

from typing import Optional

@app.get("/api/employees")
async def get_employees(search: Optional[str] = None, page: int = 1, limit: int = 10, sort_by: str = 'employee_id', sort_order: str = 'asc'):
    """
    Retrieves a paginated and sorted list of employees.
    """
    if not pool:
        raise HTTPException(status_code=500, detail="Database connection is not available.")

    # Whitelist for security
    allowed_sort_columns = ['employee_id', 'first_name', 'last_name', 'email', 'hire_date', 'job_id', 'salary']
    if sort_by not in allowed_sort_columns:
        sort_by = 'employee_id' # Default sort column
    if sort_order.lower() not in ['asc', 'desc']:
        sort_order = 'asc' # Default sort order

    try:
        with pool.acquire() as connection:
            cursor = connection.cursor()

            # --- Get total count for pagination ---
            count_sql = "SELECT COUNT(*) FROM employees"
            count_binds = {}
            if search:
                count_sql += " WHERE LOWER(first_name) LIKE :search_term OR LOWER(last_name) LIKE :search_term OR LOWER(email) LIKE :search_term"
                count_binds['search_term'] = f"%{search.lower()}%"
            
            cursor.execute(count_sql, count_binds)
            total_count = cursor.fetchone()[0]

            # --- Get paginated and sorted results ---
            offset = (page - 1) * limit
            sql_query = f"SELECT employee_id, first_name, last_name, email, hire_date, job_id, salary FROM employees"
            binds = {}

            if search:
                sql_query += " WHERE LOWER(first_name) LIKE :search_term OR LOWER(last_name) LIKE :search_term OR LOWER(email) LIKE :search_term"
                binds['search_term'] = f"%{search.lower()}%"
            
            # Safely add ORDER BY clause
            sql_query += f" ORDER BY {sort_by} {sort_order.upper()}"
            
            sql_query += " OFFSET :offset ROWS FETCH NEXT :limit ROWS ONLY"
            binds['offset'] = offset
            binds['limit'] = limit

            cursor.execute(sql_query, binds)
            
            columns = [col[0].lower() for col in cursor.description]
            employees = []
            for row in cursor.fetchall():
                emp_dict = dict(zip(columns, row))
                if 'hire_date' in emp_dict and isinstance(emp_dict['hire_date'], datetime):
                    emp_dict['hire_date'] = emp_dict['hire_date'].strftime('%Y-%m-%d')
                employees.append(emp_dict)

            return {"total_count": total_count, "employees": employees}

    except oracledb.Error as e:
        print(f"Error while fetching employees: {e}")
        raise HTTPException(status_code=500, detail=f"Error fetching data from the database: {e}")
