-- Table codes for FK/Index names

-- TB_APPROVAL_JOBS - AJBS
-- TB_AFFECTED_PAGES - APGS
-- TB_CONTENT_REFERENCES - CRS
-- TB_ITEM_REFERENCES - IRS
-- TB_HOSTS - HTS
-- TB_PUBLISHING_JOBS - PJS
-- TB_PUBLISHREQUESTS - PRQS
-- TB_PUBLISH_RESULTS - PRTS
-- TB_PUBLISH_RESULT_ITEMS - PRTI
-- TB_PUBLISH_RESULT_ITEM_LOGS - PRTIL
-- TB_WORK_PACKAGES -WPS
-- TB_IDENTITY_MAPPING - IMG
-- TB_WORK_PACKAGE_BUNDLES - WPB

-- FK_NAME = (FK)_(TABLE-1-CODE)_(TABLE-2-CODE)_(NUMBER-FK-BETWEEN-TABLES)
-- INDEX_NAME = (IDX)_(TABLE-NAME)_(FIELD_INDICATOR)

-- will be executed by mvn sql plugin before deploy orchestrator

create table TB_AFFECTED_PAGES (
    AFFECTED_PAGE_ID bigint not null,
    PAGE_NAME varchar(255) not null,
    PUBLISH_REQUEST_ID bigint not null,
    primary key (AFFECTED_PAGE_ID)
);

create table TB_APPROVAL_JOBS (
    APPROVALJOB_ID bigint not null,
    STATE varchar(255) not null,
    REQUEST_DATE timestamp,
    APPROVER_USER_ID varchar(255),
    DESCRIPTION varchar(1023),
    SUBJECT varchar(64),
    UUID varchar(255) not null,
    PUBLISH_REQUEST_ID bigint,
    HOST_ID bigint,
    WORKPACKAGE_ID bigint,
    primary key (APPROVALJOB_ID),
    unique(UUID)
);

create table TB_CONTENT_REFERENCES (
    CONTENT_REFERENCE_ID bigint not null,
    CMIS_UID varchar(255) not null,
    CONTEXT varchar(255) not null,
    TITLE varchar(255),
    PUBLISH_REQUEST_ID bigint,
    primary key (CONTENT_REFERENCE_ID)
);

create table TB_HOSTS (
    DTYPE varchar(31) not null,
    HOST_ID bigint not null,
    HOST varchar(255) not null,
    CONTEXT_PATH varchar(255) not null,
    TYPE varchar(255) not null,
    NAME varchar(255) not null,
    PORT smallint not null,
    LOCK_STRATEGY varchar(255),
    REPOSITORY_ID varchar(255),
    primary key (HOST_ID)
);

create table TB_ITEM_REFERENCES (
    DTYPE varchar(31) not null,
    ITEM_REFERENCE_ID bigint not null,
    CONTEXT__ITEM_NAME varchar(255) not null,
    ITEM_NAME varchar(255) not null,
    ITEM_TYPE varchar(255) not null,
    ITEM_TITLE varchar(255),
    MODIFIED_AFTER_LAST_PUBLISH smallint,
    PUBLISH_ACTION_TYPE varchar(255),
    PUBLISH_REQUEST_ID bigint,
    LAST_MODIFIED_TS timestamp,
    PUBLISH_STATE varchar(255),
    RESOLVING_STRATEGY varchar(255),
    primary key (ITEM_REFERENCE_ID)
);

create table TB_PUBLISHING_JOBS (
    PUBLISHING_JOB_ID bigint not null,
    DISCRIMINATOR varchar(4) not null,
    CREATED_DATE timestamp,
    FINISHED_DATE timestamp,
    MESSAGE varchar(255),
    ORCHESTRATOR_REQUIRES_APPROVAL smallint not null,
    UPDATE_PUBLISH_STATES smallint,
    STATE varchar(255) not null,
    STARTED_DATE timestamp,
    UUID varchar(255) not null,
    TARGET_REPOSITORY varchar(255),
    PARENT_PUBLISHING_JOB_ID bigint,
    PUBLISH_REQUEST_ID bigint,
    ROOT_WORKPACKAGE_ID bigint not null,
    HOST_ID bigint,
    TARGET_PORTAL_SERVER_ID bigint,
    TARGET_PORTAL varchar(255) not null,
    WORKPACKAGE_ID bigint,
    WORK_PACKAGE_PUBLISHING_JOB_ID bigint,
    PUBLISH_RESULT_ID bigint,
    primary key (PUBLISHING_JOB_ID)
);

