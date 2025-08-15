alter table countries
    add constraint countr_reg_fk
        foreign key ( region_id )
            references regions ( region_id )
        enable;


-- sqlcl_snapshot {"hash":"1c18f8f2f8ca2d02c4ef0dc048a7a263bb17e06d","type":"REF_CONSTRAINT","name":"COUNTR_REG_FK","schemaName":"APP_USER","sxml":""}