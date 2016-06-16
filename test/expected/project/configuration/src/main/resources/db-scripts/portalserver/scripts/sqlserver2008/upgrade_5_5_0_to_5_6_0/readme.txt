The database migration from 5.5.0 to 5.6.0 involves running the following steps in the order mentioned:

1. Create a backup of the database.

Run these steps before the new Portal Web Application has been deployed!
2. Run pre-upgrade-5.5.0-to-5.6.0.ddl
3. Run upgrade-5.5.0-to-5.6.0.dml
4. Run post-upgrade-5.5.0-to-5.6.0.ddl

If step 2, 3 or 4 fails contact Backbase Support.
If you need to rollback the migration install the database backup.

