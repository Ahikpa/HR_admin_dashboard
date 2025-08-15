-- liquibase formatted sql
-- changeset APP_USER:1755218779973 stripComments:false  logicalFilePath:featureinitial-setup\app_user\ref_constraints\jhist_emp_fk.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/ref_constraints/jhist_emp_fk.sql:null:a1df5bfbc8769f5bf81c569e37e33349da7f1001:create

alter table job_history
    add constraint jhist_emp_fk
        foreign key ( employee_id )
            references employees ( employee_id )
        enable;

