# Chef Kiss - Your Daily Recipe Companion 👨‍🍳👩‍🍳

## 🌟 Project Overview

**Chef Kiss** is a delightful and intuitive mobile application built with Flutter, designed to help food enthusiasts discover, explore, and manage a vast collection of delicious meal recipes. Leveraging the comprehensive TheMealDB API, the app provides a seamless experience for searching meals, browsing by category or ingredient, viewing detailed cooking instructions, and saving favorite recipes for quick access.

Chef Kiss delivers a clean, modern UI, efficient data handling, and robust state management using GetX, ensuring a smooth and responsive user experience across various devices.

---

## ✨ Features

- **Extensive Meal Search:** Quickly find recipes by meal name or by their first letter.
- **Categorized Browse:** Explore meals neatly organized into categories (e.g., Seafood, Dessert, Breakfast).
- **Ingredient-Based Filtering:** Discover recipes using specific ingredients you have on hand (e.g., Chicken, Pasta, Rice).
- **Detailed Recipe View:** Get comprehensive information for each meal, including:
    - Step-by-step cooking instructions.
    - A structured list of ingredients with their respective measures.
    - A direct link to a YouTube video for cooking guidance.
- **Local Bookmarking:** Save your favorite recipes locally for offline access and quick retrieval.
- **Responsive UI:** Optimized for various screen sizes and orientations using `flutter_screenutil`.
- **Daily Meal Reminders:** Stay engaged with daily local notifications to inspire your cooking.
- **Robust State Management:** Powered by GetX for efficient and scalable state management.
- **Efficient Image Loading:** Utilizes `cached_network_image` for smooth image display and caching.
- **Authentication:** Sign in/up with email/password, Google, or Facebook; secure user sessions via Firebase Auth.
- **User Data Management:** Option to delete all user data (including Firebase account deletion).
- **Custom Snackbars and Popups:** Enhanced feedback via animated snackbars and configurable popups.
- **AI Integration:** Experimental support for recipe suggestions and enhancements using AI plugins.
- **AI-Powered Recipe Editor:** Use the `Recipe AI` module (`recipe_ai_screen.dart`) to generate, edit, and enhance recipes using AI.
- **Offline Support:** Bookmarks and some app data available without an internet connection.

---

## 🚀 Screens & Functionality

The application is structured into several key modules, each representing a distinct user interface and set of functionalities:

