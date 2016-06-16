insert into
PROPERTY_DEFINITION (cardinality, displayName, localName, localNamespace, objectId, OBJECT_TYPE_ID, queryName, required, type, updatability)
values
('single', 'Status', 'bb:status', 'http://docs.oasis-open.org/ns/cmis/core/200908/', 'bb:status',(select id from OBJECT_TYPE_DEFINITION where objectId='bb:versionhistory'), 'bb:status', 0, 'string', 'oncreate');

insert into
PROPERTY_DEFINITION (cardinality, displayName, localName, localNamespace, objectId, OBJECT_TYPE_ID, queryName, required, type, updatability)
values
('single', 'Approval Message', 'bb:approvalMessage', 'http://docs.oasis-open.org/ns/cmis/core/200908/', 'bb:approvalMessage',(select id from OBJECT_TYPE_DEFINITION where objectId='bb:versionhistory'), 'bb:approvalMessage', 0, 'string', 'oncreate');