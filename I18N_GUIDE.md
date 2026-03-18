# Internationalization (i18n) Guide

This guide explains how localization works in your Flutter app and how to add new languages or strings.

## 🌍 Overview

Your app uses Flutter's official **internationalization (i18n)** system with **ARB (Application Resource Bundle)** files. This automatically generates type-safe localization classes.

## 📁 File Structure

```
my_flutter_starter/
├── l10n.yaml                      # Localization configuration
├── lib/
│   └── l10n/
│       ├── app_en.arb            # English translations (template)
│       └── app_ar.arb            # Arabic translations
└── .dart_tool/
    └── flutter_gen/
        └── gen_l10n/             # Auto-generated (do not edit)
            ├── app_localizations.dart
            ├── app_localizations_en.dart
            └── app_localizations_ar.dart
```

## ⚙️ Configuration

### `l10n.yaml`
```yaml
arb-dir: lib/l10n                    # Where ARB files are located
template-arb-file: app_en.arb        # Template file for generating code
output-localization-file: app_localizations.dart
output-class: AppLocalizations        # Generated class name
synthetic-package: true              # Generate in .dart_tool
nullable-getter: false               # Return non-nullable strings
```

### `pubspec.yaml`
```yaml
flutter:
  generate: true  # Enable code generation
```

## 🚀 How It Works

### 1. **ARB Files** (Translation Source)

**English** (`lib/l10n/app_en.arb`):
```json
{
  "@@locale": "en",
  "welcomeBack": "Welcome Back!",
  "@welcomeBack": {
    "description": "Welcome message on login screen"
  },
  "welcomeUser": "Welcome, {username}!",
  "@welcomeUser": {
    "description": "Welcome message with username",
    "placeholders": {
      "username": {
        "type": "String",
        "example": "John"
      }
    }
  }
}
```

**Arabic** (`lib/l10n/app_ar.arb`):
```json
{
  "@@locale": "ar",
  "welcomeBack": "مرحباً بعودتك!",
  "welcomeUser": "مرحباً، {username}!"
}
```

### 2. **Code Generation**

Run when ARB files change:
```bash
flutter pub get
# or
flutter gen-l10n
```

### 3. **Using in Code**

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Column(
      children: [
        Text(l10n.welcomeBack),              // Simple string
        Text(l10n.welcomeUser('John')),      // With placeholder
        Text(l10n.oauthFailed(error)),       // With dynamic value
      ],
    );
  }
}
```

## ✨ Supported Languages

| Language | Code | File | RTL Support |
|----------|------|------|-------------|
| English  | `en` | `app_en.arb` | ❌ |
| Arabic   | `ar` | `app_ar.arb` | ✅ |

## 📝 Adding a New Language

### Step 1: Create ARB File

Create `lib/l10n/app_fr.arb` (French example):
```json
{
  "@@locale": "fr",
  "appTitle": "Mon Application Flutter",
  "login": "Connexion",
  "welcomeBack": "Bon retour!",
  "welcomeUser": "Bienvenue, {username}!"
}
```

### Step 2: Regenerate Code
```bash
flutter pub get
```

### Step 3: Update Locale Cubit (Optional)

If you want users to select French:
```dart
// In lib/blocs/locale/locale_cubit.dart
void setFrench() => emit(const Locale('fr'));
```

That's it! The language is now available automatically.

## 📖 Adding New Strings

### 1. Add to Template File

Edit `lib/l10n/app_en.arb`:
```json
{
  "myNewString": "Hello World",
  "@myNewString": {
    "description": "My new greeting message"
  }
}
```

### 2. Add to All Language Files

Edit `lib/l10n/app_ar.arb`:
```json
{
  "myNewString": "مرحبا بالعالم"
}
```

### 3. Regenerate
```bash
flutter pub get
```

### 4. Use in Code
```dart
Text(AppLocalizations.of(context).myNewString)
```

## 🎯 String Types

### Simple String
```json
{
  "login": "Login",
  "@login": {
    "description": "Login button text"
  }
}
```

Usage:
```dart
l10n.login  // "Login"
```

### String with Placeholder
```json
{
  "welcomeUser": "Welcome, {username}!",
  "@welcomeUser": {
    "description": "Welcome message with username",
    "placeholders": {
      "username": {
        "type": "String",
        "example": "John"
      }
    }
  }
}
```

Usage:
```dart
l10n.welcomeUser('John')  // "Welcome, John!"
```

### String with Multiple Placeholders
```json
{
  "itemCount": "You have {count} {item}",
  "@itemCount": {
    "description": "Display item count",
    "placeholders": {
      "count": {
        "type": "int",
        "example": "5"
      },
      "item": {
        "type": "String",
        "example": "messages"
      }
    }
  }
}
```

Usage:
```dart
l10n.itemCount(5, 'messages')  // "You have 5 messages"
```

### Pluralization
```json
{
  "messageCount": "{count, plural, =0{No messages} =1{1 message} other{{count} messages}}",
  "@messageCount": {
    "description": "Message count with pluralization",
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  }
}
```

Usage:
```dart
l10n.messageCount(0)   // "No messages"
l10n.messageCount(1)   // "1 message"
l10n.messageCount(5)   // "5 messages"
```

## 🔄 Changing Language at Runtime

### Using LocaleCubit

```dart
// Switch to Arabic
context.read<LocaleCubit>().setLocale(const Locale('ar'));

