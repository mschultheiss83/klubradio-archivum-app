---
tags: [docs, project, database, drift]
---

# Database Migration Strategy

## Current Phase: Pre-Release (with testers)

Since testers are actively using the app, we cannot ask them to manually delete their database files. Instead, Drift's `onUpgrade` callback handles schema changes automatically with a **destructive drop+recreate** strategy.

### How It Works

In `lib/db/app_database.dart`:

```dart
@override
int get schemaVersion => 2; // bump on every schema change

@override
MigrationStrategy get migration => MigrationStrategy(
      onCreate: (m) => m.createAll(),
      onUpgrade: (m, from, to) async {
        // Pre-release: drop all tables and recreate from scratch.
        for (final table in allTables) {
          await m.deleteTable(table.actualTableName);
        }
        await m.createAll();
      },
    );
```

- **Fresh install**: `onCreate` runs, creates all tables normally.
- **Existing install with older schema**: `onUpgrade` drops every table and recreates them. All local data (subscriptions, download state, settings) is lost — acceptable pre-release.

### When Changing the Schema

1. Edit the table definitions in `lib/db/app_database.dart`
2. Bump `schemaVersion` (e.g. `2` -> `3`)
3. Run code generation: `dart run build_runner build --delete-conflicting-outputs`
4. Test: `flutter test`

That's it. No migration SQL to write. The destructive `onUpgrade` handles everything.

### What Testers Experience

On the next app launch after a schema bump, the database resets silently. Subscriptions and download history are lost, but since we're pre-release this is acceptable. Downloaded MP3 files on disk are **not** deleted (only DB rows are dropped).

## Post-Release: Incremental Migrations

After the first public release, switch to incremental migrations:

```dart
onUpgrade: (m, from, to) async {
  if (from < 3) {
    await m.addColumn(episodes, episodes.someNewColumn);
  }
  if (from < 4) {
    await m.createTable(someNewTable);
  }
},
```

Each migration step must be documented and tested. Keep the destructive strategy in a comment for reference during development.

## Schema Version History

| Version | Date       | Changes |
|---------|------------|---------|
| 1       | pre-2026-03-26 | Initial schema (subscriptions, episodes, settings) |
| 2       | 2026-03-26 | Added destructive migration strategy, no table changes |
