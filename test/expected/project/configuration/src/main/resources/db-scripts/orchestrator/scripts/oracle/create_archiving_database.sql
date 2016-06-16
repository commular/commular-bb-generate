create table TB_WORK_PACKAGE_ARCHIVES (
    WORK_PACKAGE_ARCHIVE_ID NUMBER(19,0) not null,
    WORKPACKAGE_UUID nvarchar2(255) not null,
    TARGET_CONTEXT nvarchar2(255) not null,
    HASH raw(255) not null,
    SALT raw(255) not null,
    ARCHIVE_ZIP blob,
    primary key (WORK_PACKAGE_ARCHIVE_ID)
);
