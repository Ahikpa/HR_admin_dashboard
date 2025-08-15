-- liquibase formatted sql
-- changeset APP_USER:1755218780041 stripComments:false  logicalFilePath:featureinitial-setup\app_user\sequences\employees_seq.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/sequences/employees_seq.sql:null:8beccd5aeddc538d3721a3092fb6e9cf3f35be45:create

create sequence employees_seq minvalue 1 maxvalue 9999999999999999999999999999 increment by 1 /* start with n */ nocache noorder nocycle
nokeep noscale global;

