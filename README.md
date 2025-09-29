# Prime_Wave_Task

>Flutter Articles App

`A Flutter app that fetches and displays paginated articles with robust error handling,
retry mechanisms, in-memory caching, dependency injection, pull-to-refresh support,
state management, and a clean architecture approach.`

**Features Implemented:**

* Paginated API fetching:
- Fetches articles from https://api.slingacademy.com/v1/sample-data/blog-posts?offset=$num&limit=$num using a repository + use case + Cubit architecture.
- Displays title + first 100 chars of body.
- Supports infinite scroll — loads the next page(by limit) when the user scrolls near the bottom.
- avoid duplicates when scrolling to fetch more articles(check and remove by id).
- added a floating button to scroll to the top of the list for easy user experience.

* Retry mechanism with exponential backoff:
- Network errors trigger automatic retries with delays.
- Shows a “Retrying… Attempt N” indicator to give the user feedback during retries.
- Uses Dio for networking and a custom retry logic in ApiClient.

* Friendly error handling:
- 4xx/5xx errors are caught and converted into ServerFailure.
- Displays friendly error messages in the UI.
- Includes a retry button to allow users to retry failed requests.

* In-memory caching:
- Prevents duplicate API calls when scrolling back up.
- Ensures smoother user experience during pagination.

* Robust architecture:
- Clean architecture with Data Source → Repository → Use Case → Cubit → UI.
- Uses Either<Failure, Model> for safe error handling.
- All parsing is null-safe and type-checked to prevent runtime crashes.

* State Management
- Uses flutter_bloc (Cubit) for managing UI state.
- Provides clear separation of UI and business logic.

* Dependency Injection
- Uses get_it and injectable for DI.
- All major components (ApiClient, DataSource, Repository, Use Case, Cubit) are singleton & lazySingleton scoped.
- Ensures loose coupling and testability.

* Pull-to-refresh:
- Users can pull down to refresh the articles list.
- Resets pagination and fetches the latest data.

* UI Enhancements
- Infinite scroll loading indicator.
- Retry button visible on error.
- Toast messages for retry attempts.
- Details screen to display full article body.
- Widget shows (fetchedItems / totalItems) so users can see how much of the list has been loaded.