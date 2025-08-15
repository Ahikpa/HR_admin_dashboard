alter table job_history
    add constraint jhist_job_fk
        foreign key ( job_id )
            references jobs ( job_id )
        enable;


-- sqlcl_snapshot {"hash":"4169866c6fb4ac7bc8416f5274d13cdebabdcd0b","type":"REF_CONSTRAINT","name":"JHIST_JOB_FK","schemaName":"APP_USER","sxml":""}