-- liquibase formatted sql
-- changeset APP_USER:1755218779934 stripComments:false  logicalFilePath:featureinitial-setup\app_user\ref_constraints\emp_manager_fk.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/ref_constraints/emp_manager_fk.sql:null:94d6c3f188c9abeae45211e84c23b82a647b8619:create

alter table employees
    add constraint emp_manager_fk
        foreign key ( manager_id )
            references employees ( employee_id )
        enable;

