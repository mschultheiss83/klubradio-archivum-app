# Example Multi-Agent Workflow

This document demonstrates how the three agents (Claude, Gemini, OpenAI) coordinate to handle a GitHub issue.

## Example Issue

**Issue #456**: Add playlist feature to allow users to queue multiple episodes

**Labels**: `apple*`, `feature`, `ui`, `enhancement`

**Platforms**: All (Android, iOS, Windows, macOS, Linux, Web)

## Workflow Steps

### Step 1: OpenAI Coordinator Intake

OpenAI pulls the issue and delegates tasks:

```bash
# OpenAI runs
gh issue view 456

# Delegates:
# - Architecture/Risk Analysis → Claude
# - Technical Implementation → Gemini
```

Creates initial coordination file: `docs/agent-outputs/openai-456-consolidated.md`

### Step 2: Claude Performs Risk Analysis

Claude uses slash command in Claude Code CLI:

```bash
# In Claude Code CLI
/agent-risk
```

Or manually:

1. Uses Explore agent to understand current audio architecture
2. Analyzes data flows for AudioPlayerService
3. Reviews offline cache implications for playlists
4. Checks Provider dependencies
5. Identifies platform-specific concerns

Creates: `docs/agent-outputs/claude-456-risk-analysis.md`

**Key Findings**:
- Playlist needs persistence (new DB table)
- AudioPlayerService must handle queue state
- Offline playback: requires checking all episodes in playlist are downloaded
- Mobile: WiFi-only mode affects auto-download of playlist items
- Web: LocalStorage limitations for large playlists

**Handoff to Gemini**:
- Question: How to handle partially downloaded playlists?
- Question: Should playlist state sync across devices via Supabase?
- Recommendation: Use separate PlaylistDao, integrate with existing EpisodeProvider

### Step 3: Gemini Creates Implementation Plan

Gemini (in their environment) reads Claude's risk analysis and creates implementation plan.

Creates: `docs/agent-outputs/gemini-456-implementation.md`

**Implementation Steps**:

1. **Database Schema** (Phase 1):
   ```dart
   // New table: Playlists
   class Playlists extends Table {
     IntColumn get id => integer().autoIncrement()();
     TextColumn get name => text()();
     TextColumn get episodeIds => text()(); // JSON array
     DateTimeColumn get createdAt => dateTime()();
     DateTimeColumn get updatedAt => dateTime()();
   }
   ```
   - Run: `dart run build_runner build --delete-conflicting-outputs`

2. **DAO** (Phase 2):
   ```dart
   // lib/db/daos.dart - Add PlaylistDao
   class PlaylistDao extends DatabaseAccessor<AppDatabase> {
     // CRUD operations
   }
   ```

3. **Service** (Phase 3):
   ```dart
   // lib/services/playlist_service.dart - NEW
   class PlaylistService {
     Future<void> addToPlaylist(int playlistId, Episode episode);
     Future<void> removeFromPlaylist(int playlistId, int episodeId);
     Future<Playlist> getPlaylist(int playlistId);
     Stream<Playlist> watchPlaylist(int playlistId);
   }
   ```

4. **Provider** (Phase 4):
   ```dart
   // lib/providers/playlist_provider.dart - NEW
   class PlaylistProvider extends ChangeNotifier {
     // Integrates with EpisodeProvider and AudioPlayerService
   }
   ```

5. **UI** (Phase 5):
   - New screen: `lib/screens/playlist_screen/`
   - Add to AppShell navigation
   - l10n strings for 4 languages

6. **Tests** (Phase 6):
   - Unit tests for PlaylistDao
   - Unit tests for PlaylistService
   - Integration test for playlist playback

**Answers to Claude's Questions**:
- Partially downloaded: Display download status per episode, allow play downloaded only
- Sync across devices: YES, use Supabase playlists table (new API endpoint needed)

**Handoff back to Claude**: Please review architecture for playlist sync strategy

### Step 4: Claude Reviews Implementation

Claude runs in Claude Code CLI:

```bash
/agent-read-gemini
```

Reads `gemini-456-implementation.md` and provides feedback.

**Architectural Review**:

✅ **Approved**:
- PlaylistDao design looks good
- Integration with existing providers is clean
- Offline handling strategy is sound

⚠️ **Concerns**:
1. **Supabase Sync**:
   - Risk: Conflict resolution needed if user edits on multiple devices offline
   - Recommendation: Use last-write-wins with timestamp, or implement CRDT-like merging
   - Impact: Requires API design decision

2. **Retention Policy**:
   - Risk: What happens to playlist when episode is auto-deleted by retention policy?
   - Recommendation: Either keep episodes in playlists exempt, or remove from playlist on deletion
   - Impact: RetentionDao logic needs update

3. **State Management**:
   - Risk: AudioPlayerService now needs to coordinate with PlaylistProvider
   - Recommendation: Use ChangeNotifierProxyProvider to make AudioPlayerService listen to PlaylistProvider
   - Impact: Provider dependency chain update in main.dart

🚫 **Blocking Issue**:
- **Web Platform**: LocalStorage has 5-10MB limit. Large playlist with full episode metadata could exceed this.
  - **Must Address**: Either use IndexedDB for Web, or limit playlist metadata storage

Updates: `docs/agent-outputs/claude-456-risk-analysis.md` with review section

### Step 5: Gemini Addresses Concerns

Gemini updates implementation plan based on Claude's feedback:

**Updates to `gemini-456-implementation.md`**:

