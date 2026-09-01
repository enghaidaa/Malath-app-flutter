# MASTER CONTEXT — MALAZ ISLAMIC APP
# Flutter University Project — Current Development Checkpoint

You are continuing an existing university Flutter project called:

"ملاذ — Islamic App"

This document is the authoritative project context.

IMPORTANT:
Read and understand this entire document before making any code changes.

Do NOT assume previous architecture, implementation, or files that are not explicitly described here.

Do NOT restart the project.

Do NOT redesign the architecture.

Continue from the CURRENT CHECKPOINT described at the end of this document.

============================================================
1. PROJECT OVERVIEW
============================================================

The project is a Flutter Islamic mobile application called:

"ملاذ"

The application will eventually contain:

1. Authentication
2. Quran
3. Azkar
4. Prayer Times
5. Home
6. My Azkar
7. Prayer Tracker
8. Settings

Additional functionality:

- Favorites
- Hijri Date
- User Profile
- Local Preferences

The project also contains a separate Custom Backend built with:

- Node.js
- Express
- TypeScript
- CORS
- Helmet
- Dotenv
- Adhan

The Custom Backend exists mainly to satisfy the professor's backend requirement and obtain the +3 bonus.

Firebase MUST remain in the project.

The Custom Backend does NOT replace Firebase.

============================================================
2. PROFESSOR REQUIREMENTS
============================================================

The professor requires the Flutter project to demonstrate:

- Feature-Based Architecture
- MVVM Architecture
- Cubit
- Dio
- Firebase Authentication
- Firebase Firestore
- SharedPreferences
- At least 4 API endpoints
- At least 6 features

Our project has 8 main features.

The professor also allows students to build their own backend.

Our Custom Backend provides the +3 bonus.

The professor emphasizes that students should understand and be able to explain their code.

Therefore:

The project must be:

- Simple
- Direct
- Readable
- Student-friendly
- Easy to explain
- Consistent

Do NOT make the project enterprise-grade.

============================================================
3. FINAL FLUTTER ARCHITECTURE
============================================================

The project uses:

Feature-Based Architecture
+
MVVM
+
Cubit
+
Repository Pattern
+
Dio
+
Firebase
+
SharedPreferences
+
GetIt

The main data flow is:

View
↓
Cubit
↓
Repository
↓
Repository Implementation
↓
Service / Data Source
↓
Dio / Firebase / SharedPreferences

For API features:

View
↓
Cubit
↓
Repository
↓
RepositoryImpl
↓
ApiService / API Consumer
↓
Dio
↓
Custom Backend

For Firebase:

View
↓
Cubit
↓
Repository
↓
RepositoryImpl
↓
Firebase Service
↓
Firebase

For local settings:

View
↓
Cubit
↓
Repository
↓
RepositoryImpl
↓
SharedPreferences

IMPORTANT:

The UI must NEVER directly access external data sources.

============================================================
4. REPOSITORY PATTERN
============================================================

Repository Pattern is required.

Each applicable feature should have:

data/
├── models/
└── repos/
    ├── feature_repo.dart
    └── feature_repo_impl.dart

The abstract Repository defines WHAT operations are available.

RepositoryImpl defines HOW those operations are performed.

Example:

QuranCubit
↓
QuranRepo
↓
QuranRepoImpl
↓
ApiService
↓
Dio
↓
Backend

The Cubit MUST NOT know:

- API URLs
- Dio implementation
- Firebase implementation
- Firestore implementation
- SharedPreferences implementation
- HTTP implementation
- Storage implementation

Cubit communicates only with the Repository abstraction.

============================================================
5. ERROR HANDLING
============================================================

Repositories use:

Either<Failure, Data>

from:

dartz

Technical exceptions should be converted into application-level failures inside the Repository/RepositoryImpl layer.

Expected flow:

External System
↓
Exception
↓
RepositoryImpl
↓
Failure
↓
Either<Failure, Data>
↓
Cubit
↓
State
↓
View

Existing/expected core errors:

core/errors/
├── exceptions.dart
└── failures.dart

Do NOT create random error handling inside Views.

Cubit should use:

result.fold()

to handle repository results.

============================================================
6. CUBIT STYLE
============================================================

