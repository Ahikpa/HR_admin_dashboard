-- liquibase formatted sql
-- changeset APP_USER:1755218780244 stripComments:false  logicalFilePath:featureinitial-setup\app_user\tables\job_history.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/tables/job_history.sql:null:045464131730624a3824765033d7305155ff94fd:create

create table job_history (
    employee_id   number(6, 0)
        constraint jhist_employee_nn not null enable,
    start_date    date
        constraint jhist_start_date_nn not null enable,
    end_date      date
        constraint jhist_end_date_nn not null enable,
    job_id        varchar2(10 byte)
        constraint jhist_job_nn not null enable,
    department_id number(4, 0)
);

create unique index jhist_emp_id_st_date_pk on
    job_history (
        employee_id,
        start_date
    );

alter table job_history add constraint jhist_date_interval check ( end_date > start_date ) enable;

alter table job_history
    add constraint jhist_emp_id_st_date_pk
        primary key ( employee_id,
                      start_date )
            using index jhist_emp_id_st_date_pk enable;

