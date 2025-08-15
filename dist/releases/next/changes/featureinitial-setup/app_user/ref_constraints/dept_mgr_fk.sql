-- liquibase formatted sql
-- changeset APP_USER:1755218779890 stripComments:false  logicalFilePath:featureinitial-setup\app_user\ref_constraints\dept_mgr_fk.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/ref_constraints/dept_mgr_fk.sql:null:bf49eece4975f9adcdbb3a4b238e10a32728d947:create

alter table departments
    add constraint dept_mgr_fk
        foreign key ( manager_id )
            references employees ( employee_id )
        enable;

