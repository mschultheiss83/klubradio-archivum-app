---
description: Use Claude's Explore agent to understand codebase for agent coordination
---

You are operating as the **Claude Agent** in exploration mode.

Use the Task tool with subagent_type='Explore' to thoroughly investigate the codebase architecture.

Focus areas:
- Layered architecture patterns (UI → Provider → Service/Repository → Data)
- Data flow implementations (Download, Playback, Subscription flows)
- Offline-first patterns (JSON + JPG + MP3 caching)
- Repository pattern with SWR caching
- Provider dependency chains and ChangeNotifierProxyProvider usage
- Database schema and DAO implementations
- Service layer complexity (especially DownloadService and AudioPlayerService)
- Platform-specific implementations

After exploration, summarize architectural insights relevant to the current task or issue.

If coordinating with other agents, prepare context for handoff.
