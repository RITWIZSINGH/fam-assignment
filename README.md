# FamPay Assignment - Contextual Cards

A Flutter application that displays a list of Contextual Cards fetched from an API. The app demonstrates the implementation of dynamic card layouts, gesture handling, and state management.

## Features

- Displays various types of contextual cards (HC1, HC3, HC5, HC6, HC9)
- Long press gesture on HC3 cards with slide animation
- Remind Later & Dismiss Now functionality
- URL/Deeplink handling
- Pull to refresh
- Error and loading states
- Responsive design
- Persistent storage for card states

## Demo

- If you don't see the download option. Then, Click on View Raw to download the apk.

[Click here to download APK](apk/app-release.apk)

### Video Demo
![App Demo](demo/app_demo.gif)

## Setup Instructions

1. Clone the repository
```bash
git clone https://github.com/yourusername/fampay-assignment.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## Project Structure

```
lib/
├── config/
│   ├── env.dart
├── models/
│   ├── card_group.dart
│   ├── contextual_card.dart
├── services/
│   ├── api_service.dart
│   ├── storage_service.dart
│   └── url_service.dart
├── widgets/
│   ├── cards/
│   │   ├── big_display_card.dart
│   │   ├── card_actions.dart
│   │   ├── card_content.dart
│   │   └── dynamic_width_card.dart
│   │   └── image_card.dart
│   │   └── small_card_with_arrow.dart
│   │   └── small_display_card.dart
│   └── card_group_widget.dart
│   └── contextual_card_container.dart
│   └── formatted_text_widget.dart
└── main.dart
```

## Implementation Details

### Card Types
- **HC1**: Small Display Card
- **HC3**: Big Display Card with slide action
- **HC5**: Image Card
- **HC6**: Small Card with Arrow
- **HC9**: Dynamic Width Card

### Features Implementation

1. **Long Press Action (HC3)**
   - Implemented using GestureDetector
   - Animated slide effect using AnimationController
   - Action buttons for Remind Later and Dismiss Now

2. **URL Handling**
   - Using url_launcher package
   - Configured for both Android and iOS

3. **Storage**
   - Persistent storage for dismissed and reminded cards
   - Shared Preferences for data persistence

4. **Error Handling**
   - Graceful error states
   - Retry mechanisms
   - User-friendly error messages

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  url_launcher: ^6.2.4
  shared_preferences: ^2.2.2
```

## Note for Reviewers

- The code is structured to be modular and reusable
- Each card type is implemented as a separate widget
- Error handling is implemented throughout the app
- State management is handled efficiently
- The app follows Flutter best practices and conventions

## Author

    RITWIZ SINGH 
    ritwizsingh007@gmail.com

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details