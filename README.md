# Mini Wallet - Expense Tracker

## Overview

Mini Wallet is a mobile app developed with Flutter for tracking and managing expenses. It utilizes Firebase as the backend for real-time data storage and authentication.

## Features

- **Expense Tracking:** Record and categorize your expenses.
- **Budget Management:** Set budgets for different categories.
- **Real-Time Updates:** Instantly sync data across devices.
- **Authentication:** Securely log in and protect your data.

## Technologies Used

- **Flutter:** Cross-platform framework for building mobile apps.
- **Firebase:** Cloud-based platform for app development and backend services.

## Getting Started

1. **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/mini_wallet.git
    ```

2. **Navigate to the project directory:**

    ```bash
    cd mini_wallet
    ```

3. **Set up Firebase:**

    - Create a new Firebase project.
    - Obtain your Firebase configuration from the Firebase Console.
    - Replace the configuration in `lib/config/firebase_config.dart`.

4. **Install dependencies:**

    ```bash
    flutter pub get
    ```

5. **Run the app:**

    ```bash
    flutter run
    ```

## Folder Structure

- `lib/`: Flutter application source code
- `lib/config/`: Firebase configuration file
- ...

## Firebase Setup

- **Authentication:** Enable Email/Password authentication in Firebase Console.
- **Firestore Database:** Set up Firestore database for storing expense data.

## Contributing

If you would like to contribute to the project, follow these steps:

1. Fork the repository.
2. Create a new branch: `git checkout -b feature/new-feature`.
3. Make your changes and commit them: `git commit -m 'Add new feature'`.
4. Push to the branch: `git push origin feature/new-feature`.
5. Submit a pull request.

## Authors

- [Your Name]
- [Contributor 1]
- [Contributor 2]

## License

This project is licensed under the [MIT License](LICENSE).
