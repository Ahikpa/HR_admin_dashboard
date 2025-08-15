alter table employees
    add constraint emp_job_fk
        foreign key ( job_id )
            references jobs ( job_id )
        enable;


-- sqlcl_snapshot {"hash":"dfdde015427aec58957c099c39d7290b48d9a40e","type":"REF_CONSTRAINT","name":"EMP_JOB_FK","schemaName":"APP_USER","sxml":""}