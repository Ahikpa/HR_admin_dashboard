create table employees (
    employee_id    number(6, 0),
    first_name     varchar2(20 byte),
    last_name      varchar2(25 byte)
        constraint emp_last_name_nn not null enable,
    email          varchar2(25 byte)
        constraint emp_email_nn not null enable,
    phone_number   varchar2(20 byte),
    hire_date      date
        constraint emp_hire_date_nn not null enable,
    job_id         varchar2(10 byte)
        constraint emp_job_nn not null enable,
    salary         number(8, 2),
    commission_pct number(2, 2),
    manager_id     number(6, 0),
    department_id  number(4, 0)
);

create unique index emp_emp_id_pk on
    employees (
        employee_id
    );

alter table employees add constraint emp_email_uk unique ( email )
    using index enable;

alter table employees
    add constraint emp_emp_id_pk primary key ( employee_id )
        using index emp_emp_id_pk enable;

alter table employees add constraint emp_salary_min check ( salary > 0 ) enable;


-- sqlcl_snapshot {"hash":"e9c35e7ee773f471a2dd5c465ed9e17f8d23ba4d","type":"TABLE","name":"EMPLOYEES","schemaName":"APP_USER","sxml":"\n  <TABLE xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <SCHEMA>APP_USER</SCHEMA>\n   <NAME>EMPLOYEES</NAME>\n   <RELATIONAL_TABLE>\n      <COL_LIST>\n         <COL_LIST_ITEM>\n            <NAME>EMPLOYEE_ID</NAME>\n            <DATATYPE>NUMBER</DATATYPE>\n            <PRECISION>6</PRECISION>\n            <SCALE>0</SCALE>\n         </COL_LIST_ITEM>\n         <COL_LIST_ITEM>\n            <NAME>FIRST_NAME</NAME>\n            <DATATYPE>VARCHAR2</DATATYPE>\n            <LENGTH>20</LENGTH>\n            <COLLATE_NAME>USING_NLS_COMP</COLLATE_NAME>\n         </COL_LIST_ITEM>\n         <COL_LIST_ITEM>\n            <NAME>LAST_NAME</NAME>\n            <DATATYPE>VARCHAR2</DATATYPE>\n            <LENGTH>25</LENGTH>\n            <COLLATE_NAME>USING_NLS_COMP</COLLATE_NAME>\n            <NOT_NULL>\n               <NAME>EMP_LAST_NAME_NN</NAME>\n            </NOT_NULL>\n         </COL_LIST_ITEM>\n         <COL_LIST_ITEM>\n            <NAME>EMAIL</NAME>\n            <DATATYPE>VARCHAR2</DATATYPE>\n            <LENGTH>25</LENGTH>\n            <COLLATE_NAME>USING_NLS_COMP</COLLATE_NAME>\n            <NOT_NULL>\n               <NAME>EMP_EMAIL_NN</NAME>\n            </NOT_NULL>\n         </COL_LIST_ITEM>\n         <COL_LIST_ITEM>\n            <NAME>PHONE_NUMBER</NAME>\n            <DATATYPE>VARCHAR2</DATATYPE>\n            <LENGTH>20</LENGTH>\n            <COLLATE_NAME>USING_NLS_COMP</COLLATE_NAME>\n         </COL_LIST_ITEM>\n         <COL_LIST_ITEM>\n            <NAME>HIRE_DATE</NAME>\n            <DATATYPE>DATE</DATATYPE>\n            <NOT_NULL>\n               <NAME>EMP_HIRE_DATE_NN</NAME>\n            </NOT_NULL>\n         </COL_LIST_ITEM>\n         <COL_LIST_ITEM>\n            <NAME>JOB_ID</NAME>\n            <DATATYPE>VARCHAR2</DATATYPE>\n            <LENGTH>10</LENGTH>\n            <COLLATE_NAME>USING_NLS_COMP</COLLATE_NAME>\n            <NOT_NULL>\n               <NAME>EMP_JOB_NN</NAME>\n            </NOT_NULL>\n         </COL_LIST_ITEM>\n         <COL_LIST_ITEM>\n            <NAME>SALARY</NAME>\n            <DATATYPE>NUMBER</DATATYPE>\n            <PRECISION>8</PRECISION>\n            <SCALE>2</SCALE>\n         </COL_LIST_ITEM>\n         <COL_LIST_ITEM>\n            <NAME>COMMISSION_PCT</NAME>\n            <DATATYPE>NUMBER</DATATYPE>\n            <PRECISION>2</PRECISION>\n            <SCALE>2</SCALE>\n         </COL_LIST_ITEM>\n         <COL_LIST_ITEM>\n            <NAME>MANAGER_ID</NAME>\n            <DATATYPE>NUMBER</DATATYPE>\n            <PRECISION>6</PRECISION>\n            <SCALE>0</SCALE>\n         </COL_LIST_ITEM>\n         <COL_LIST_ITEM>\n            <NAME>DEPARTMENT_ID</NAME>\n            <DATATYPE>NUMBER</DATATYPE>\n            <PRECISION>4</PRECISION>\n            <SCALE>0</SCALE>\n         </COL_LIST_ITEM>\n      </COL_LIST>\n      <CHECK_CONSTRAINT_LIST>\n         <CHECK_CONSTRAINT_LIST_ITEM>\n            <NAME>EMP_SALARY_MIN</NAME>\n            <CONDITION>salary > 0</CONDITION>\n         </CHECK_CONSTRAINT_LIST_ITEM>\n      </CHECK_CONSTRAINT_LIST>\n      <PRIMARY_KEY_CONSTRAINT_LIST>\n         <PRIMARY_KEY_CONSTRAINT_LIST_ITEM>\n            <NAME>EMP_EMP_ID_PK</NAME>\n            <COL_LIST>\n               <COL_LIST_ITEM>\n                  <NAME>EMPLOYEE_ID</NAME>\n               </COL_LIST_ITEM>\n            </COL_LIST>\n            <USING_INDEX></USING_INDEX>\n         </PRIMARY_KEY_CONSTRAINT_LIST_ITEM>\n      </PRIMARY_KEY_CONSTRAINT_LIST>\n      <UNIQUE_KEY_CONSTRAINT_LIST>\n         <UNIQUE_KEY_CONSTRAINT_LIST_ITEM>\n            <NAME>EMP_EMAIL_UK</NAME>\n            <COL_LIST>\n               <COL_LIST_ITEM>\n                  <NAME>EMAIL</NAME>\n               </COL_LIST_ITEM>\n            </COL_LIST>\n            <USING_INDEX></USING_INDEX>\n         </UNIQUE_KEY_CONSTRAINT_LIST_ITEM>\n      </UNIQUE_KEY_CONSTRAINT_LIST>\n      <DEFAULT_COLLATION>USING_NLS_COMP</DEFAULT_COLLATION>\n      <PHYSICAL_PROPERTIES>\n         <HEAP_TABLE></HEAP_TABLE>\n      </PHYSICAL_PROPERTIES>\n   </RELATIONAL_TABLE>\n</TABLE>"}