# MASTER CONTEXT — MALAZ ISLAMIC APP

# Flutter University Project — CURRENT DEVELOPMENT CHECKPOINT

This document is the authoritative project context for the current state of:

**"ملاذ — Islamic App"**

IMPORTANT:

The project is already substantially implemented.

Do NOT restart the project.

Do NOT rebuild completed features.

Do NOT redesign the architecture.

Continue from the CURRENT CHECKPOINT described at the end of this document.

---

# 1. PROJECT OVERVIEW

The project is a Flutter Islamic mobile application called:

**"ملاذ"**

Main features:

1. Authentication
2. Quran
3. Azkar
4. Prayer Times
5. Home
6. My Azkar
7. Prayer Tracker
8. Settings

Additional functionality:

* Favorites
* Hijri Date
* User Profile
* Local Preferences

The project also contains a separate Custom Backend built with:

* Node.js
* Express
* TypeScript
* CORS
* Helmet
* Dotenv
* Adhan

The Custom Backend exists mainly to satisfy the professor's backend requirement and obtain the +3 bonus.

Firebase MUST remain in the project.

The Custom Backend does NOT replace Firebase.

---

# 2. PROFESSOR REQUIREMENTS

The professor requires the Flutter project to demonstrate:

* Feature-Based Architecture
* MVVM Architecture
* Cubit
* Dio
* Firebase Authentication
* Firebase Firestore
* SharedPreferences
* At least 4 API endpoints
* At least 6 features

The project now contains all required major features.

The project must remain:

* Simple
* Direct
* Readable
* Student-friendly
* Easy to explain
* Consistent

Do NOT make the project enterprise-grade.

---

# 3. FINAL FLUTTER ARCHITECTURE

The project uses:

Feature-Based Architecture

*

MVVM

*

Cubit

*

Repository Pattern

*

Dio

*

Firebase

*

SharedPreferences

*

GetIt

Main flow:

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

ApiService

↓

ApiConsumer

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

UI must NEVER directly access external data sources.

---

# 4. PROFESSOR INTERNAL CODING STYLE

The professor's coding style is:

Simple

Direct

Explicit

Readable

Student-friendly

Prefer:

* final
* required constructor parameters
* simple methods
* simple try/catch
* simple result.fold()
* simple state classes
* simple models
* simple repositories

Avoid:

* Generic abstractions
* Generic base repositories
* Generic Cubits
* Generic states
* UseCase layers
* DTO layers
* Mapper layers
* DataSource layers unless genuinely required
* Excessive helper classes
* Enterprise patterns
* Over-engineering

Golden rule:

> Write the simplest correct Dart code that naturally fits the existing project.

Professor test:

> Could a student explain this class to the professor line by line?

If not, simplify it.

---

# 5. CORE INFRASTRUCTURE — COMPLETE

Core infrastructure is implemented.

Expected structure:

lib/

└── core/

```
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
```

Exact files may evolve.

Core contains shared infrastructure only.

Feature-specific models MUST remain inside their features.

---

# 6. API INFRASTRUCTURE — COMPLETE

Dio is configured centrally.

ApiConsumer provides:

* get()
* post()
* put()
* delete()

DioConsumer implements ApiConsumer.

ApiService communicates with ApiConsumer.

Expected flow:

RepositoryImpl

↓

ApiService

↓

ApiConsumer

↓

Dio

↓

Backend

Dio configuration includes:

* Base URL
* Connection timeout
* Receive timeout
* Send timeout
* JSON headers
* Centralized DioException handling

Do NOT duplicate Dio configuration inside features.

---

# 7. CURRENT BACKEND URL

The Flutter application currently uses:

https://islamic-app-backend.vercel.app

The API endpoints are centralized in:

core/api/end_points.dart

Current endpoints:

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

The required API endpoint requirement is already satisfied.

---

# 8. FIREBASE INFRASTRUCTURE — COMPLETE

Firebase is configured and remains part of the application.

Firebase Authentication is used for:

* Register
* Login
* Logout
* Google Sign-In
* User authentication

Firebase Firestore is used for user-specific data:

* My Azkar
* Prayer Tracker
* Favorites / future user-specific data

