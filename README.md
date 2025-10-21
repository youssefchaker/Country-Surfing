# Country Surfing

Country Surfing is a mobile application built with Flutter that allows users to test their knowledge of countries around the world through an interactive quiz. The app features user authentication, timed quizzes, and information pages about different countries.

## Features

*   **User Authentication:** Secure sign-up, sign-in, and password reset functionality using Firebase Authentication.
*   **Interactive Quiz:** A quiz to test your knowledge of different countries.
*   **Quiz Results:** View your score and results after completing a quiz.
*   **Country Information:** Browse information and facts about various countries.
*   **Timed Challenges:** A timed mode for an extra challenge.
*   **Interactive Map:** Visual representation of countries on a map.

## Technologies Used

*   **Flutter:** The UI toolkit for building the application from a single codebase.
*   **Dart:** The programming language used for Flutter development.
*   **Firebase:**
    *   **Firebase Authentication:** For managing user accounts.
    *   **Cloud Firestore:** For storing user data and application content.
*   **Provider:** For state management.
*   **flutter_map:** For interactive map integration.
*   **http, intl, timezone:** For handling API requests and date/time logic.

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

*   Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
*   A configured Firebase project.

### Installation

1.  **Clone the repo**
    ```sh
    git clone https://github.com/your_username/Country-Surfing.git
    ```
2.  **Navigate to the project directory**
    ```sh
    cd Country-Surfing
    ```
3.  **Install dependencies**
    ```sh
    flutter pub get
    ```
4.  **Add your Firebase configuration**
    *   Download your `google-services.json` from the Firebase console and place it in the `android/app/` directory.
    *   Configure the iOS and web apps in the Firebase console as needed.
5.  **Run the app**
    ```sh
    flutter run
    ```

## Project Structure

```
lib/
├── auth/         # Authentication-related widgets and logic
├── models/       # Data models (User, Country)
├── pages/        # Main pages/screens of the app (Quiz, Results, Info)
├── services/     # Backend services (Firebase communication)
├── shared/       # Shared widgets and constants
├── main.dart     # App entry point
└── wrapper.dart  # Handles routing between auth and home screens
```