1. **Supabase Sync Conflict Resolution**:
   - Strategy: Last-write-wins with `updatedAt` timestamp
   - API endpoint: `POST /api/playlists/:id/sync`
   - Endpoint returns server version, client merges if needed

2. **Retention Policy Integration**:
   - Choice: Episodes in playlists are exempt from auto-deletion
   - Update: `lib/db/daos.dart` - RetentionDao.getEpisodesForDeletion() excludes playlist episodes
   - Test: Add test case for retention with playlists

3. **Provider Dependency Chain**:
   ```dart
   // lib/main.dart update
   ChangeNotifierProxyProvider2<PlaylistProvider, EpisodeProvider, AudioPlayerService>(
     create: (context) => AudioPlayerService(...),
     update: (context, playlist, episode, audio) {
       return audio..updatePlaylistState(playlist);
     }
   )
   ```

4. **Web Platform Fix**:
   - **Solution**: Use IndexedDB for Web platform via `idb_shim` package
   - Platform detection: `kIsWeb` from `package:flutter/foundation.dart`
   - Fallback: Limit playlist to 50 episodes on Web with warning

Updates: `docs/agent-outputs/gemini-456-implementation.md` with "Updated - Rev 2" section

### Step 6: OpenAI Consolidates & Approves

OpenAI reads both agent outputs and makes final decisions:

**Consolidated Plan - `openai-456-consolidated.md`**:

**Decision Matrix**:
- ✅ Approved: PlaylistDao and service architecture
- ✅ Approved: Last-write-wins sync strategy (good enough for v1)
- ✅ Approved: Retention policy exemption for playlist episodes
- ✅ Approved: IndexedDB for Web platform
- ⚠️ Defer: CRDT-like merging (future enhancement if needed)

**Action Plan**:
- **Phase 1-2**: Database & DAO (Gemini) - 2-3 hours
- **Phase 3-4**: Service & Provider (Gemini) - 3-4 hours
- **Phase 5**: UI Implementation (Gemini) - 4-5 hours
- **Phase 6**: Platform-specific (Gemini + Claude review for Web) - 2-3 hours
- **Phase 7**: Testing & QA (All agents) - 2-3 hours
- **Phase 8**: Deployment (All agents) - 1 hour

**Test Matrix**:
| Platform | Unit | Integration | Manual | Notes |
|----------|------|-------------|--------|-------|
| Android  | ✓    | ✓           | ✓      | Test WiFi-only |
| iOS      | ✓    | ✓           | ✓      | Test WiFi-only |
| macOS    | ✓    | ✓           | ✓      | Test entitlements |
| Windows  | ✓    | ✓           | ✓      | - |
| Web      | ✓    | ✓           | ✓      | Test IndexedDB |

**Risk Summary**:
- Low: Database schema (straightforward)
- Medium: Supabase sync (conflict handling simple)
- Medium: Web IndexedDB (requires extra testing)
- Low: UI implementation (standard patterns)

**Approval**: ✅ Ready for implementation

### Step 7: Implementation Execution

Gemini (or developer) follows the consolidated plan step-by-step.

Claude is available for architectural questions during implementation via:
```bash
/agent-read-gemini
/agent-handoff
```

### Step 8: Final Review & Deployment

After implementation:
1. Gemini marks all tasks complete in implementation plan
2. Claude does final architectural review
3. OpenAI coordinator signs off
4. PR created: `feature/playlist-support` → `dev`
5. Merge after code review
6. Update task tracking

## Benefits of This Workflow

1. **Clear Separation of Concerns**:
   - Claude focuses on architecture/risks
   - Gemini focuses on implementation
   - OpenAI coordinates and makes decisions

2. **Reduced Back-and-Forth**:
   - Structured handoffs prevent ping-pong
   - Maximum 2 exchanges per issue
   - OpenAI breaks deadlocks

3. **Comprehensive Coverage**:
   - Architecture risks identified early
   - Implementation details thoroughly planned
   - Platform matrix fully considered

4. **Deterministic Outputs**:
   - Clear action plans with specific commands
   - Testable success criteria
   - Rollback strategies defined

5. **Knowledge Transfer**:
   - All agent outputs documented
   - Future developers can read the decision rationale
   - Pattern can be reused for similar features

## Using Claude Code CLI for This Workflow

### As Claude Agent

```bash
# Start with exploration
/agent-explore

# Generate risk analysis for an issue
/agent-risk

# Read Gemini's plan and review
/agent-read-gemini

# Create handoff message
/agent-handoff
```

### Coordination with External Agents

1. **Gemini** (in their environment):
   - Reads: `docs/agent-outputs/claude-*-risk-analysis.md`
   - Writes: `docs/agent-outputs/gemini-*-implementation.md`

2. **OpenAI/Codex** (in their environment):
   - Reads: Both Claude and Gemini outputs
   - Writes: `docs/agent-outputs/openai-*-consolidated.md`

3. **File Sharing**:
   - Via git commits to feature branch
   - Or via shared folder (Dropbox, etc.)
   - Or via API/webhook integration

## Next Steps

To use this workflow in your project:

1. Read `agent.md` for full protocol details
2. Customize templates in `docs/agent-outputs/TEMPLATE-*.md` as needed
3. Set up external Gemini and OpenAI agents with their respective context files
4. Use Claude Code CLI slash commands to generate your analysis
5. Iterate based on agent feedback
6. Follow consolidated plan for implementation
