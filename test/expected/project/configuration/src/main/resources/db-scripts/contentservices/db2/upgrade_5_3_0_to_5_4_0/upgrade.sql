ALTER TABLE OBJECT_TYPE_DEFINITION ADD VERSIONABLE SMALLINT DEFAULT NULL;
ALTER TABLE OBJECT_TYPE_DEFINITION ADD CONSTRAINT OBJECT_TYPE_DEFINITION_VERSIONABLE_CK CHECK (VERSIONABLE IN (1,0, NULL));

REORG TABLE OBJECT_TYPE_DEFINITION;

UPDATE OBJECT_TYPE_DEFINITION SET VERSIONABLE = ( 
	CASE 
		WHEN OBJECTID LIKE 'bb:%' THEN 1 
		WHEN OBJECTID = 'cmis:document' THEN 0
		ELSE NULL 
	END
);