State management uses:

flutter_bloc

Cubit is responsible for:

- Calling repository methods
- Loading state
- Success state
- Failure state
- Updating UI state

Typical states:

Initial
Loading
Success
Failure

The project prefers simple manually written states.

For Cubit states:

Use:

part
part of

Use:

sealed class

Example:

part of 'feature_cubit.dart';

sealed class FeatureState {}

final class FeatureInitial extends FeatureState {}

final class FeatureLoading extends FeatureState {}

final class FeatureSuccess extends FeatureState {}

final class FeatureFailure extends FeatureState {
  final String errorMessage;

  FeatureFailure({
    required this.errorMessage,
  });
}

Do NOT use:

- Freezed
- Equatable
- Code generation

unless explicitly requested later.

============================================================
7. PROFESSOR'S INTERNAL CODING STYLE
============================================================

THIS SECTION IS VERY IMPORTANT.

The professor's style is not only about folder structure.

The INTERNAL CODE WRITING STYLE should also remain:

Simple
Direct
Explicit
Readable
Student-friendly

Prefer:

final
required constructor parameters
simple methods
simple try/catch
simple result.fold()
simple state classes
simple models
simple repository implementations

Avoid:

- Generic abstractions
- Generic base repositories
- Generic Cubits
- Generic states
- Use-case layers
- Service locator wrappers
- Excessive helper classes
- Enterprise patterns
- Over-engineering
- Unnecessary interfaces
- Unnecessary dependency layers

The professor should be able to ask:

"Why did you write this?"

and the student should be able to explain it easily.

The goal is:

"Code the team understands"

NOT:

"Code that merely works."

============================================================
8. CORE LAYER
============================================================

Core contains shared infrastructure.

Expected:

lib/
└── core/
    ├── api/
    │   ├── api_consumer.dart
    │   ├── dio_consumer.dart
    │   └── end_points.dart
    │
    ├── errors/
    │   ├── exceptions.dart
    │   └── failures.dart
    │
    ├── routing/
    │   ├── app_routes.dart
    │   └── routes_name.dart
    │
    ├── services/
    │   ├── api_service.dart
    │   ├── firebase_auth_service.dart
    │   └── firebase_firestore_service.dart
    │
    ├── theme/
    │   ├── app_colors.dart
    │   ├── app_styles.dart
    │   └── app_theme.dart
    │
    ├── utils/
    │   └── validators.dart
    │
    └── widgets/
        ├── custom_button.dart
        ├── custom_text_field.dart
        └── custom_loading.dart

Exact files may evolve.

Core must contain shared infrastructure.

Do NOT put feature-specific models in Core.

============================================================
9. DEPENDENCY INJECTION
============================================================

Dependency Injection uses:

GetIt

GetIt should register:

- Services
- Repositories
- Repository Implementations
- Cubits
- Required dependencies

Do NOT create dependencies randomly inside Views.

The project should use constructor injection.

Example:

SettingsCubit(SettingsRepo settingsRepo)

NOT:

SettingsCubit() {
  final repo = SettingsRepoImpl(...);
}

============================================================
10. DIO
============================================================

All HTTP communication goes through Dio infrastructure.

Never:

View
↓
Dio

Never:

Cubit
↓
Dio

Correct:

Cubit
↓
Repository
↓
RepositoryImpl
↓
ApiService / ApiConsumer
↓
Dio
↓
Backend

============================================================
11. FIREBASE RESPONSIBILITIES
============================================================

Firebase MUST remain.

Firebase is responsible for:

Firebase Authentication:
- Register
- Login
- Logout
- User authentication
- Account/user profile functionality

Firebase Firestore:
- My Azkar
- Favorites
- Prayer Tracker
- User-specific data

Firebase is NOT responsible for:

- General Quran data
- General Azkar data
- General Prayer Times
- General Hijri data

============================================================
12. SHARED PREFERENCES
============================================================

SharedPreferences is used for LOCAL application preferences.

Current Settings preferences:

1. Theme
2. Language
3. Font Size

Keys:

is_dark_mode
language_code
font_size

Settings MUST NOT use Firestore.

Settings are local preferences.

Correct flow:

