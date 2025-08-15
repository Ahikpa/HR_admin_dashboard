-- liquibase formatted sql
-- changeset APP_USER:1755218780195 stripComments:false  logicalFilePath:featureinitial-setup\app_user\tables\employees.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/tables/employees.sql:null:3ccaf3638a829faa99af8bd5d87fb1ba6d7afe77:create

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

