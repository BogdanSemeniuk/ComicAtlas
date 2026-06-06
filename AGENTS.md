# ComicAtlas Agent Guide

ComicAtlas is an iOS app for browsing comic-related content, including characters, issues, volumes, and movies. It has authentication, profile, and home browsing flows, with a layered structure that separates app setup, domain logic, data access, and SwiftUI presentation.

## Role

Act as a senior iOS engineer. Keep changes aligned with Apple's Human Interface Guidelines, App Review guidelines, and the existing architecture.

## Tech Stack

- iOS 26.0 or later; the project currently targets iOS 26.2.
- Swift 5 with Swift concurrency and MainActor default actor isolation.
- SwiftUI with Observation (`@Observable`) for shared state.
- Firebase Auth integration.
- Custom async/await networking and repository layers.
- String catalogs (`.xcstrings`) for localization.
- Swift Testing unit tests with mocks and JSON fixtures.

## Project Structure

- `ComicAtlas/App`: app entry point, root view, dependency injection, coordinators, navigation.
- `ComicAtlas/Core`: shared config, extensions, formatting, UI components, styles, and constants.
- `ComicAtlas/Data`: DTOs, API client, endpoints, auth services, and repository implementations.
- `ComicAtlas/Domain`: domain models, repository protocols, and validation logic.
- `ComicAtlas/Presentation`: SwiftUI screens and view models grouped by app flow.
- `ComicAtlasTests`: unit tests, mocks, test support, and JSON response fixtures.

## Coding Guidelines

- Prefer modern SwiftUI, Observation, and async/await APIs.
- Use `@Observable` for shared data, with `@State` for ownership and `@Bindable` / `@Environment` for passing state.
- Write strict-concurrency-safe code. Avoid `DispatchQueue.main.async()` and use Swift concurrency instead.
- Prefer modern APIs such as `NavigationStack`, `Tab`, `foregroundStyle`, `clipShape`, `Task.sleep(for:)`, `URL.documentsDirectory`, `appending(path:)`, and `FormatStyle`.
- Avoid legacy patterns in new code: `ObservableObject`, `@Published`, `@StateObject`, `@ObservedObject`, `@EnvironmentObject`, `NavigationView`, `tabItem`, `foregroundColor`, `cornerRadius`, legacy `Formatter` subclasses, force unwraps, and force `try`.
- Avoid UIKit in new SwiftUI code unless integration requires it.
- Use `localizedStandardContains()` when filtering user-facing text.
- Prefer small `View` structs for meaningful subviews, and keep view logic in view models or other testable types.
- Use existing layout constants and design patterns before adding new spacing, padding, or styling conventions.
- Do not introduce third-party frameworks without asking first.

## SwiftData

If SwiftData is configured to use CloudKit, do not use `@Attribute(.unique)`. Model properties must have default values or be optional, and relationships must be optional.

## Localization

When adding user-facing strings to existing `.xcstrings` catalogs, prefer symbol keys with `extractionState` set to `manual`, then access them through generated symbols such as `Text(.helloWorld)`. Offer to translate new keys into all languages supported by the project.

## Testing

Write or update unit tests for core logic, repositories, API endpoints, validators, and view models when behavior changes. Prefer UI tests only for critical user flows that cannot be covered well with unit tests.

## PR instructions

- When asked to create or update a GitHub pull request description, always read and follow `.github/PR_DESCRIPTION_GUIDE.md`.
- Use GitHub CLI (`gh`) to create or update pull request descriptions when it is available and authenticated.
- If installed, make sure SwiftLint returns no warnings or errors before committing.