SettingsView
↓
SettingsCubit
↓
SettingsRepo
↓
SettingsRepoImpl
↓
SharedPreferences

============================================================
13. CUSTOM BACKEND
============================================================

Backend technology:

Node.js
Express
TypeScript

Responsibilities:

- Quran
- General Azkar
- Prayer Times
- Hijri Date

Flutter communicates with the backend through:

Dio.

Flutter does NOT directly consume public APIs.

Public APIs may be used as data sources when constructing the backend.

============================================================
14. BACKEND ENDPOINTS
============================================================

Quran:

GET /api/v1/quran/surahs

GET /api/v1/quran/surahs/:id

Azkar:

GET /api/v1/azkar

GET /api/v1/azkar/category/:category

Prayer:

GET /api/v1/prayers/timings

Health:

GET /health

Minimum required API operations are already satisfied.

============================================================
15. FEATURE RESPONSIBILITIES
============================================================

FEATURE 1 — AUTH

Source:

Firebase Authentication

Responsibilities:

- Register
- Login
- Logout
- Authentication
- User profile

Flow:

AuthView
↓
AuthCubit
↓
AuthRepo
↓
AuthRepoImpl
↓
FirebaseAuthService
↓
Firebase Authentication


FEATURE 2 — QURAN

Source:

Custom Backend

Responsibilities:

- Surah list
- Surah details
- Ayahs
- Juz
- Page
- Hizb Quarter

Flow:

QuranView
↓
QuranCubit
↓
QuranRepo
↓
QuranRepoImpl
↓
ApiService
↓
Dio
↓
Custom Backend


FEATURE 3 — AZKAR

Source:

Custom Backend

Responsibilities:

- General Azkar
- Morning
- Evening
- After Prayer
- Other categories

IMPORTANT:

General Azkar is NOT My Azkar.


FEATURE 4 — PRAYERS

Source:

Custom Backend

Responsibilities:

- Fajr
- Sunrise
- Dhuhr
- Asr
- Maghrib
- Isha
- Hijri date

IMPORTANT:

Prayer Times is NOT Prayer Tracker.


FEATURE 5 — HOME

Home is the application dashboard.

It may eventually show:

- Hijri Date
- Today's information
- Next Prayer
- Prayer Times
- Quran shortcut
- Azkar shortcut
- User information

Home must not directly access Dio/Firebase.


FEATURE 6 — MY AZKAR

Source:

Firebase Firestore

User-specific custom Azkar.

Responsibilities:

- Add
- Edit
- Delete
- Count
- Complete

Example:

Subhan Allah
Target: 100
Counter: 100

Counter:

100 → 99 → 98 → ... → 0

When:

counter == 0

the Zikr is considered completed.


FEATURE 7 — PRAYER TRACKER

Source:

Firebase Firestore

Tracks whether the user performed prayers.

This is separate from Prayer Times.


FEATURE 8 — SETTINGS

Source:

SharedPreferences

Responsibilities:

- Theme
- Language
- Font Size

CURRENT STATUS:

SETTINGS FEATURE IS COMPLETE AND FUNCTIONAL.

============================================================
16. SETTINGS FEATURE — COMPLETED IMPLEMENTATION
============================================================

The following files were implemented:

lib/features/settings/data/models/settings_model.dart

lib/features/settings/data/repos/settings_repo.dart

lib/features/settings/data/repos/settings_repo_impl.dart

lib/features/settings/presentation/manager/settings_state.dart

lib/features/settings/presentation/manager/settings_cubit.dart

lib/features/settings/presentation/views/settings_view.dart

GetIt registration was updated.

Routing was updated.

Settings uses SharedPreferences directly in SettingsRepoImpl.

There is NO unnecessary SettingsLocalService.

This was intentional to keep the implementation simple and consistent with the professor's style.

============================================================
17. SETTINGS MODEL
============================================================

SettingsModel contains:

isDarkMode
languageCode
fontSize

It includes:

copyWith()
toJson()
fromJson()

No code generation.

============================================================
18. SETTINGS REPOSITORY
============================================================

SettingsRepo defines:

Future<Either<Failure, SettingsModel>> getSettings();

Future<Either<Failure, void>> saveTheme(bool isDark);

Future<Either<Failure, void>> saveLanguage(String langCode);

