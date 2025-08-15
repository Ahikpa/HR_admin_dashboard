-- liquibase formatted sql
-- changeset APP_USER:1755218780441 stripComments:false  logicalFilePath:featureinitial-setup\app_user\views\emp_details_view.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/views/emp_details_view.sql:null:eb8f67b17615c1b3a255dd3cbf22162fcd921fd1:create

create or replace force editionable view emp_details_view (
    employee_id,
    job_id,
    manager_id,
    department_id,
    location_id,
    country_id,
    first_name,
    last_name,
    salary,
    commission_pct,
    department_name,
    job_title,
    city,
    state_province,
    country_name,
    region_name
) as
    select
        e.employee_id,
        e.job_id,
        e.manager_id,
        e.department_id,
        d.location_id,
        l.country_id,
        e.first_name,
        e.last_name,
        e.salary,
        e.commission_pct,
        d.department_name,
        j.job_title,
        l.city,
        l.state_province,
        c.country_name,
        r.region_name
    from
             employees e
        inner join departments d on e.department_id = d.department_id
        inner join jobs        j on j.job_id = e.job_id
        inner join locations   l on d.location_id = l.location_id
        inner join countries   c on l.country_id = c.country_id
        inner join regions     r on c.region_id = r.region_id
with read only;

