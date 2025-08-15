-- liquibase formatted sql
-- changeset APP_USER:1755218779989 stripComments:false  logicalFilePath:featureinitial-setup\app_user\ref_constraints\jhist_job_fk.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/ref_constraints/jhist_job_fk.sql:null:4169866c6fb4ac7bc8416f5274d13cdebabdcd0b:create

alter table job_history
    add constraint jhist_job_fk
        foreign key ( job_id )
            references jobs ( job_id )
        enable;

