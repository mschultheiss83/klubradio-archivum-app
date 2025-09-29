# klubradio_archivum
## SETUP



## Project Summary: Offline Podcast Download and Playback
1. Feature Goal
   To enable users to download podcast episodes for persistent offline playback. This feature requires stable background downloading, secure metadata storage, and robust local file management across various platforms.

2. Technical Requirements Checklist
   The following items detail the technical implementation strategy, covering dependencies, system integration, and data persistence.

2.1 Core Setup & Dependencies

| Task | Details                                                                                                                                                                |
|------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Package Integration | Integrate background_downloader for asynchronous, resilient downloads and path_provider for reliable cross-platform file path resolution.                              |
| Firebase Auth Setup | Ensure the Firebase SDK is initialized and the current user's unique identifier (userId) is available for securing private data in Firestore.                          |
| Permissions Handling | Implement run-time permission requests to secure necessary storage access, crucial for Android (especially scoped storage) and defining desktop file access locations. |
| Define Storage Path | Utilize path_provider to establish a dedicated, permanent storage directory for all downloaded media files.                                                            |

2.2 Download Orchestration

| Task | Details                                                                                                                                                                                                                |
|------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Batch Download Logic | Develop a function to automatically enqueue a default batch of 25 tasks (5 latest episodes from 5 selected podcasts) for immediate background download.                                                                |
| Task Monitoring | Implement a dedicated listener (using background_downloader's capabilities) to continuously monitor the progress, status, and completion of all queued and active downloads, updating the user interface in real-time. |

2.3 Data Persistence & State

| Task | Details                                                                                                                                                                                                                                                              |
|------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Firestore Metadata | For each download task, persist crucial metadata (original URL, local file path, and download task ID) in a private user collection: /artifacts/__app_id/users/{userId}/downloads. This ensures download state and file locations are preserved across app sessions. |
| Playback Integration | Modify the core media playback logic to prioritize the local file path stored in Firestore metadata over network streaming when an episode is marked as fully downloaded.                                                                                            |

2.4 User Experience & Management

| Task | Details                                                                                                                                                                        |
|------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Error/Resume UI | Design and implement UI components within the download manager to clearly indicate failed downloads and allow users to manually pause, resume, or retry specific tasks.        |
| Storage Management | Create a feature that allows users to selectively delete local episode files and concurrently remove the corresponding metadata from Firestore to free up local storage space. |



## Project Focus: Supabase-Backed Download Manager

This revised plan focuses on integrating the `background_downloader` package with Supabase for user authentication and persistent task storage.

## I. Core `background_downloader` Integration

| Step | Detail | Status |
|------|--------|--------|
| 1. Package Integration | Add `background_downloader` to `pubspec.yaml`. Handle necessary platform configuration (e.g., iOS `info.plist`, AndroidManifest permissions). | [ ] |
| 2. Permissions Handling | Implement request logic for necessary storage permissions (especially on Android). | [ ] |
| 3. Define Storage Path | Determine and configure the correct platform-specific storage directory (e.g., `getApplicationDocumentsDirectory()` or `getExternalStorageDirectory()` for downloads). | [ ] |
| 4. Batch Download Logic | Create a function to accept a list of URLs and start them as individual or grouped `DownloadTask` objects. | [ ] |
| 5. Task Monitoring | Implement the `background_downloader` callback system to listen for changes in `TaskStatus` and `TaskProgress`. | [ ] |
| 6. Task Actions | Implement UI functions for user control: Pause, Resume, Cancel, and Delete (both task and local file). | [ ] |

## II. Supabase Backend and State Management

| Step | Detail | Status |
|------|--------|--------|
| 7. Supabase Project Setup | Initialize the Supabase project. Create a `downloads` table with required columns (e.g., `user_id`, `task_id`, `file_url`, `status`, `progress`, `path_local`). | [ ] |
| 8. Supabase Initialization & Auth | Initialize the Supabase client in the Flutter app. Implement sign-in/sign-up and retrieve the current user's ID using `supabase.auth.currentUser!.id`. | [ ] |
| 9. Task Metadata Storage | Immediately upon starting a download, insert the task metadata (ID, URL, user ID, initial status) into the `downloads` table. | [ ] |
| 10. Real-Time Status Sync | Use Supabase Realtime to subscribe to changes on the `downloads` table, filtered by the logged-in user's ID, to populate the main UI list. | [ ] |
| 11. Task Status Update | Within the `background_downloader` callbacks, use the Supabase client to update the corresponding row's `status`, `progress`, and `path_local` in real-time. | [ ] |

## III. User Interface (UI) and Experience

| Step | Detail | Status |
|------|--------|--------|
| 12. Main Task List UI | Build a scrollable list view that displays all tasks, showing URL/file name, status (e.g., "Downloading 50%", "Complete", "Paused"), and progress bar. | [ ] |
| 13. Playback Integration | If the file type is detected as playable (e.g., MP3, MP4), add a "Play" button that launches the file using a suitable Flutter package (e.g., `audioplayers` or `video_player`). | [ ] |
| 14. Error & Resume UI | Clearly display error messages and provide a visible "Retry/Resume" button for failed or paused tasks. | [ ] |
| 15. Storage Management | Implement a simple mechanism (e.g., a button on completed tasks) to permanently delete the task record from the `downloads` table and the file from local storage. | [ ]

## update i10n run
    
`flutter gen-l10n`


## Setup Note:
For a podcast app, ensure you configure the storage location to a directory 
that is suitable for large media files and accessible to your player.