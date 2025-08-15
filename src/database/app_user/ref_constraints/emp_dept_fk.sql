alter table employees
    add constraint emp_dept_fk
        foreign key ( department_id )
            references departments ( department_id )
        enable;


-- sqlcl_snapshot {"hash":"23453f27202b9904af56d2cc8791fa97d3428dad","type":"REF_CONSTRAINT","name":"EMP_DEPT_FK","schemaName":"APP_USER","sxml":""}