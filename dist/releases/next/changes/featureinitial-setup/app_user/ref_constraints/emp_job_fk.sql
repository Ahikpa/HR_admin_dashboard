-- liquibase formatted sql
-- changeset APP_USER:1755218779917 stripComments:false  logicalFilePath:featureinitial-setup\app_user\ref_constraints\emp_job_fk.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/ref_constraints/emp_job_fk.sql:null:dfdde015427aec58957c099c39d7290b48d9a40e:create

alter table employees
    add constraint emp_job_fk
        foreign key ( job_id )
            references jobs ( job_id )
        enable;

