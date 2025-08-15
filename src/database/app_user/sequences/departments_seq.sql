create sequence departments_seq minvalue 1 maxvalue 9990 increment by 10 /* start with n */ nocache noorder nocycle nokeep noscale global
;


-- sqlcl_snapshot {"hash":"89b013fd15f7aaca642a176338e2a1c120ac5b44","type":"SEQUENCE","name":"DEPARTMENTS_SEQ","schemaName":"APP_USER","sxml":"\n  <SEQUENCE xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <SCHEMA>APP_USER</SCHEMA>\n   <NAME>DEPARTMENTS_SEQ</NAME>\n   \n   <INCREMENT>10</INCREMENT>\n   <MINVALUE>1</MINVALUE>\n   <MAXVALUE>9990</MAXVALUE>\n   <CACHE>0</CACHE>\n   <SCALE>NOSCALE</SCALE>\n</SEQUENCE>"}