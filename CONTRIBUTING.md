# Contributing to Klubrádió Archive App

Welcome to the **Klubrádió Archive App** project! We’re building a cross-platform Flutter app to make Klubrádió’s archive broadcasts (https://www.klubradio.hu/archivum) accessible as podcast-style RSS feeds with in-app playback and automatic downloading of subscribed shows. Your contributions—whether code, bug reports, or ideas—are greatly appreciated and help bring this free, community-driven project to life.

This project respects Klubrádió’s policy of free content access (“hanganyagai szabadon meghallgathatók és letölthetők”) and aims to create a seamless experience for Hungarian-speaking radio fans and podcast enthusiasts. Join us in making this app better!

## Table of Contents
- [How to Contribute](#how-to-contribute)
- [Setting Up the Development Environment](#setting-up-the-development-environment)
- [Running the Scraper Script Locally](#running-the-scraper-script-locally)
- [Submitting Bug Reports](#submitting-bug-reports)
- [Submitting Feature Requests](#submitting-feature-requests)
- [Submitting Pull Requests](#submitting-pull-requests)
- [Code of Conduct](#code-of-conduct)

## How to Contribute
We welcome contributions in many forms:
- **Code**: Add features, fix bugs, or improve performance.
- **Documentation**: Enhance this file, the README, or in-app help text.
- **Testing**: Report bugs or test on different devices (iOS/Android).
- **Ideas**: Suggest new features or improvements via GitHub Issues.
- **Promotion**: Share the project on social media (e.g., X) or Hungarian forums.

Before contributing, please read this guide and follow the steps below to ensure a smooth process.

## Setting Up the Development Environment

The project consists of two main parts:
1.  A **Flutter App** for the user interface (iOS/Android).
2.  A **Backend Scraper** that runs via GitHub Actions to fetch data and populate our Supabase database.

Follow these steps to set up your local environment for both.

### Part 1: Flutter App Setup

1.  **Prerequisites**:
    *   Flutter SDK, Dart, IDE, Emulators/Devices, Git.
2.  **Clone the Repository**:
    ```bash
    git clone https://github.com/mschultheiss83/klubradio-archivum-app.git
    cd klubradio-archivum-app
    ```
3.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```
    Key dependencies include:
    *   `supabase_flutter`: For connecting to the Supabase backend to fetch data.
    *   `just_audio`: For audio playback.
    *   `hive`: For local caching to reduce API calls and support offline mode.
    *   `path_provider`: For managing downloaded audio files.
4.  **Connect to Supabase**:
    *   You will need a free Supabase account to test changes.
    *   Create a `.env` file in the root of the project and add your Supabase public URL and anon key. **Do not commit this file.**
      ```
      SUPABASE_URL=https://your-project-ref.supabase.co
      SUPABASE_ANON_KEY=your-public-anon-key
      ```
5.  **Run the App**:
    ```bash
    flutter run
    ```

### Part 2: Backend Scraper Setup

The scraper is a Python script that runs automatically via GitHub Actions. To test it locally, you need to set up a Python environment.

1.  **Prerequisites**:
    *   **Python 3.9+**: Install from the [official Python website](https://www.python.org/downloads/).
    *   **Supabase Project**: You should have a free Supabase project set up.
2.  **Navigate to the Scraper Directory**:
    ```bash
    cd backend  # Assuming the scraper lives in a 'backend' folder
    ```
3.  **Create a Virtual Environment**:
    ```bash
    python -m venv venv
    source venv/bin/activate  # On Windows, use `venv\Scripts\activate`
    ```
4.  **Install Python Dependencies**:
    ```bash
    pip install -r requirements.txt
    ```
    Key dependencies will include:
    *   `supabase`: The official Python client for Supabase.
    *   `requests`: For making HTTP requests to the Klubrádió website.
    *   `beautifulsoup4`: For parsing the HTML content.
5.  **Set Environment Variables**:
    *   You'll need to provide your Supabase URL and **Service Role Key** to allow the script to write to the database. Store these in a local `.env` file in the `backend` directory.
      ```
      SUPABASE_URL=https://your-project-ref.supabase.co
      SUPABASE_SERVICE_KEY=your-secret-service-role-key
      ```

## Running the Scraper Script Locally

The scraper fetches data from the Klubrádió archive, generates RSS feeds, and uploads everything to Supabase.

1.  **Ensure Setup is Complete**: Make sure you have completed the "Backend Scraper Setup" steps above.
2.  **Run the Script**:
    *   From the `backend` directory, with your virtual environment activated, run the main scraper file:
      ```bash
      python scraper.py
      ```
3.  **Verify Output**:
    *   **Check the Console**: The script should log its progress (e.g., "Fetching page...", "Found 10 new episodes", "Uploading to Supabase...").
    *   **Check Supabase DB**: Go to your Supabase project's Table Editor. You should see new rows populated in your `shows` table.
    *   **Check Supabase Storage**: Go to the Storage section. You should see the generated `.xml` RSS feeds in your `feeds` bucket.
4.  **Guidelines for Testing**:
    *   The script is designed to be run infrequently. Avoid running it in a rapid loop to be respectful of Klubrádió's servers.
    *   When making changes, focus on improving the parsing logic's resilience or adding new data fields.

## Submitting Bug Reports
Found a bug? Help us fix it by submitting a detailed report:

1. **Check Existing Issues**:
   - Search the [Issues](https://github.com/mschultheiss83/klubradio-archivum-app/issues) page to avoid duplicates.
2. **Create a New Issue**:
   - Use the “Bug Report” template (if available) or include:
     - **Description**: What went wrong? (e.g., “App crashes when downloading episodes.”)
     - **Steps to Reproduce**: Clear steps to trigger the issue.
     - **Expected Behavior**: What should happen?
     - **Actual Behavior**: What happens instead?
     - **Environment**: Device (e.g., iPhone 12, Android 11), OS version, app version.
     - **Logs/Screenshots**: Attach logs (from `flutter run --verbose`) or screenshots.
3. **Label the Issue**: Add the “bug” label for clarity.

## Submitting Feature Requests
Have an idea to improve the app? Share it with us:

1. **Check Existing Issues**:
   - Ensure your idea hasn’t already been proposed.
2. **Create a New Issue**:
   - Use the “Feature Request” template (if available) or include:
     - **Description**: What feature do you want? (e.g., “Add push notifications for new episodes.”)
     - **Use Case**: Why is this valuable? Who benefits?
     - **Possible Implementation**: Optional suggestions for how it could work.
3. **Label the Issue**: Add the “enhancement” label.

## Submitting Pull Requests
Ready to contribute code or documentation? Follow these steps:

1. **Fork and Clone**:
   - Fork the repository and clone it locally:
     ```bash
     git clone https://github.com/your-username/klubradio-archivum-app.git
     ```
2. **Create a Branch**:
   - Use a descriptive branch name (e.g., `feature/auto-download`, `fix/scraper-bug`):
     ```bash
     git checkout -b your-branch-name
     ```
3. **Make Changes**:
   - Follow Dart/Flutter coding standards (run `flutter format .` for formatting).
   - Update tests if adding new functionality (e.g., in `test/` directory).
   - Document changes in code comments or the README if needed.
4. **Test Locally**:
   - Run `flutter test` to ensure all tests pass.
   - Test on both iOS and Android emulators/devices.
5. **Commit Changes**:
   - Write clear commit messages (e.g., “Add auto-download for subscribed shows”).
   - Push to your fork:
     ```bash
     git push origin your-branch-name
     ```
6. **Open a Pull Request**:
   - Go to the [repository](https://github.com/mschultheiss83/klubradio-archivum-app) and create a PR.
   - Link the PR to an existing issue (e.g., “Fixes #123”).
   - Describe your changes, why they’re needed, and how you tested them.
7. **Review Process**:
   - Respond to feedback from maintainers.
   - Ensure CI checks (e.g., linting, tests) pass.

### Guidelines
- Keep PRs small and focused to simplify review.
- Respect Klubrádió’s free access policy: no commercial features.
- Ensure GDPR compliance: avoid collecting user data unnecessarily.

## Code of Conduct
We strive to create a welcoming and inclusive community. Please:
- Be respectful and professional in all interactions.
- Avoid offensive language or behavior.
- Report any issues to the maintainers via GitHub Issues or email (if provided).

Thank you for contributing to the Klubrádió Archive App! Your efforts help bring Hungarian radio content to a wider audience.


