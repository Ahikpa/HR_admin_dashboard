-- liquibase formatted sql
-- changeset APP_USER:1755218780021 stripComments:false  logicalFilePath:featureinitial-setup\app_user\sequences\departments_seq.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/sequences/departments_seq.sql:null:89b013fd15f7aaca642a176338e2a1c120ac5b44:create

create sequence departments_seq minvalue 1 maxvalue 9990 increment by 10 /* start with n */ nocache noorder nocycle nokeep noscale global
;

