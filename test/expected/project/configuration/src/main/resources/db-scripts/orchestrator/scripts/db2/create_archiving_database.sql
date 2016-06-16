create table TB_WORK_PACKAGE_ARCHIVES (
    WORK_PACKAGE_ARCHIVE_ID bigint not null,
    WORKPACKAGE_UUID nvarchar(255) not null,
    TARGET_CONTEXT nvarchar(255) not null,
    HASH blob not null,
    SALT blob not null,
    ARCHIVE_ZIP blob,
    primary key (WORK_PACKAGE_ARCHIVE_ID)
);