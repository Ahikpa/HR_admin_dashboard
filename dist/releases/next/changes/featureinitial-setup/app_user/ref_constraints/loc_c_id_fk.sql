-- liquibase formatted sql
-- changeset APP_USER:1755218780003 stripComments:false  logicalFilePath:featureinitial-setup\app_user\ref_constraints\loc_c_id_fk.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/ref_constraints/loc_c_id_fk.sql:null:b2e7c305c9fce791f90b423568d0f5cf2a163412:create

alter table locations
    add constraint loc_c_id_fk
        foreign key ( country_id )
            references countries ( country_id )
        enable;