create table TB_PUBLISHREQUESTS (
    PUBLISH_REQUEST_ID bigint not null,
    DESCRIPTION varchar(1023),
    REQUEST_DATE timestamp not null,
    REQUESTER_USER_ID varchar(255) not null,
    UUID varchar(255) not null,
    SOURCE_ITEM_REFERENCE_ID bigint not null,
    WORKPACKAGE_ID bigint not null,
    PUBLISH_ORDER integer null,
    primary key (PUBLISH_REQUEST_ID),
    unique (UUID)
);

create table TB_PUBLISH_RESULTS (
    PUBLISH_RESULT_ID bigint not null,
    BUNDLE_ID varchar(255),
    BUNDLE_NAME varchar(255),
    HAS_ERRORS smallint,
    primary key (PUBLISH_RESULT_ID)
);

create table TB_PUBLISH_RESULT_ITEMS (
    PUBLISH_RESULT_ITEM_ID bigint not null,
    BUNDLE_ID varchar(255),
    CONTEXT_ITEM_NAME varchar(255),
    HAS_ERRORS smallint,
    ITEM_NAME varchar(255),
    ITEM_TYPE varchar(255),
    PUBLISH_RESULT_ID bigint not null,
    primary key (PUBLISH_RESULT_ITEM_ID)
);

create table TB_PUBLISH_RESULT_ITEM_LOGS (
    PUBLISH_RESULT_ITEM_LOG_ID bigint not null,
    LOG_LEVEL varchar(255),
    MESSAGE clob,
    LOG_TYPE varchar(255),
    PUBLISH_RESULT_ITEM_ID bigint not null,
    primary key (PUBLISH_RESULT_ITEM_LOG_ID)
);

create table TB_WORK_PACKAGES (
    WORKPACKAGE_ID bigint not null,
    CREATION_DATE timestamp,
    DESCRIPTION varchar(1023),
    PORTAL_NAME varchar(255) not null,
    REPOSITORY_REFERENCE varchar(255),
    PUBLICATION_DATE timestamp,
    STATUS_CHANGE_DATE timestamp,
    PUBLISH_CHAIN_NAME varchar(255),
    PUBLISH_RESULT_ID bigint,
    SERVER_NAME varchar(255) not null,
    STAGING_PUBLICATION_DATE timestamp,
    UUID varchar(255) not null,
    CONTEXT_TYPE varchar(255) not null,
    WORKPACKAGE_NAME varchar(255),
    OWNER_USER_ID varchar(255),
    STATE varchar(255) not null,
    SCHEDULED_DATE timestamp,
    primary key (WORKPACKAGE_ID),
    unique (UUID)
);

create table TB_WORK_PACKAGE_LOGS (
    WORKPACKAGE_LOG_ID bigint not null,
    TIMESTAMP timestamp not null,
    LOG_LEVEL varchar(255),
    MESSAGE varchar(255),
    LOG_CODE varchar(255),
    PORTAL varchar(255),
    HOST varchar(255),
    WORKPACKAGE_ID bigint not null,
    primary key (WORKPACKAGE_LOG_ID)
);

create table TB_IDENTITY_MAPPING  (
    IDENTITY_MAPPING_ID bigint not null,
    SOURCE_IDENTITY varchar(255),
    TARGET_CONTEXT varchar(255),
    TARGET_IDENTITY varchar (255),
    primary key (IDENTITY_MAPPING_ID)
);

create table TB_WORK_PACKAGE_BUNDLES (
    WORK_PACKAGE_BUNDLE_ID bigint not null,
    WORKPACKAGE_ID bigint not null,
    TARGET_CONTEXT varchar(255) not null,
    HASH blob not null,
    SALT blob not null,
    primary key (WORK_PACKAGE_BUNDLE_ID)
);

create index IDX_APGS_PRQ_ID ON TB_AFFECTED_PAGES (PUBLISH_REQUEST_ID);
alter table TB_AFFECTED_PAGES
    add constraint FK5FDE7509154510F foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS;

create index IDX_APJS_HST_ID ON TB_APPROVAL_JOBS (HOST_ID);
alter table TB_APPROVAL_JOBS
    add constraint FK5FDA7609854516A foreign key (HOST_ID)
    references TB_HOSTS;