Firebase MUST NOT be replaced by the Custom Backend.

---

# 9. FIRESTORE SERVICE — COMPLETE

FirebaseFirestoreService exists in:

core/services/firebase_firestore_service.dart

It currently supports:

* addData()
* getData()
* getCollectionData()
* updateData()
* deleteData()

It converts Firebase exceptions into:

FirestoreException

The feature repositories use this service.

The UI and Cubits MUST NOT access Firestore directly.

---

# 10. SHARED PREFERENCES — COMPLETE

SharedPreferences is used for local settings.

Settings include:

* Theme
* Language
* Font Size

Keys:

is_dark_mode

language_code

font_size

Settings MUST NOT use Firestore.

Settings MUST NOT use the Custom Backend.

---

# 11. GET IT — COMPLETE

GetIt is configured through:

core/di/service_locator.dart

It registers the required:

* SharedPreferences
* Dio
* ApiConsumer
* ApiService
* FirebaseAuthService
* FirebaseFirestoreService
* Repositories
* Cubits

Repositories depend on abstractions.

Cubits depend on repository abstractions.

Constructor injection is used.

---

# 12. ERROR HANDLING — COMPLETE

Existing exceptions:

* ServerException
* AuthException
* FirestoreException
* CacheException

Existing failures:

* ServerFailure
* FirebaseAuthFailure
* FirebaseFirestoreFailure
* CacheFailure

Repositories use:

Either<Failure, T>

from:

package:dartz/dartz.dart

Expected flow:

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

Do NOT create duplicate error classes.

---

# 13. AUTH FEATURE — IMPLEMENTED

Source:

Firebase Authentication

Authentication supports:

* Email Login
* Email Signup
* Logout
* Google Sign-In

Flow:

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

Google:

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

Auth is considered implemented.

Do NOT rebuild Auth.

Google Sign-In should be runtime-tested on the actual Android target before final submission.

---

# 14. QURAN FEATURE — IMPLEMENTED

Source:

Custom Backend

Implemented responsibilities:

* Surah list
* Surah details
* Ayahs
* Juz
* Page
* Hizb Quarter

Models:

* AyahModel
* SurahModel

Repository:

* QuranRepo
* QuranRepoImpl

Cubit:

* QuranCubit

States:

* QuranInitial
* QuranLoading
* QuranLoaded
* SurahLoaded
* QuranFailure

Views:

* QuranView
* SurahDetailsView

API flow:

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

Backend

The Quran feature is functionally implemented.

The current UI is basic/testing UI and will be improved during the UI phase.

---

# 15. AZKAR FEATURE — IMPLEMENTED

Source:

Custom Backend

Endpoint:

GET /api/v1/azkar

Implemented categories include:

* Morning Azkar
* Evening Azkar
* After Prayer Azkar

Azkar data includes:

* id
* text
* translation
* transliteration
* repetitions
* benefit
* reference

General Azkar is separate from My Azkar.

The Azkar feature is functionally implemented.

The current UI can be improved during the UI phase.

---

# 16. MY AZKAR FEATURE — IMPLEMENTED

Source:

Firebase Firestore

My Azkar is user-specific.

Responsibilities include:

* Add
* Edit
* Delete
* Count
* Complete

Example:

Subhan Allah

Target:

100

Counter:

100

Counter progression:

100 → 99 → 98 → ... → 0

When:

counter == 0

the Zikr is considered completed.

The feature uses:

View

↓

Cubit

↓

Repository

↓

RepositoryImpl

↓

FirebaseFirestoreService

↓

Firestore

My Azkar MUST remain separate from General Azkar.

---

# 17. PRAYER TIMES FEATURE — IMPLEMENTED

Source:

Custom Backend

Endpoint:

GET /api/v1/prayers/timings

The feature provides:

* Fajr
* Sunrise
* Dhuhr
* Asr
* Maghrib
* Isha
* Hijri Date
* Location
* Calculation Method

Current model:

PrayerTimingsModel

Repository:

* PrayerRepo
* PrayerRepoImpl

Cubit:

* PrayerCubit

States:

* PrayerInitial
* PrayerLoading
* PrayerLoaded
* PrayerFailure

