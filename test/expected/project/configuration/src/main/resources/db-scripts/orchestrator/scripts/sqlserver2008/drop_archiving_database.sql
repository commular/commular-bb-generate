if exists (select 1 from sysobjects where name='TB_WORK_PACKAGE_ARCHIVES')
  drop table TB_WORK_PACKAGE_ARCHIVES
GO
