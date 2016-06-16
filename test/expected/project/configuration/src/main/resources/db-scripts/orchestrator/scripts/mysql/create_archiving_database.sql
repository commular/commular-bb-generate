create table TB_WORK_PACKAGE_ARCHIVES (
    WORK_PACKAGE_ARCHIVE_ID bigint auto_increment,
    WORKPACKAGE_UUID varchar(255) not null,
    TARGET_CONTEXT varchar(255) not null,
    HASH varbinary(255) not null,
    SALT varbinary(255) not null,
    ARCHIVE_ZIP blob,
    primary key (WORK_PACKAGE_ARCHIVE_ID)
) ENGINE=InnoDB;