The feature uses:

View

↓

Cubit

↓

PrayerRepo

↓

PrayerRepoImpl

↓

ApiService

↓

Dio

↓

Backend

Prayer Times is separate from Prayer Tracker.

The feature is functionally implemented.

The UI will be refined during the UI phase.

---

# 18. PRAYER TRACKER FEATURE — IMPLEMENTED

Source:

Firebase Firestore

Prayer Tracker tracks whether the user performed prayers.

It is separate from Prayer Times.

Prayer Times answers:

"When is the prayer?"

Prayer Tracker answers:

"Did the user perform the prayer?"

The feature is functionally implemented.

The UI will be refined during the UI phase.

---

# 19. SETTINGS FEATURE — COMPLETE

Settings uses:

SharedPreferences

Responsibilities:

* Theme
* Language
* Font Size

Settings files include:

* settings_model.dart
* settings_repo.dart
* settings_repo_impl.dart
* settings_cubit.dart
* settings_state.dart
* settings_view.dart

Settings is globally integrated.

Theme:

SettingsCubit

↓

MaterialApp

↓

themeMode

Language:

SettingsCubit

↓

MaterialApp

↓

locale

Font Size:

SettingsCubit

↓

centralized text styling

↓

application UI

Persistence is working.

The previous TextStyle/fontSize crash was fixed.

Settings is considered complete.

---

# 20. HOME FEATURE — CURRENT STATUS

Home is NOT yet the final production UI.

A temporary Home/Test screen was previously used to test features.

The temporary screen MUST NOT be treated as the final Home.

The final Home will be built during the current UI phase.

Home will eventually provide the main application dashboard.

Possible content:

* Hijri Date
* Today's information
* Next Prayer
* Prayer Times
* Quran shortcut
* Azkar shortcut
* My Azkar shortcut
* Prayer Tracker shortcut
* User information
* Other important daily information

IMPORTANT:

Home must remain a UI/dashboard layer.

Home MUST NOT directly access:

* Dio
* Firebase
* Firestore
* SharedPreferences

If Home needs data, it communicates through the appropriate Cubit/Repository architecture.

---

# 21. ROUTING — CURRENT STATUS

Routes exist for:

* Login
* Signup
* Home
* Quran
* Surah Details
* Azkar
* Prayers
* My Azkar
* Prayer Tracker
* Settings

Completed feature routes should remain connected.

The current routing implementation already supports:

QuranView

SurahDetailsView

SettingsView

Other implemented features should be connected to their actual Views.

Placeholder routes should be removed or replaced as the final UI is completed.

Do NOT silently change route names.

---

# 22. CURRENT UI STATUS

The application has functional feature implementations.

However, the current UI is still basic in several features.

The next development phase is therefore:

# PHASE — UI IMPLEMENTATION & INTEGRATION

This phase focuses on:

* Final visual design
* Custom reusable widgets
* Feature UI
* Home UI
* Navigation
* Consistent spacing
* Typography
* Colors
* Cards
* Buttons
* Loading UI
* Error UI
* Empty states
* RTL support
* Arabic presentation
* Responsive layouts

IMPORTANT:

Do NOT rebuild the backend/data architecture during this phase.

The existing Cubits, Repositories, Services, Models and APIs should be reused.

---

# 23. CUSTOM WIDGETS

Before building complex screens, inspect the existing Core widgets.

Shared widgets belong in:

core/widgets/

Examples:

* CustomButton
* CustomTextField
* CustomLoading

During the UI phase, create a custom widget ONLY when:

1. It is reused.
2. It represents a consistent application design element.
3. It makes the View easier to read.

Do NOT create a custom widget for every tiny UI element.

Avoid unnecessary abstraction.

A widget used only once can remain directly inside the View unless there is a clear reason to extract it.

---

# 24. THEME

The application has centralized theme files:

core/theme/

* app_colors.dart
* app_styles.dart
* app_theme.dart

All final UI should reuse the centralized theme.

Do NOT scatter random colors and text styles throughout the application.

When a design value is repeated across multiple screens, consider placing it in the appropriate centralized theme file.

Keep the theme simple and easy to explain.

---

# 25. UI DEVELOPMENT ORDER

