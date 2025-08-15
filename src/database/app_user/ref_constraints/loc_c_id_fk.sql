alter table locations
    add constraint loc_c_id_fk
        foreign key ( country_id )
            references countries ( country_id )
        enable;


-- sqlcl_snapshot {"hash":"b2e7c305c9fce791f90b423568d0f5cf2a163412","type":"REF_CONSTRAINT","name":"LOC_C_ID_FK","schemaName":"APP_USER","sxml":""}