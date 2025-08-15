alter table departments
    add constraint dept_mgr_fk
        foreign key ( manager_id )
            references employees ( employee_id )
        enable;


-- sqlcl_snapshot {"hash":"bf49eece4975f9adcdbb3a4b238e10a32728d947","type":"REF_CONSTRAINT","name":"DEPT_MGR_FK","schemaName":"APP_USER","sxml":""}