Future<Either<Failure, void>> saveFontSize(double fontSize);

Cubit depends on:

SettingsRepo

NOT:

SettingsRepoImpl

============================================================
19. SETTINGS REPO IMPLEMENTATION
============================================================

SettingsRepoImpl receives:

SharedPreferences

through constructor injection.

It directly reads/writes:

is_dark_mode
language_code
font_size

Exceptions are caught and converted into:

CacheFailure

The repository returns:

left(CacheFailure(...))

or:

right(data)

============================================================
20. SETTINGS CUBIT
============================================================

SettingsCubit methods:

loadSettings()
toggleTheme()
changeLanguage()
updateFontSize()

It uses:

result.fold()

It preserves the other settings using:

copyWith()

The Cubit only communicates with:

SettingsRepo

============================================================
21. SETTINGS STATES
============================================================

Settings states use:

part
part of

and:

sealed class

States:

SettingsInitial
SettingsLoading
SettingsLoaded
SettingsFailure

SettingsLoaded contains:

SettingsModel settings

SettingsFailure contains:

String errorMessage

============================================================
22. SETTINGS UI
============================================================

SettingsView contains:

Dark Mode:
Switch

Language:
Dropdown

Font Size:
Slider

Slider range:

14.0 → 32.0

Default:

18.0

The View remains thin.

It communicates with SettingsCubit.

It does NOT access SharedPreferences.

============================================================
23. SETTINGS APPLICATION-WIDE INTEGRATION
============================================================

IMPORTANT:

Settings is NOT merely a storage screen.

Settings has been integrated with the application itself.

Theme changes affect the application globally.

Language changes affect the application locale.

Font size changes affect the application's centralized text styling.

Settings survive application restart.

The application reads saved preferences and applies them.

The current architecture remains simple.

There is no Firestore involvement in Settings.

============================================================
24. SETTINGS GLOBAL DATA FLOW
============================================================

The effective flow is:

SharedPreferences
↓
SettingsRepoImpl
↓
SettingsRepo
↓
SettingsCubit
↓
Application-level state
↓
MaterialApp
↓
Entire application

Theme:

SettingsCubit
↓
MaterialApp
↓
themeMode
↓
AppTheme.lightTheme / AppTheme.darkTheme

Language:

SettingsCubit
↓
MaterialApp
↓
locale
↓
Arabic / English

Font Size:

SettingsCubit
↓
centralized theme/text styling
↓
application text

============================================================
25. IMPORTANT MAIN.DART CONTEXT
============================================================

The project currently initializes Firebase first:

WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

Then:

await setupServiceLocator();

Then:

runApp(const MyApp());

MyApp uses:

MaterialApp

with:

title: 'ملاذ'

debugShowCheckedModeBanner: false

theme: AppTheme.lightTheme

darkTheme: AppTheme.darkTheme

initialRoute: AppRoutes.initialRoute

onGenerateRoute: AppRoutes.onGenerateRoute

IMPORTANT:

Do NOT blindly restore:

themeMode: ThemeMode.system

if the current implementation has already connected themeMode to Settings.

Theme must remain controlled by user Settings.

============================================================
26. TEMPORARY HOME TEST
============================================================

At one point Home was only a placeholder.

There was no real Home feature implementation.

A temporary test screen/button was used to access Settings.

The purpose was ONLY to test Settings.

Do NOT treat that temporary screen as the final Home implementation.

Do NOT implement Home unless explicitly requested.

============================================================
27. IMPORTANT BUG THAT WAS FIXED
============================================================

During Settings integration, the application crashed with:

package:flutter/src/painting/text_style.dart

Failed assertion:

fontSize != null ||
(fontSizeFactor == 1.0 && fontSizeDelta == 0.0)

The cause was related to invalid/null font-size integration with TextStyle/TextTheme.

The issue was fixed.

The final Settings implementation must NEVER allow a null/invalid font size to reach TextStyle.

Default font size:

18.0

Current valid range:

14.0 → 32.0

The application is now working correctly.

============================================================
28. CURRENT TEST STATUS
============================================================

Settings has been manually tested successfully.

Confirmed:

Dark Mode:
WORKING

Language:
WORKING

