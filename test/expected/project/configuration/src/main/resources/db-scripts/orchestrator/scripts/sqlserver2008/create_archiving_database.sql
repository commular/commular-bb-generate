create table TB_WORK_PACKAGE_ARCHIVES (
    WORK_PACKAGE_ARCHIVE_ID numeric(19,0) identity not null,
    WORKPACKAGE_UUID nvarchar(255) not null,
    TARGET_CONTEXT nvarchar(255) not null,
    HASH varbinary(255) not null,
    SALT varbinary(255) not null,
    ARCHIVE_ZIP varbinary(max),
    primary key (WORK_PACKAGE_ARCHIVE_ID)
)
GO