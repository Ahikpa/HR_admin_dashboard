-- liquibase formatted sql
-- changeset APP_USER:1755218780144 stripComments:false  logicalFilePath:featureinitial-setup\app_user\tables\departments.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/tables/departments.sql:null:54cf45f2a7b37ed18eacc08131867810d924fb04:create

create table departments (
    department_id   number(4, 0),
    department_name varchar2(30 byte)
        constraint dept_name_nn not null enable,
    manager_id      number(6, 0),
    location_id     number(4, 0)
);

create unique index dept_id_pk on
    departments (
        department_id
    );

alter table departments
    add constraint dept_id_pk primary key ( department_id )
        using index dept_id_pk enable;

