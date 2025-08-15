-- liquibase formatted sql
-- changeset APP_USER:1755218779874 stripComments:false  logicalFilePath:featureinitial-setup\app_user\ref_constraints\dept_loc_fk.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/ref_constraints/dept_loc_fk.sql:null:d943881b6e9f1e0617b354ec90d7ee6ecbe528a2:create

alter table departments
    add constraint dept_loc_fk
        foreign key ( location_id )
            references locations ( location_id )
        enable;

