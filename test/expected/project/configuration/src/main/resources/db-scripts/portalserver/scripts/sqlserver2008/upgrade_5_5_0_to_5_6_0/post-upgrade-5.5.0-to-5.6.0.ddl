CREATE UNIQUE NONCLUSTERED index IDX_TAG_NAME_CTX_TYPE on tags (upper(name), contextItemName, type)
GO