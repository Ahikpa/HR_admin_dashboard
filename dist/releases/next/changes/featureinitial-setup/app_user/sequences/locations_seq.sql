-- liquibase formatted sql
-- changeset APP_USER:1755218780060 stripComments:false  logicalFilePath:featureinitial-setup\app_user\sequences\locations_seq.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/sequences/locations_seq.sql:null:eaaa882e6b30650533434c108821666bb6b61112:create

create sequence locations_seq minvalue 1 maxvalue 9900 increment by 100 /* start with n */ nocache noorder nocycle nokeep noscale global
;