Font Size:
WORKING

Persistence:
WORKING

Application-wide integration:
WORKING

The previous runtime TextStyle crash:
FIXED

Settings feature is considered:

PHASE 2 — SETTINGS COMPLETE

============================================================
29. CURRENT PROJECT DEVELOPMENT STATUS
============================================================

PHASE 1:
Architecture Setup

STATUS:
COMPLETE

Phase 1 audit:

PASSED WITH DISTINCTION

The foundation was confirmed to be:

- Feature-based
- Correct Core layer
- Repository Pattern
- Correct DI direction
- Dio infrastructure
- Firebase infrastructure
- SharedPreferences infrastructure
- GetIt infrastructure
- Correct folder structure

The feature folders initially existed as skeletons.

This was expected.

------------------------------------------------------------

PHASE 2:
Settings

STATUS:

COMPLETE AND WORKING

Settings is the FIRST fully implemented feature.

------------------------------------------------------------

NEXT FEATURE:

AUTH

Recommended next implementation:

Authentication

============================================================
30. DEVELOPMENT ORDER
============================================================

Current completed:

1. Architecture / Core
2. Settings

Recommended next:

3. Auth
4. Quran
5. Prayers
6. Azkar
7. My Azkar
8. Prayer Tracker
9. Home integration

Order can change only if there is a practical reason.

============================================================
31. IMPORTANT DO-NOT-DO RULES
============================================================

NEVER:

- Put Dio calls directly in Views.
- Put Firebase calls directly in Views.
- Put API URLs directly inside Cubits.
- Put Firestore implementation inside Cubits.
- Make Cubits responsible for storage.
- Mix General Azkar with My Azkar.
- Mix Prayer Times with Prayer Tracker.
- Replace Firebase with Custom Backend.
- Put feature models in Core.
- Add unnecessary architecture layers.
- Add unnecessary technologies.
- Add Firestore to Settings.
- Add Firebase to Settings.
- Add another state management package.
- Use code generation without explicit approval.
- Generate huge Quran datasets.
- Rewrite working features unnecessarily.
- Refactor unrelated files.
- Change established architecture silently.

============================================================
32. IMPLEMENTATION WORKFLOW
============================================================

For every new feature:

STEP 1:
Inspect the existing project.

STEP 2:
Inspect existing Core infrastructure.

STEP 3:
Inspect existing feature patterns.

STEP 4:
Create the model.

STEP 5:
Create abstract Repository.

STEP 6:
Create RepositoryImpl.

STEP 7:
Create Cubit and states.

STEP 8:
Register dependencies in GetIt.

STEP 9:
Create View.

STEP 10:
Connect routing.

STEP 11:
Run:

flutter analyze

STEP 12:
Run the application.

STEP 13:
Manually test the complete flow.

STEP 14:
Explain the architecture and code.

Do NOT dump huge amounts of unexplained code.

============================================================
33. AI BEHAVIOR RULES
============================================================

When asked to implement a feature:

1. Inspect existing files first.
2. Do not assume file contents.
3. Reuse existing infrastructure.
4. Follow the established Settings coding pattern.
5. Keep code simple.
6. Preserve naming conventions.
7. Preserve Repository + RepoImpl.
8. Preserve Cubit.
9. Preserve GetIt.
10. Preserve Failure/Either.
11. Preserve Dio/Firebase/SharedPreferences responsibilities.

If an existing project decision conflicts with a new request:

STOP.

Explain the conflict.

Do NOT silently change the architecture.

============================================================
34. HOW TO HANDLE EXISTING CODE
============================================================

Existing code is more authoritative than assumptions.

Before modifying a file:

- Read it.
- Understand it.
- Identify the existing pattern.
- Make the smallest necessary change.

Do NOT rewrite entire files if only a small change is required.

Do NOT introduce a new style if an established project style already exists.

============================================================
35. PROFESSOR DISCUSSION PREPARATION
============================================================

The team must be able to explain:

Why Feature-Based Architecture?

Why MVVM?

Why Cubit?

Why Repository Pattern?

Why Repo and RepoImpl?

Why does Cubit not call Dio?

Why does Cubit not call Firebase?

What is ApiService?

What is Dio?

