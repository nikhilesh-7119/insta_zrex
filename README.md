# insta_zrex

A pixel-perfect Instagram Home Feed clone built with Flutter, replicating the look, feel, and interactions of the real Instagram app.

## Features

- **Pixel-Perfect UI** — Top bar (logo, notifications, messages), stories tray, and post feed matching the current Instagram layout
- **Carousel Posts** — Smooth horizontal scrolling with synchronized dot indicator
- **Pinch-to-Zoom** — Full-screen overlay zoom on post images with animated snap-back on release
- **Stateful Interactions** — Like (heart) and Save (bookmark) toggle with local state updates; double-tap to like with heart animation
- **Shimmer Loading** — Skeleton-based shimmer effect during initial feed load (1.5s simulated latency)
- **Infinite Scroll** — Lazy-loading pagination; fetches 10 more posts when the user is 2 posts from the bottom
- **Light & Dark Theme** — Fully themed with `ThemeMode.system`, adapts automatically to device settings
- **Custom Snackbars** — Unimplemented actions (Share, Comments, Stories) show a styled snackbar notification
- **Cached Network Images** — All images loaded via `CachedNetworkImage` with placeholder shimmers and error fallbacks

## State Management — Why GetX?

This project uses **GetX** for state management. The choice was made for the following reasons:

1. **Minimal boilerplate** — GetX requires significantly less setup code compared to BLoC or Riverpod, keeping the codebase lean for a single-screen app.
2. **Reactive UI updates** — Using `Obx()` widgets with `.obs` observables gives fine-grained reactivity. Only the widgets that depend on changed state rebuild, ensuring smooth 60fps scrolling.
3. **Built-in dependency injection** — `Get.lazyPut()` with `Bindings` cleanly registers controllers without needing a separate DI package.
4. **Navigation & Snackbars** — GetX provides context-free navigation and snackbar APIs, eliminating the need for `BuildContext` references outside the widget tree.

## Architecture

The project follows the **MVC (Model-View-Controller)** pattern:

```
lib/
├── app/
│   ├── colors/          # AppColors — centralized color definitions
│   ├── constants/       # AppConstants — sizes, durations, paddings
│   └── theme/           # AppTheme — light & dark theme data
├── controllers/
│   ├── feed_controller.dart    # Feed state: posts, pagination, like/save
│   └── story_controller.dart   # Stories state: list, seen status
├── models/
│   ├── post_model.dart         # Post data model with copyWith/toJson/fromJson
│   ├── story_model.dart        # Story data model
│   └── user_model.dart         # User data model
├── services/
│   └── post_repository.dart    # Mock data layer with simulated latency
├── views/
│   ├── home/
│   │   └── home_screen.dart    # Main feed screen
│   └── placeholder/
│       └── coming_soon_screen.dart
├── widgets/
│   ├── app_bar/                # Instagram-style app bar
│   ├── common/                 # Custom snackbar
│   ├── post/                   # PostCard, PostHeader, PostMedia, PostActions,
│   │                           # PostCaption, CarouselWidget, DotIndicator
│   ├── shimmer/                # FeedShimmer skeleton loader
│   ├── story/                  # StoriesTray, StoryItem
│   └── zoom/                   # PinchZoomOverlay
└── main.dart
```

**Key design decisions:**
- No business logic in widget `build()` methods — all state flows through controllers
- All mock data lives in `PostRepository`, not in UI or controller files
- Models are immutable with `copyWith()` for state updates
- All hardcoded values (colors, sizes, durations) are centralized in `AppColors` and `AppConstants`

## Tech Stack

| Category | Package |
|---|---|
| Framework | Flutter 3.x |
| State Management | [get](https://pub.dev/packages/get) ^4.6.6 |
| Image Caching | [cached_network_image](https://pub.dev/packages/cached_network_image) ^3.4.1 |
| Shimmer Loading | [skeletonizer](https://pub.dev/packages/skeletonizer) ^2.1.3 |
| Typography | [google_fonts](https://pub.dev/packages/google_fonts) ^6.2.1 |

## Getting Started

### Prerequisites

- Flutter SDK `>=3.5.0`
- Dart SDK (bundled with Flutter)
- Android Studio / VS Code with Flutter extension
- An Android emulator, iOS simulator, or physical device

### Run the app

```bash
# Clone the repository
git clone https://github.com/<your-username>/insta_zrex.git
cd insta_zrex

# Install dependencies
flutter pub get

# Run on a connected device or emulator
flutter run
```

### Build a release APK

```bash
flutter build apk --release
```

The APK will be at *https://drive.google.com/file/d/1AKoaU51AFGX5HquAVQuVqbapk6hMQl5D/view?usp=sharing*.

## Demo

*https://drive.google.com/file/d/1UtBaZu0r7G5t4W4y4s3UgkzpXRcKQPzP/view?usp=sharing*
- Shimmer loading state
- Smooth infinite scrolling
- Pinch-to-Zoom interaction
- Like/Save toggle interactions
