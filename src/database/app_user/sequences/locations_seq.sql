create sequence locations_seq minvalue 1 maxvalue 9900 increment by 100 /* start with n */ nocache noorder nocycle nokeep noscale global
;


-- sqlcl_snapshot {"hash":"eaaa882e6b30650533434c108821666bb6b61112","type":"SEQUENCE","name":"LOCATIONS_SEQ","schemaName":"APP_USER","sxml":"\n  <SEQUENCE xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <SCHEMA>APP_USER</SCHEMA>\n   <NAME>LOCATIONS_SEQ</NAME>\n   \n   <INCREMENT>100</INCREMENT>\n   <MINVALUE>1</MINVALUE>\n   <MAXVALUE>9900</MAXVALUE>\n   <CACHE>0</CACHE>\n   <SCALE>NOSCALE</SCALE>\n</SEQUENCE>"}