The UI phase should be implemented in a controlled order.

Recommended order:

1. Review existing theme
2. Review/create shared custom widgets
3. Final Home UI
4. Quran UI
5. Surah Details UI
6. Azkar UI
7. Prayer Times UI
8. My Azkar UI
9. Prayer Tracker UI
10. Auth UI refinement
11. Settings UI refinement
12. Navigation / final integration
13. Empty / Loading / Error states
14. RTL and Arabic UI review
15. Final application testing

Do NOT rebuild feature logic while doing UI unless a real bug is discovered.

---

# 26. VIEW STYLE

Views must remain thin.

Preferred style:

BlocBuilder<Cubit, State>

↓

Loading

↓

Failure

↓

Loaded

↓

UI

Views should not contain:

* API calls
* Firebase calls
* Firestore calls
* Dio calls
* SharedPreferences calls
* Business logic

UI logic should remain straightforward.

---

# 27. CUBIT STYLE

Cubits remain simple.

Typical state structure:

Initial

Loading

Loaded / Success

Failure

Use:

result.fold()

Do NOT add unnecessary states.

Do NOT add Equatable.

Do NOT add Freezed.

Do NOT add generated states.

Do NOT move UI code into Cubits.

---

# 28. MODEL STYLE

Models remain manually written.

Use:

* final
* const constructors where appropriate
* fromJson()
* toJson()
* copyWith() when needed

Do NOT introduce:

* json_serializable
* Freezed
* DTOs
* Mapper layers

unless explicitly approved.

---

# 29. REPOSITORY STYLE

Repositories remain:

abstract Repository

*

RepositoryImpl

Expected flow:

call

↓

receive

↓

convert

↓

return

Example:

try {

final response = await apiService.get(...);

final data = FeatureModel.fromJson(...);

return right(data);

} catch (e) {

return left(
ServerFailure(e.toString()),
);

}

Keep repository code obvious.

---

# 30. FIREBASE RESPONSIBILITIES

Firebase remains responsible for:

Authentication:

* Login
* Signup
* Logout
* Google Sign-In
* User identity

Firestore:

* My Azkar
* Prayer Tracker
* Favorites
* User-specific data

Do NOT move general Quran/Azkar/Prayer data into Firestore.

---

# 31. CUSTOM BACKEND RESPONSIBILITIES

The Custom Backend remains responsible for:

* Quran
* General Azkar
* Prayer Times
* Hijri Date

Flutter communicates with it through:

Dio

Do NOT bypass the backend from Flutter using public APIs.

---

# 32. IMPORTANT DISTINCTIONS

General Azkar:

Backend data

↓

Azkar Feature

My Azkar:

User-specific data

↓

Firestore

Prayer Times:

Backend calculation/data

Prayer Tracker:

User-specific prayer completion data

Settings:

Local preferences

↓

SharedPreferences

These responsibilities MUST remain separate.

---

# 33. DEVELOPMENT WORKFLOW FROM THIS POINT

For every UI task:

STEP 1:

Inspect the existing feature implementation.

STEP 2:

Inspect the existing Model.

STEP 3:

Inspect Cubit and State.

STEP 4:

Inspect Repository.

STEP 5:

Reuse existing data flow.

STEP 6:

Inspect theme and existing widgets.

STEP 7:

Build/reuse custom widgets where appropriate.

STEP 8:

Build the View.

STEP 9:

Connect the existing Cubit.

STEP 10:

Connect routing.

STEP 11:

Run:

flutter analyze

STEP 12:

Run the application.

STEP 13:

Manually test the screen.

STEP 14:

Only then move to the next screen.

---

# 34. DO NOT DO

NEVER:

* Restart the project
* Rebuild completed features
* Replace Firebase
* Replace the Custom Backend
* Put Dio in Views
* Put Firebase in Views
* Put Firestore in Views
* Put SharedPreferences in Views
* Put API URLs inside Cubits
* Create unnecessary UseCases
* Create unnecessary DTOs
* Create unnecessary DataSources
* Add Freezed
* Add Equatable
* Add code generation
* Create a custom widget for every tiny element
* Create enterprise abstractions
* Rewrite working code unnecessarily
* Refactor unrelated files
* Change established architecture silently
* Mix General Azkar with My Azkar
* Mix Prayer Times with Prayer Tracker

