alter table employees
    add constraint emp_manager_fk
        foreign key ( manager_id )
            references employees ( employee_id )
        enable;


-- sqlcl_snapshot {"hash":"94d6c3f188c9abeae45211e84c23b82a647b8619","type":"REF_CONSTRAINT","name":"EMP_MANAGER_FK","schemaName":"APP_USER","sxml":""}