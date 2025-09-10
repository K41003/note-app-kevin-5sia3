# TODO: Fix SQLite createdAt Column Error

## Completed Tasks
- [x] Identified the issue: Typo in database schema ("createAt" instead of "createdAt")
- [x] Fixed the createNoteTable SQL to use "createdAt"
- [x] Incremented database version to 2
- [x] Added onUpgrade logic to rename column from "createAt" to "createdAt"

## Next Steps
- [ ] Restart the Flutter app to trigger database migration
- [ ] Test creating a new note to verify the fix
- [ ] If issues persist, consider deleting the database file for fresh start
