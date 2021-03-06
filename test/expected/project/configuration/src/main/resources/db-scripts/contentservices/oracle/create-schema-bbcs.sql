
    create table CONTENT_STREAM (
        id number(19,0) not null,
        CONTENT blob not null,
        primary key (id)
    );

    create table OBJECT_DATA (
        id number(19,0) not null,
        path varchar2(765 char) not null,
        versionLabel varchar2(255 char),
        versionSeriesId varchar2(255 char),
        objectId varchar2(255 char) not null,
        isLatestVersion varchar2(255 char),
        OBJECT_TYPE_ID number(19,0) not null,
        PARENT_ID number(19,0),
        CS_ID number(19,0),
        RD_ID number(19,0) not null,
        uniquePathCheck varchar2(64 char) not null,
        primary key (id)
    );

    create table OBJECT_TYPE_DEFINITION (
        id number(19,0) not null,
        baseType varchar2(255 char) not null,
        contentStreamAllowed varchar2(255 char),
        creatable number(1,0),
        description varchar2(255 char),
        displayName varchar2(255 char),
        fileable number(1,0),
        fullTextIndexed number(1,0),
        localName varchar2(255 char),
        localNamespace varchar2(255 char),
        objectId varchar2(255 char) not null,
        PARENT_ID number(19,0),
        RD_ID number(19,0) not null,
        queryName varchar2(255 char),
        queryable number(1,0),
        versionable number(1,0),
        primary key (id)
    );

    create table PROPERTY_DATA (
        id number(19,0) not null,
        displayName varchar2(255 char),
        localName varchar2(255 char),
        OBJECT_DATA_ID number(19,0) not null,
        objectId varchar2(255 char) not null,
        PROPERTY_DEFINITION_ID number(19,0) not null,
        queryName varchar2(255 char),
        value varchar2(765 char),
        primary key (id)
    );

    create table PROPERTY_DEFINITION (
        id number(19,0) not null,
        cardinality varchar2(255 char),
        description varchar2(255 char),
        displayName varchar2(255 char),
        inherited number(1,0),
        localName varchar2(255 char),
        localNamespace varchar2(255 char),
        objectId varchar2(255 char) not null,
        OBJECT_TYPE_ID number(19,0) not null,
        orderable number(1,0),
        queryName varchar2(255 char),
        queryable number(1,0),
        required number(1,0) not null,
        type varchar2(255 char) not null,
        updatability varchar2(255 char),
        primary key (id)
    );

    create table RELATIONSHIPS (
        id number(19,0) not null,
        objectId varchar2(255 char) not null,
        sourceId number(19,0),
        targetRepositoryId varchar2(255 char) not null,
        targetObjectId varchar2(255 char) not null,
        relationshipType varchar2(255 char) not null,
        primary key (id)
    );

    create table RENDITION (
        id number(19,0) not null,
        filePath varchar2(765 char),
        height number(19,2),
        kind varchar2(255 char),
        length number(19,2),
        mimeType varchar2(255 char),
        OBJECT_DATA_ID number(19,0) not null,
        renditionDocumentId varchar2(255 char),
        title varchar2(255 char),
        width number(19,2),
        objectId varchar2(255 char) not null,
        streamId varchar2(255 char) not null,
        CS_ID number(19,0),
        primary key (id)
    );

    create table REPOSITORY_DEFINITION (
        id number(19,0) not null,
        REPOSITORY_ID varchar2(255 char) not null,
        NAME varchar2(255 char) not null,
        DESCRIPTION varchar2(255 char),
        VENDOR_NAME varchar2(255 char),
        PRODUCT_NAME varchar2(255 char),
        PRODUCT_VERSION varchar2(255 char) not null,
        primary key (id)
    );

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
        references OBJECT_TYPE_DEFINITION;

    alter table OBJECT_DATA 
        add constraint FK_mhp750onsg14deqsc5mkp4dx 
        foreign key (PARENT_ID) 
        references OBJECT_DATA;

    alter table OBJECT_DATA 
        add constraint FK_i6hwfpq7ppvktiim2thpqxiac 
        foreign key (CS_ID) 
        references CONTENT_STREAM;

    alter table OBJECT_DATA 
        add constraint FK_6gu2if5arkmusbvrssixki55r 
        foreign key (RD_ID) 
        references REPOSITORY_DEFINITION;

    create index FK_OD_IDX_OTD_RD_REPOID on OBJECT_TYPE_DEFINITION (RD_ID);

    create index FK_OTD_IDX_PARENT on OBJECT_TYPE_DEFINITION (PARENT_ID);

    alter table OBJECT_TYPE_DEFINITION 
        add constraint FK_83a12dvjdi2psds4t3pfrwbfb 
        foreign key (PARENT_ID) 
        references OBJECT_TYPE_DEFINITION;

    alter table OBJECT_TYPE_DEFINITION 
        add constraint FK_luq75uv8ksxyjp0t3v16jkanx 
        foreign key (RD_ID) 
        references REPOSITORY_DEFINITION;

    create index FK_PD_IDX_OBJECT_DATA_ID on PROPERTY_DATA (OBJECT_DATA_ID);

    create index FK_PD_IDX_OBJECTID on PROPERTY_DATA (objectId);

    create index FK_PD_IDX_PROP_DEF_ID on PROPERTY_DATA (PROPERTY_DEFINITION_ID);

    alter table PROPERTY_DATA 
        add constraint FK_r5pfq0qmo565nb85q01q6r5og 
        foreign key (OBJECT_DATA_ID) 
        references OBJECT_DATA;

    alter table PROPERTY_DATA 
        add constraint FK_c2yshju50dy6nutodteogo28t 
        foreign key (PROPERTY_DEFINITION_ID) 
        references PROPERTY_DEFINITION;

    create index FK_PDEF_IDX_OBJ_ID on PROPERTY_DEFINITION (objectId);

    create index FK_PDEF_IDX_OBJECT_TYPE_ID on PROPERTY_DEFINITION (OBJECT_TYPE_ID);

    alter table PROPERTY_DEFINITION 
        add constraint FK_s6scxspskrpjulqsj4u98us2g 
        foreign key (OBJECT_TYPE_ID) 
        references OBJECT_TYPE_DEFINITION;

    create index REL_TARGET_IDX on RELATIONSHIPS (targetRepositoryId, targetObjectId);

    alter table RELATIONSHIPS 
        add constraint FK_cwor9qcw8nm14qawhqtatfhbc 
        foreign key (sourceId) 
        references OBJECT_DATA;

    create index FK_RND_IDX_OBJECT_DATA_ID on RENDITION (OBJECT_DATA_ID);

    create index FK_RND_IDX_CONTENT_STREAM_ID on RENDITION (CS_ID);

    alter table RENDITION 
        add constraint FK_aw8vtq9lh7ehwfu0oc30q0hqn 
        foreign key (OBJECT_DATA_ID) 
        references OBJECT_DATA;

    alter table RENDITION 
        add constraint FK_l7rl4ulhh823p0t9oswg761c9 
        foreign key (CS_ID) 
        references CONTENT_STREAM;

    alter table REPOSITORY_DEFINITION 
        add constraint UK_xqvd20ipg9a1qh4fb48oekvu unique (REPOSITORY_ID);

    alter table REPOSITORY_DEFINITION 
        add constraint UK_kamy1gwcod11baf33ml8f61jv unique (NAME);

    create sequence hibernate_sequence;
