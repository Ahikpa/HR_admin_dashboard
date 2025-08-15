-- liquibase formatted sql
-- changeset APP_USER:1755218779857 stripComments:false  logicalFilePath:featureinitial-setup\app_user\ref_constraints\countr_reg_fk.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/ref_constraints/countr_reg_fk.sql:null:1c18f8f2f8ca2d02c4ef0dc048a7a263bb17e06d:create

alter table countries
    add constraint countr_reg_fk
        foreign key ( region_id )
            references regions ( region_id )
        enable;

