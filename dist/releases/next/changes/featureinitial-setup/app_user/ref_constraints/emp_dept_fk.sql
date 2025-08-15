-- liquibase formatted sql
-- changeset APP_USER:1755218779904 stripComments:false  logicalFilePath:featureinitial-setup\app_user\ref_constraints\emp_dept_fk.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/ref_constraints/emp_dept_fk.sql:null:23453f27202b9904af56d2cc8791fa97d3428dad:create

alter table employees
    add constraint emp_dept_fk
        foreign key ( department_id )
            references departments ( department_id )
        enable;

