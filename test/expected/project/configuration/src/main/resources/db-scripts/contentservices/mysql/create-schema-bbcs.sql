
    create table CONTENT_STREAM (
        id bigint not null auto_increment,
        CONTENT longblob not null,
        primary key (id)
    ) ROW_FORMAT=DYNAMIC;

    create table OBJECT_DATA (
        id bigint not null auto_increment,
        path varchar(765) not null,
        versionLabel varchar(255),
        versionSeriesId varchar(255),
        objectId varchar(255) not null,
        isLatestVersion varchar(255),
        OBJECT_TYPE_ID bigint not null,
        PARENT_ID bigint,
        CS_ID bigint,
        RD_ID bigint not null,
        uniquePathCheck varchar(64) not null,
        primary key (id)
    ) ROW_FORMAT=DYNAMIC;

    create table OBJECT_TYPE_DEFINITION (
        id bigint not null auto_increment,
        baseType varchar(255) not null,
        contentStreamAllowed varchar(255),
        creatable boolean,
        description varchar(255),
        displayName varchar(255),
        fileable boolean,
        fullTextIndexed boolean,
        localName varchar(255),
        localNamespace varchar(255),
        objectId varchar(255) not null,
        PARENT_ID bigint,
        RD_ID bigint not null,
        queryName varchar(255),
        queryable boolean,
        versionable boolean,
        primary key (id)
    ) ROW_FORMAT=DYNAMIC;

    create table PROPERTY_DATA (
        id bigint not null auto_increment,
        displayName varchar(255),
        localName varchar(255),
        OBJECT_DATA_ID bigint not null,
        objectId varchar(255) not null,
        PROPERTY_DEFINITION_ID bigint not null,
        queryName varchar(255),
        value varchar(765),
        primary key (id)
    ) ROW_FORMAT=DYNAMIC;

    create table PROPERTY_DEFINITION (
        id bigint not null auto_increment,
        cardinality varchar(255),
        description varchar(255),
        displayName varchar(255),
        inherited boolean,
        localName varchar(255),
        localNamespace varchar(255),
        objectId varchar(255) not null,
        OBJECT_TYPE_ID bigint not null,
        orderable boolean,
        queryName varchar(255),
        queryable boolean,
        required boolean not null,
        type varchar(255) not null,
        updatability varchar(255),
        primary key (id)
    ) ROW_FORMAT=DYNAMIC;

    create table RELATIONSHIPS (
        id bigint not null auto_increment,
        objectId varchar(255) not null,
        sourceId bigint,
        targetRepositoryId varchar(255) not null,
        targetObjectId varchar(255) not null,
        relationshipType varchar(255) not null,
        primary key (id)
    ) ROW_FORMAT=DYNAMIC;

    create table RENDITION (
        id bigint not null auto_increment,
        filePath varchar(765),
        height decimal(19,2),
        kind varchar(255),
        length decimal(19,2),
        mimeType varchar(255),
        OBJECT_DATA_ID bigint not null,
        renditionDocumentId varchar(255),
        title varchar(255),
        width decimal(19,2),
        objectId varchar(255) not null,
        streamId varchar(255) not null,
        CS_ID bigint,
        primary key (id)
    ) ROW_FORMAT=DYNAMIC;

    create table REPOSITORY_DEFINITION (
        id bigint not null auto_increment,
        REPOSITORY_ID varchar(255) not null,
        NAME varchar(255) not null,
        DESCRIPTION varchar(255),
        VENDOR_NAME varchar(255),
        PRODUCT_NAME varchar(255),
        PRODUCT_VERSION varchar(255) not null,
        primary key (id)
    ) ROW_FORMAT=DYNAMIC;

    alter table OBJECT_DATA 
        add constraint UK_6gtsqb7fmaw6p0ikg6xheulrb unique (uniquePathCheck);

    create index ODPATH_IDX on OBJECT_DATA (path);

    create index ODVL_IDX on OBJECT_DATA (versionLabel);

    create index ODVSID_IDX on OBJECT_DATA (versionSeriesId);

    create index ODILV_IDX on OBJECT_DATA (isLatestVersion);

    create index FK_OD_IDX_OBJECT_TYPE_ID on OBJECT_DATA (OBJECT_TYPE_ID);

    create index FK_OD_IDX_CS_ID on OBJECT_DATA (CS_ID);

    create index FK_OD_IDX_OD_RD_REPOID on OBJECT_DATA (RD_ID);

    create index FK_OD_IDX_PARENT on OBJECT_DATA (PARENT_ID);

    alter table OBJECT_DATA 
        add constraint FK_354y502ct1ju7tg6v1rlfpwgo 
        foreign key (OBJECT_TYPE_ID) 
        references OBJECT_TYPE_DEFINITION (id);

    alter table OBJECT_DATA 
        add constraint FK_mhp750onsg14deqsc5mkp4dx 
        foreign key (PARENT_ID) 
        references OBJECT_DATA (id);

    alter table OBJECT_DATA 
        add constraint FK_i6hwfpq7ppvktiim2thpqxiac 
        foreign key (CS_ID) 
        references CONTENT_STREAM (id);

    alter table OBJECT_DATA 
        add constraint FK_6gu2if5arkmusbvrssixki55r 
        foreign key (RD_ID) 
        references REPOSITORY_DEFINITION (id);

    create index FK_OD_IDX_OTD_RD_REPOID on OBJECT_TYPE_DEFINITION (RD_ID);

    create index FK_OTD_IDX_PARENT on OBJECT_TYPE_DEFINITION (PARENT_ID);

    alter table OBJECT_TYPE_DEFINITION 
        add constraint FK_83a12dvjdi2psds4t3pfrwbfb 
        foreign key (PARENT_ID) 
        references OBJECT_TYPE_DEFINITION (id);

    alter table OBJECT_TYPE_DEFINITION 
        add constraint FK_luq75uv8ksxyjp0t3v16jkanx 
        foreign key (RD_ID) 
        references REPOSITORY_DEFINITION (id);

    create index FK_PD_IDX_OBJECT_DATA_ID on PROPERTY_DATA (OBJECT_DATA_ID);

    create index FK_PD_IDX_OBJECTID on PROPERTY_DATA (objectId);

    create index FK_PD_IDX_PROP_DEF_ID on PROPERTY_DATA (PROPERTY_DEFINITION_ID);

    alter table PROPERTY_DATA 
        add constraint FK_r5pfq0qmo565nb85q01q6r5og 
        foreign key (OBJECT_DATA_ID) 
        references OBJECT_DATA (id);

    alter table PROPERTY_DATA 
        add constraint FK_c2yshju50dy6nutodteogo28t 
        foreign key (PROPERTY_DEFINITION_ID) 
        references PROPERTY_DEFINITION (id);

    create index FK_PDEF_IDX_OBJ_ID on PROPERTY_DEFINITION (objectId);

    create index FK_PDEF_IDX_OBJECT_TYPE_ID on PROPERTY_DEFINITION (OBJECT_TYPE_ID);

    alter table PROPERTY_DEFINITION 
        add constraint FK_s6scxspskrpjulqsj4u98us2g 
        foreign key (OBJECT_TYPE_ID) 
        references OBJECT_TYPE_DEFINITION (id);

    create index REL_TARGET_IDX on RELATIONSHIPS (targetRepositoryId, targetObjectId);

    alter table RELATIONSHIPS 
        add constraint FK_cwor9qcw8nm14qawhqtatfhbc 
        foreign key (sourceId) 
        references OBJECT_DATA (id);

    create index FK_RND_IDX_OBJECT_DATA_ID on RENDITION (OBJECT_DATA_ID);

    create index FK_RND_IDX_CONTENT_STREAM_ID on RENDITION (CS_ID);

    alter table RENDITION 
        add constraint FK_aw8vtq9lh7ehwfu0oc30q0hqn 
        foreign key (OBJECT_DATA_ID) 
        references OBJECT_DATA (id);

    alter table RENDITION 
        add constraint FK_l7rl4ulhh823p0t9oswg761c9 
        foreign key (CS_ID) 
        references CONTENT_STREAM (id);

    alter table REPOSITORY_DEFINITION 
        add constraint UK_xqvd20ipg9a1qh4fb48oekvu unique (REPOSITORY_ID);

    alter table REPOSITORY_DEFINITION 
        add constraint UK_kamy1gwcod11baf33ml8f61jv unique (NAME);
