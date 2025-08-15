-- liquibase formatted sql
-- changeset APP_USER:1755218780283 stripComments:false  logicalFilePath:featureinitial-setup\app_user\tables\jobs.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/app_user/tables/jobs.sql:null:dde6085de38c36664aae90ea8485c3ed78966bd1:create

create table jobs (
    job_id     varchar2(10 byte),
    job_title  varchar2(35 byte)
        constraint job_title_nn not null enable,
    min_salary number(6, 0),
    max_salary number(6, 0)
);

create unique index job_id_pk on
    jobs (
        job_id
    );

alter table jobs
    add constraint job_id_pk primary key ( job_id )
        using index job_id_pk enable;