What is Either?

What is Failure?

How are exceptions converted into failures?

Why GetIt?

Why Firebase Authentication?

Why Firestore?

Why SharedPreferences?

Why Custom Backend?

Why does the backend exist?

Why is Firebase still required?

Difference between:

Azkar vs My Azkar

Prayers vs Prayer Tracker

How Quran data travels:

Backend
↓
Dio
↓
Repository
↓
Cubit
↓
View

How Settings travels:

SharedPreferences
↓
Repository
↓
Cubit
↓
MaterialApp

============================================================
36. CURRENT CHECKPOINT
============================================================

THIS IS WHERE WE ARE NOW.

Architecture:
COMPLETE

Core infrastructure:
COMPLETE

GetIt:
CONFIGURED

Dio:
CONFIGURED

Firebase:
CONFIGURED

SharedPreferences:
CONFIGURED

Settings:
COMPLETE

Settings UI:
WORKING

Theme integration:
WORKING

Language integration:
WORKING

Font Size integration:
WORKING

Persistence:
WORKING

TextStyle crash:
FIXED

Flutter analyzer:
Must remain clean after future changes.

Home:
NOT IMPLEMENTED

Auth:
NOT IMPLEMENTED YET

Quran:
NOT IMPLEMENTED YET

Azkar:
NOT IMPLEMENTED YET

Prayers:
NOT IMPLEMENTED YET

My Azkar:
NOT IMPLEMENTED YET

Prayer Tracker:
NOT IMPLEMENTED YET

============================================================
37. IMMEDIATE NEXT TASK
============================================================

The next major task is:

PHASE 3 — AUTH FEATURE

Before implementing Auth:

1. Inspect the current Auth folder.
2. Inspect FirebaseAuthService.
3. Inspect Failure/Exception classes.
4. Inspect GetIt.
5. Inspect routing.
6. Inspect existing model conventions.
7. Inspect the completed Settings feature.
8. Use Settings as the internal coding-style reference.

Then implement Auth using:

AuthView
↓
AuthCubit
↓
AuthRepo
↓
AuthRepoImpl
↓
FirebaseAuthService
↓
Firebase Authentication

Keep the implementation simple and consistent with the Settings implementation.

Do NOT implement Quran, Azkar, Prayers, My Azkar, Prayer Tracker, or Home yet unless explicitly requested.

============================================================
38. FINAL INSTRUCTION
============================================================

You are continuing an existing project.

Do NOT start from zero.

Do NOT redesign the architecture.

Do NOT assume the old architecture is still valid.

The CURRENT architecture is final:

Feature-Based
+
MVVM
+
Cubit
+
Repository Pattern
+
Dio
+
Firebase
+
SharedPreferences
+
GetIt

The CURRENT completed feature is:

Settings

The CURRENT next feature is:

Auth

Use the completed Settings feature as the primary reference for:

- Internal coding style
- Repository implementation style
- Cubit style
- State style
- Error handling
- GetIt registration
- View simplicity

Before writing code, inspect the actual project files and confirm the existing implementation.

Priority:

1. Correctness
2. Consistency
3. Simplicity
4. Professor explainability
5. Minimal changes
6. No unnecessary complexity

# CURRENT PROJECT STATUS

## Islamic App — ملاذ

The project follows the approved architecture and professor coding style defined in:

AI_RULES/00_MASTER_RULES.md
AI_RULES/01_ARCHITECTURE.md
AI_RULES/02_PROFESSOR_CODING_STYLE.md
AI_RULES/03_FEATURE_RULES.md
AI_RULES/04_WORKFLOW.md

DO NOT change the architecture unless explicitly approved by the user.

---

# AUTH FEATURE STATUS

Auth is currently implemented using:

Firebase Authentication
+
Google Sign-In
+
Cubit
+
Repository Pattern
+
GetIt

## Current Auth Flow

Email Login:

LoginView
↓
LoginCubit
↓
AuthRepo
↓
AuthRepoImpl
↓
FirebaseAuthService
↓
Firebase Authentication

Google Login:

LoginView
↓
LoginCubit
↓
AuthRepo
↓
AuthRepoImpl
↓
FirebaseAuthService
↓
Google Sign-In
↓
Firebase Authentication

