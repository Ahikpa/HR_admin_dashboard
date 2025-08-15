alter table job_history
    add constraint jhist_dept_fk
        foreign key ( department_id )
            references departments ( department_id )
        enable;


-- sqlcl_snapshot {"hash":"24890f7b58a073fd9565ce8e4f8fdbd862b749d7","type":"REF_CONSTRAINT","name":"JHIST_DEPT_FK","schemaName":"APP_USER","sxml":""}