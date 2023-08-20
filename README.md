# TUI Demo

## Building the App

1. Clone the repository to your local machine.
2. Open the TUI.xcodeproj file in Xcode.
3. Select the appropriate target and build the app.

## General Architecture

The iOS app follows the MVVM (Model-View-ViewModel) architectural pattern, incorporating Dependency Injection for handling dependencies and Async/Await for asynchronous operations.

Key Components:
- Dependency Injection: The project uses PropertyWrapper for dependency injection, allowing for loosely coupled components and easy testability.
- MVVM Pattern: The app follows the MVVM pattern, where Views display data and actions, ViewModels handle business logic and data presentation, and Models represent data and services.
- Convert Combine to Async/Await: The app has replaced Combine with Swift's native Async/Await for cleaner and more straightforward asynchronous programming.
- UI shared: Contains style-related files such as Theme for theming, Modifiers, Colors, and Styles for reusable styles.
- Utilities: Contains extension files with utility functions, helping to keep the main codebase clean and organized.

## Modules

This app includes 2 main modules:
- Welcome: Landing view by ScrollView base for introducing first features in the app such as Choosing destination and departure cities, showing cheapest routes between selected cities.
- SearchResult: Modal view with TextField component and suggestions by current input for searching and choosing the city. All cities in suggestions are sorted by titles.
  -  Map: This is a subview with separated business logic for presenting resulted route with points on the interactive map.

## Auto-tests

This app is covered by major integration and unit tests for main entities and business logic.

## Libraries Used

The app uses the following Apple libraries:

- Combine: Used previously for reactive programming. However, we've now switched to Swift's native Async/Await for better readability and performance.
- MapKit and CoreLocation: Used to integrate interactive maps and location-based services into their applications, providing features like displaying maps, adding annotations, and handling user interactions.
- SwiftUI: Used for declarative user interface framework in Swift that enables developers to build user interfaces across Apple platforms using a consistent and intuitive syntax.

Feel free to explore the codebase and contribute to the project. Happy coding!
