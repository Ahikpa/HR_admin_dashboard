alter table job_history
    add constraint jhist_emp_fk
        foreign key ( employee_id )
            references employees ( employee_id )
        enable;


-- sqlcl_snapshot {"hash":"a1df5bfbc8769f5bf81c569e37e33349da7f1001","type":"REF_CONSTRAINT","name":"JHIST_EMP_FK","schemaName":"APP_USER","sxml":""}