-- liquibase formatted sql
-- changeset APP_USER:1755218780384 stripComments:false  logicalFilePath:featureinitial-setup\app_user\tables\regions.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/tables/regions.sql:null:f34dd8dbc2b4629f8bc60b4f1ad227a1bdfb60eb:create

create table regions (
    region_id   number
        constraint regions_id_nn not null enable,
    region_name varchar2(25 byte)
);

create unique index reg_id_pk on
    regions (
        region_id
    );

alter table regions
    add constraint reg_id_pk primary key ( region_id )
        using index reg_id_pk enable;