1. **Splash Screen:** Initial app launch, authentication check, and data preloading.
2. **Authentication:** Email/password, Google, or Facebook sign in/up.
3. **Home/Dashboard:** Discover meals by search, category, or ingredient; shows welcome message; “Try Something New” randomizer.
4. **Meal List / Category & Ingredient Filter Screens:** Browse meals in a scrollable, responsive grid.
5. **Recipe Detail:** Large recipe image, category, origin, step-by-step instructions, ingredients, and a YouTube guide.
6. **Bookmarks:** Manage saved recipes for easy offline retrieval.
7. **Recipe AI Screen:** Create, edit, and enhance recipes via AI in [`lib/screen/recipe_ai/recipe_ai_screen.dart`](https://github.com/suleohis/chef_kiss/blob/main/lib/screen/recipe_ai/recipe_ai_screen.dart).
8. **Profile & Settings:** Manage profile, notification preferences, and privacy options.

---

## 🛠️ Technologies & Dependencies

- **Framework:** Flutter (Dart)
- **State Management:** [GetX](https://pub.dev/packages/get)
- **Backend & Auth:** [Firebase (core, auth, firestore, storage, analytics, crashlytics, performance)](https://firebase.google.com/)
- **Social Auth:** [Google Sign-In](https://pub.dev/packages/google_sign_in), [Flutter Facebook Auth](https://pub.dev/packages/flutter_facebook_auth)
- **API Integration:** [http](https://pub.dev/packages/http), [dio](https://pub.dev/packages/dio)
- **Image Loading:** [cached_network_image](https://pub.dev/packages/cached_network_image), [flutter_svg](https://pub.dev/packages/flutter_svg)
- **UI & UX:** [flutter_screenutil](https://pub.dev/packages/flutter_screenutil), [google_fonts](https://pub.dev/packages/google_fonts), [awesome_snackbar_content](https://pub.dev/packages/awesome_snackbar_content), [giffy_dialog](https://pub.dev/packages/giffy_dialog), [shimmer_animation](https://pub.dev/packages/shimmer_animation), [readmore](https://pub.dev/packages/readmore)
- **Grid Layouts:** [flutter_staggered_grid_view](https://pub.dev/packages/flutter_staggered_grid_view)
- **Local Storage:** [shared_preferences](https://pub.dev/packages/shared_preferences)
- **Notifications:** [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
- **Timezone Handling:** [timezone](https://pub.dev/packages/timezone), [flutter_timezone](https://pub.dev/packages/flutter_timezone)
- **Permissions:** [permission_handler](https://pub.dev/packages/permission_handler)
- **AI & Generative Features:** [flutter_ai_toolkit](https://pub.dev/packages/flutter_ai_toolkit), [firebase_ai](https://pub.dev/packages/firebase_ai), [google_generative_ai](https://pub.dev/packages/google_generative_ai)
- **Others:** [youtube_player_flutter](https://pub.dev/packages/youtube_player_flutter), [uuid](https://pub.dev/packages/uuid), [logger](https://pub.dev/packages/logger), [url_launcher](https://pub.dev/packages/url_launcher), [flutter_markdown_plus](https://pub.dev/packages/flutter_markdown_plus), [split_view](https://pub.dev/packages/split_view)

---

## 📂 Project Structure

```
chef_kiss/
└── lib/
    ├── data/
    │   ├── models/                 # Dart models for API responses
    │   └── services/               # API service classes
    ├── screen/
    │   ├── auth/                   # Authentication screens and logic
    │   ├── bookmark/               # Bookmarked recipes management
    │   ├── categories/             # Browse categories
    │   ├── dashboard/              # Main dashboard and navigation
    │   ├── home/                   # Home screen
    │   ├── notification/           # Local notifications and reminders
    │   ├── recipe_ai/              # AI-powered recipe creation and editing
    │   │   ├── widgets/
    │   │   ├── edit_recipe_page.dart
    │   │   ├── recipe_ai_screen.dart   # Main AI recipe screen
    │   │   └── split_or_tabs.dart
    │   ├── recipe_detail/          # Detailed recipe views
    │   ├── search_recipes/         # Search functionality
    │   ├── splash/                 # Splash screen
    │   └── util/                   # Utility screens and helpers
    ├── routes/                     # GetX routing definitions
    ├── utils/                      # Utility classes (constants, styles, etc.)
    ├── main.dart                   # Application entry point
    └── ...
├── assets/
│   ├── images/
│   └── icons/
├── pubspec.yaml
├── README.md
└── ...
```

**Notable File:**
- [`lib/screen/recipe_ai/recipe_ai_screen.dart`](https://github.com/suleohis/chef_kiss/blob/main/lib/screen/recipe_ai/recipe_ai_screen.dart): The main AI-powered recipe editing and generation screen.

---

## 🛠️ Getting Started

### Download APK (Android)
Download the latest APK:  
[Chef Kiss APK (Google Drive)](https://drive.google.com/file/d/1w84ADyqNKT8PdhkngrqPDRUNYRPksGks/view?usp=drive_link)  
_**Note:** Allow installation from unknown sources if downloading directly._

### Prerequisites

- **Flutter SDK:** [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK:** (bundled with Flutter)
- **IDE:** VS Code (Flutter extension) or Android Studio (Flutter/Dart plugins)

### Installation

1. **Clone the repository:**
    ```bash
    git clone https://github.com/suleohis/chef_kiss.git
    cd chef_kiss
    ```
2. **Install dependencies:**
    ```bash
    flutter pub get
    ```
3. **Connect a device or start an emulator/simulator.**
4. **Run the app:**
    ```bash
    flutter run
    ```

---

## 👋 Contributing

Contributions are welcome! If you have suggestions for improvements, new features, or bug fixes, please open an issue or submit a pull request.

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

---

## 📄 License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

---

## 🏗️ Dev Tools & Code Generation

- Run code generation for assets:
    ```bash
    dart run build_runner build
    ```

---

## 📚 More Info

- For a full list of dependencies and plugins, see [`pubspec.yaml`](pubspec.yaml).
- For advanced settings or troubleshooting, review the source code or open an issue.

---