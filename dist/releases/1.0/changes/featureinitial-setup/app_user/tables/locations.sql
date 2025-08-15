-- liquibase formatted sql
-- changeset APP_USER:1755218780323 stripComments:false  logicalFilePath:featureinitial-setup\app_user\tables\locations.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/tables/locations.sql:null:922358975780562ffdb034b7006d7594fa16fde7:create

create table locations (
    location_id    number(4, 0),
    street_address varchar2(40 byte),
    postal_code    varchar2(12 byte),
    city           varchar2(30 byte)
        constraint loc_city_nn not null enable,
    state_province varchar2(25 byte),
    country_id     char(2 byte)
);

create unique index loc_id_pk on
    locations (
        location_id
    );

alter table locations
    add constraint loc_id_pk primary key ( location_id )
        using index loc_id_pk enable;