---

# 35. TESTING REQUIREMENT

After every meaningful change:

Run:

flutter analyze

The analyzer should remain clean.

Then run the application and manually test the changed feature.

Final testing should include:

* Login
* Signup
* Google Sign-In
* Logout
* Quran list
* Surah details
* Azkar categories
* Azkar details
* Prayer Times
* My Azkar
* Prayer Tracker
* Settings
* Theme persistence
* Language persistence
* Font size persistence
* Navigation
* Firebase operations
* Backend API operations

---

# 36. GIT STATUS

The project has already reached the point where the major feature implementations have been completed.

Previous feature commits may exist.

From this checkpoint onward:

UI changes should be committed incrementally.

Recommended commit style:

feat(ui): build home dashboard

feat(ui): add shared custom widgets

feat(ui): improve quran screens

feat(ui): build azkar screens

feat(ui): build prayer screens

feat(ui): build my azkar screen

feat(ui): build prayer tracker screen

feat(ui): finalize app navigation

Do NOT create one enormous unexplained commit containing unrelated changes.

---

# 37. CURRENT PROJECT STATUS

## Architecture

COMPLETE

## Core Infrastructure

COMPLETE

## Dio

COMPLETE

## Custom Backend

COMPLETE

## Firebase Authentication

IMPLEMENTED

## Google Sign-In

IMPLEMENTED

## Firestore

CONFIGURED AND IMPLEMENTED

## SharedPreferences

IMPLEMENTED

## GetIt

CONFIGURED

## Settings

COMPLETE AND WORKING

## Quran

FUNCTIONALLY IMPLEMENTED

## Azkar

FUNCTIONALLY IMPLEMENTED

## Prayer Times

FUNCTIONALLY IMPLEMENTED

## My Azkar

FUNCTIONALLY IMPLEMENTED

## Prayer Tracker

FUNCTIONALLY IMPLEMENTED

## Home

FINAL UI NOT YET IMPLEMENTED

## Custom UI System

CURRENT PHASE

---

# 38. CURRENT CHECKPOINT

THIS IS THE MOST IMPORTANT SECTION.

The project is NO LONGER in the "build features/backend" phase.

The major application features have already been implemented.

The project is now entering:

# PHASE — FINAL UI & DESIGN

The immediate priorities are:

1. Inspect existing theme
2. Build/review reusable Custom Widgets
3. Build the final Home UI
4. Integrate existing feature screens
5. Improve Quran UI
6. Improve Azkar UI
7. Improve Prayer Times UI
8. Improve My Azkar UI
9. Improve Prayer Tracker UI
10. Polish Auth UI
11. Polish Settings UI
12. Final navigation
13. Loading/Error/Empty states
14. RTL/Arabic review
15. Full application testing
16. flutter analyze
17. Final Git cleanup

IMPORTANT:

The next task is NOT:

* Backend
* API
* Repository creation
* Model creation
* Firebase setup
* New architecture

The next task is:

**UI DESIGN + CUSTOM REUSABLE WIDGETS**

---

# 39. UI PHILOSOPHY

The UI should feel like one application.

Not:

Quran screen designed separately.

Azkar screen designed separately.

Prayer screen designed separately.

Instead:

All screens should share:

* Colors
* Typography
* Border radius
* Cards
* Buttons
* Spacing
* Icons
* Loading indicators
* Error presentation
* Navigation style

The application should have a consistent visual identity for:

**ملاذ**

The design should prioritize:

* Simplicity
* Calm Islamic visual identity
* Readability
* Arabic RTL support
* Modern mobile UI
* Clean spacing
* Easy navigation

Do not sacrifice explainability for visual complexity.

---

# 40. FINAL GOLDEN RULE

The project is now in the UI phase.

Therefore:

> **Do not build what already exists. Improve and integrate what already exists.**

And:

> **Build the simplest clean UI that makes the existing architecture look complete.**

The architecture is established.

The features are implemented.

The next job is to make the application feel like a finished product.

# END OF CURRENT MASTER CONTEXT
