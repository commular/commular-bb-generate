create table TB_WORK_PACKAGE_ARCHIVES (
    WORK_PACKAGE_ARCHIVE_ID bigint not null,
    WORKPACKAGE_UUID varchar(255) not null,
    TARGET_CONTEXT varchar(255) not null,
    HASH blob not null,
    SALT blob not null,
    ARCHIVE_ZIP blob,
    primary key (WORK_PACKAGE_ARCHIVE_ID)
);