// Switch to English
context.read<LocaleCubit>().setLocale(const Locale('en'));

// Get current locale
final currentLocale = context.read<LocaleCubit>().state;
```

### Language Picker UI Example

```dart
PopupMenuButton<Locale>(
  onSelected: (locale) {
    context.read<LocaleCubit>().setLocale(locale);
  },
  itemBuilder: (context) => [
    PopupMenuItem(
      value: const Locale('en'),
      child: Text('English'),
    ),
    PopupMenuItem(
      value: const Locale('ar'),
      child: Text('العربية'),
    ),
  ],
)
```

## 🎨 Available Strings

### Common
- `appTitle`, `login`, `logout`, `username`, `password`, `email`
- `signIn`, `register`, `cancel`, `save`, `ok`
- `error`, `success`

### Login Screen
- `welcomeBack`, `signInToContinue`
- `enterUsername`, `enterPassword`
- `dontHaveAccount`, `or`
- `continueWithGoogle`, `continueWithGithub`, `continueWithFacebook`
- `completingOAuthSignIn`, `oauthFailed`

### Registration Screen
- `createAccount`, `joinUs`, `createYourAccount`
- `enterEmail`, `confirmPassword`, `reEnterPassword`
- `alreadyHaveAccount`, `accountCreatedSuccess`

### Home Screen
- `home`, `welcome`, `welcomeUser`, `exampleGraphQL`

### Error Messages
- `invalidCredentials`, `usernameRequired`, `usernameTooShort`
- `emailRequired`, `emailInvalid`
- `passwordRequired`, `passwordTooShort`, `passwordsDoNotMatch`
- `pageNotFound`, `unknownError`, `goHome`

### Settings
- `settings`, `language`, `theme`
- `darkMode`, `lightMode`, `systemMode`

## 🛠️ Best Practices

### 1. **Always Add Descriptions**
```json
{
  "myString": "My Text",
  "@myString": {
    "description": "This helps translators understand context"
  }
}
```

### 2. **Use Placeholders for Dynamic Content**
```json
// ❌ Bad
"greeting": "Welcome John"

// ✅ Good
"greeting": "Welcome {name}"
```

### 3. **Keep Keys Descriptive**
```json
// ❌ Bad
"s1": "Login"

// ✅ Good
"loginButton": "Login"
```

### 4. **Organize by Screen/Feature**
Use consistent naming:
- `loginWelcome`, `loginSubmit`
- `profileName`, `profileBio`

### 5. **Test All Languages**
```dart
// Test in Arabic
context.read<LocaleCubit>().setLocale(const Locale('ar'));

// Check RTL layout
// Check text overflow
// Verify all strings are translated
```

## 🐛 Troubleshooting

### Strings Not Updating?
```bash
flutter clean
flutter pub get
```

### Missing Translation Error?
- Check that the key exists in ALL ARB files
- Verify JSON syntax (no trailing commas)

### Code Not Generated?
- Ensure `generate: true` in `pubspec.yaml`
- Check `l10n.yaml` is in project root
- Run `flutter pub get`

### RTL Layout Issues?
Flutter automatically handles RTL for Arabic. If you have issues:
```dart
Directionality(
  textDirection: TextDirection.rtl,
  child: YourWidget(),
)
```

## 📊 Workflow Summary

```
1. Edit ARB files (app_en.arb, app_ar.arb)
   ↓
2. Run: flutter pub get
   ↓
3. Generated code appears in .dart_tool/flutter_gen/
   ↓
4. Import: import 'package:flutter_gen/gen_l10n/app_localizations.dart';
   ↓
5. Use: AppLocalizations.of(context).yourString
```

## 🌐 External Translation Services

You can use services like:
- **Localizely** - https://localizely.com/
- **POEditor** - https://poeditor.com/
- **Crowdin** - https://crowdin.com/

Export ARB files → Send to translators → Import translated ARB files

## 📚 Resources

- [Flutter Internationalization Guide](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)
- [ARB Format Specification](https://github.com/google/app-resource-bundle/wiki/ApplicationResourceBundleSpecification)
- [Intl Package](https://pub.dev/packages/intl)

---

**Pro Tip:** Keep your ARB files in version control and review translation changes just like code!
