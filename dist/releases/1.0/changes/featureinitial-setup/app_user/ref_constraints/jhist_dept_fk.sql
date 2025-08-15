-- liquibase formatted sql
-- changeset APP_USER:1755218779951 stripComments:false  logicalFilePath:featureinitial-setup\app_user\ref_constraints\jhist_dept_fk.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/ref_constraints/jhist_dept_fk.sql:null:24890f7b58a073fd9565ce8e4f8fdbd862b749d7:create

alter table job_history
    add constraint jhist_dept_fk
        foreign key ( department_id )
            references departments ( department_id )
        enable;

