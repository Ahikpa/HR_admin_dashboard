alter table departments
    add constraint dept_loc_fk
        foreign key ( location_id )
            references locations ( location_id )
        enable;


-- sqlcl_snapshot {"hash":"d943881b6e9f1e0617b354ec90d7ee6ecbe528a2","type":"REF_CONSTRAINT","name":"DEPT_LOC_FK","schemaName":"APP_USER","sxml":""}