create index IDX_APJS_PRQ_ID ON TB_APPROVAL_JOBS (PUBLISH_REQUEST_ID);
alter table TB_APPROVAL_JOBS
    add constraint FK5FD37406154710C foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS;

create index IDX_APJS_WPG_ID ON TB_APPROVAL_JOBS (WORKPACKAGE_ID);
alter table TB_APPROVAL_JOBS
    add constraint FK5FD35409154610B foreign key (WORKPACKAGE_ID)
    references TB_WORK_PACKAGES;

create index IDX_CRS_PRQ_ID ON TB_CONTENT_REFERENCES (PUBLISH_REQUEST_ID);
alter table TB_CONTENT_REFERENCES
    add constraint FK5FD35469854812C foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS;

create index IDX_IRS_PRQ_ID ON TB_ITEM_REFERENCES (PUBLISH_REQUEST_ID);
alter table TB_ITEM_REFERENCES
    add constraint FK5FB3C479854912A foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS;

create index IDX_PJS_HST_ID ON TB_PUBLISHING_JOBS (HOST_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK5F54C779884992B foreign key (HOST_ID)
    references TB_HOSTS;

create index IDX_PJS_WPG_ID ON TB_PUBLISHING_JOBS (WORKPACKAGE_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK5F54C679984090B foreign key (WORKPACKAGE_ID)
    references TB_WORK_PACKAGES;

create index IDX_PJS_PR_ID ON TB_PUBLISHING_JOBS (PUBLISH_REQUEST_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PRS foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS;

create index IDX_PJS_PRT_PGJ_ID ON TB_PUBLISHING_JOBS (PARENT_PUBLISHING_JOB_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK5F64C074944792A foreign key (PARENT_PUBLISHING_JOB_ID)
    references TB_PUBLISHING_JOBS;

create index IDX_PJS_PRT_WPPJ_ID ON TB_PUBLISHING_JOBS (WORK_PACKAGE_PUBLISHING_JOB_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PJS foreign key (WORK_PACKAGE_PUBLISHING_JOB_ID)
    references TB_PUBLISHING_JOBS;

create index IDX_PJS_PRT_ID ON TB_PUBLISHING_JOBS (PUBLISH_RESULT_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PRT foreign key (PUBLISH_RESULT_ID)
    references TB_PUBLISH_RESULTS;

create index IDX_PRQS_WPG_ID on TB_PUBLISHREQUESTS (WORKPACKAGE_ID);
alter table TB_PUBLISHREQUESTS
    add constraint FK5F649044948702C foreign key (WORKPACKAGE_ID)
    references TB_WORK_PACKAGES;

create index IDX_PRQS_SRC_IR_ID on TB_PUBLISHREQUESTS (SOURCE_ITEM_REFERENCE_ID);
alter table TB_PUBLISHREQUESTS
    add constraint FK5F640041948792E foreign key (SOURCE_ITEM_REFERENCE_ID)
    references TB_ITEM_REFERENCES(ITEM_REFERENCE_ID);

create index IDX_WPGS_PRT_ID on TB_WORK_PACKAGES (PUBLISH_RESULT_ID);
alter table TB_WORK_PACKAGES
    add constraint FK54941041948387E foreign key (PUBLISH_RESULT_ID)
    references TB_PUBLISH_RESULTS;

create index IDX_PRTI_PRT_ID on TB_PUBLISH_RESULT_ITEMS (PUBLISH_RESULT_ID);
alter table TB_PUBLISH_RESULT_ITEMS
    add constraint FK14541992940387E foreign key (PUBLISH_RESULT_ID)
    references TB_PUBLISH_RESULTS;

create index IDX_PRTIL_PRTI_ID on TB_PUBLISH_RESULT_ITEM_LOGS (PUBLISH_RESULT_ITEM_ID);
alter table TB_PUBLISH_RESULT_ITEM_LOGS
    add constraint FK12501992946387C foreign key (PUBLISH_RESULT_ITEM_ID)
    references TB_PUBLISH_RESULT_ITEMS;

create index IDX_WPB_WPS_ID on TB_WORK_PACKAGE_BUNDLES (WORKPACKAGE_ID);
alter table TB_WORK_PACKAGE_BUNDLES
    add constraint FK_WPB_WPS_1 foreign key (WORKPACKAGE_ID)
    references TB_WORK_PACKAGES;

create sequence hibernate_sequence;