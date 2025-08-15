-- liquibase formatted sql
-- changeset APP_USER:1755218780083 stripComments:false  logicalFilePath:featureinitial-setup\app_user\tables\countries.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/tables/countries.sql:null:e4078905a48fbbbcd20cc49b87817fe0a1abe3fe:create

create table countries (
    country_id   char(2 byte)
        constraint country_id_nn not null enable,
    country_name varchar2(40 byte),
    region_id    number,
    constraint country_c_id_pk primary key ( country_id ) enable
)
organization index nocompress;