---

# AUTH FILES

## Model

lib/features/auth/data/models/user_model.dart

UserModel contains:

- uid
- name
- email
- photoUrl

It includes:

- constructor
- copyWith()
- fromJson()
- toJson()

No generated models.

---

## Repository

lib/features/auth/data/repos/auth_repo.dart

AuthRepo currently supports:

- login()
- signup()
- loginWithGoogle()
- logout()

All methods use:

Either<Failure, T>

from:

package:dartz/dartz.dart

---

## Repository Implementation

lib/features/auth/data/repos/auth_repo_impl.dart

AuthRepoImpl depends on:

FirebaseAuthService

Responsibilities:

- call FirebaseAuthService
- convert Firebase User to UserModel
- catch AuthException
- return Failure through Either

It must not access Firebase directly.

---

## Firebase Service

lib/core/services/firebase_auth_service.dart

FirebaseAuthService currently supports:

- getCurrentUser()
- register()
- login()
- loginWithGoogle()
- logout()

Dependencies:

- FirebaseAuth
- GoogleSignIn

Constructor injection is supported:

FirebaseAuthService({
  FirebaseAuth? firebaseAuth,
  GoogleSignIn? googleSignIn,
})

Do not create another Firebase authentication service.

---

# LOGIN CUBIT

lib/features/auth/presentation/manager/login_cubit.dart

LoginCubit depends on:

AuthRepo

Current operations:

- login()
- loginWithGoogle()

Both operations emit:

LoginLoading
LoginSuccess
LoginFailure

Do not create separate Google-specific states unless explicitly required.

---

# LOGIN STATES

login_state.dart uses:

sealed class LoginState

States:

- LoginInitial
- LoginLoading
- LoginSuccess
- LoginFailure

No Equatable.
No Freezed.
No generated states.

---

# SIGNUP CUBIT

SignupCubit depends on:

AuthRepo

Current operation:

- signup()

States:

- SignupInitial
- SignupLoading
- SignupSuccess
- SignupFailure

---

# AUTH UI

LoginView supports:

- Email login
- Password login
- Google Sign-In
- Navigation to Signup

SignupView supports:

- Name
- Email
- Password
- Account creation
- Navigation to Home after successful signup

Views must remain thin.

Views must never access:

- FirebaseAuth
- GoogleSignIn
- Firestore
- Dio
- ApiConsumer
- SharedPreferences

---

# GOOGLE SIGN-IN STATUS

Google Sign-In has been implemented in:

FirebaseAuthService
↓
AuthRepoImpl
↓
LoginCubit
↓
LoginView

The Google dependency is already included in pubspec.yaml:

google_sign_in

The code has been implemented and integrated.

Before declaring Google Sign-In fully verified, test it on the actual Android target/device.

flutter analyze confirms code analysis only.
It does NOT prove that Firebase/Google Android configuration is working at runtime.

---

# ERROR HANDLING

Existing errors:

core/errors/exceptions.dart

- ServerException
- AuthException
- FirestoreException
- CacheException

Existing failures:

core/errors/failures.dart

- ServerFailure
- FirebaseAuthFailure
- FirebaseFirestoreFailure
- CacheFailure

Auth exceptions are converted to:

FirebaseAuthFailure

Do not create duplicate Failure classes.

---

# IMPORTANT CURRENT STATUS

The project currently has:

- Email Login implemented
- Email Signup implemented
- Logout implemented
- Google Sign-In implemented
- Auth Repository implemented
- FirebaseAuthService implemented
- LoginCubit implemented
- SignupCubit implemented
- LoginView implemented
- SignupView implemented

The latest implementation passed flutter analyze except for informational lints caused mainly by debug print statements and prefer_const_constructors.

Debug print statements should be removed before final cleanup.

---

# NEXT STEP

Do not rewrite Auth.

Do not refactor Auth unnecessarily.

The next task should continue incrementally from the existing project.

Preferred feature order:

Quran
↓
Prayers
↓
Azkar
↓
Auth
↓
My Azkar
↓
Prayer Tracker
↓
Settings
↓
Home Integration

Auth is already substantially implemented.

Do not proceed with unrelated work.

END OF MASTER CONTEXT