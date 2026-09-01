# PROJECT ARCHITECTURE

## Islamic App — ملاذ

This document defines the approved architecture.

DO NOT change this architecture unless the user explicitly approves the change.

---

# 1. ARCHITECTURE

The project uses:

```text
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
```

---

# 2. FEATURE STRUCTURE

Standard feature:

```text
feature/
├── data/
│   ├── models/
│   └── repos/
│       ├── feature_repo.dart
│       └── feature_repo_impl.dart
│
└── presentation/
    ├── manager/
    │   ├── feature_cubit.dart
    │   └── feature_state.dart
    │
    └── views/
```

Use `manager/`, not `cubit/`.

---

# 3. CORE

```text
lib/
├── core/
│   ├── api/
│   ├── errors/
│   ├── routing/
│   ├── services/
│   ├── theme/
│   ├── utils/
│   ├── widgets/
│   └── di/
│
└── features/
```

Core contains shared infrastructure.

Feature-specific code stays inside its feature.

---

# 4. API FLOW

```text
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
```

Cubit must never call Dio directly.

View must never call Dio directly.

---

# 5. FIREBASE FLOW

```text
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
```

Cubit must never call Firebase directly.

View must never call Firebase directly.

---

# 6. LOCAL STORAGE FLOW

```text
View
 ↓
Cubit
 ↓
Repository
 ↓
RepositoryImpl
 ↓
SharedPreferences
```

Use SharedPreferences for simple local preferences.

---

# 7. FEATURES

## Auth

Source:

```text
Firebase Authentication
```

Responsibilities:

* Register
* Login
* Logout
* Authentication
* User profile

Flow:

```text
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
```

---

## Quran

Source:

```text
Custom Backend
```

Communication:

```text
Dio
```

Endpoints:

```text
GET /api/v1/quran/surahs
GET /api/v1/quran/surahs/:id
```

---

## Azkar

Source:

```text
Custom Backend
```

Endpoints:

```text
GET /api/v1/azkar
GET /api/v1/azkar/category/:category
```

---

## Prayers

Source:

```text
Custom Backend
```

Endpoint:

```text
GET /api/v1/prayers/timings
```

Backend uses Adhan for calculations.

---

## Home

Home is an aggregation/dashboard feature.

It can display:

* Hijri Date
* Today's information
* Next prayer
* Prayer times
* Quran shortcut
* Azkar shortcut
* User information

Home should not directly access Dio or Firebase.

---

## My Azkar

Source:

```text
Firebase Firestore
```

User-specific custom Azkar.

Responsibilities:

* Add
* Edit
* Delete
* Count
* Complete

---

## Prayer Tracker

Source:

```text
Firebase Firestore
```

Tracks the user's prayer completion.

This is different from Prayer Times.

---

## Settings

Source:

```text
SharedPreferences
```

Responsibilities:

* Theme
* Language
* Font Size

---

# 8. FAVORITES

Favorites are user-specific.

Source:

```text
Firebase Firestore
```

Favorites do not need to become a separate feature simply to increase the feature count.

---

# 9. REPOSITORY RESPONSIBILITY

Repository:

```text
Application-facing abstraction
```

RepositoryImpl:

```text
Actual implementation
```

Service:

```text
Low-level communication
```

Cubit:

```text
State management
```

View:

```text
UI
```

Model:

```text
Data representation / JSON conversion
```

---

# 10. DEPENDENCY INJECTION

Use:

```text
GetIt
```

Dependencies should be registered centrally.

Views and Cubits should receive dependencies rather than constructing them manually.

---

# 11. ERROR FLOW

```text
API / Firebase / Local Storage
 ↓
Exception
 ↓
Repository / RepositoryImpl
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
```

Use the existing:

```text
core/errors/
```

---

# 12. IMPORTANT DISTINCTIONS

Never confuse:

```text
Azkar ≠ My Azkar
```

```text
Prayers ≠ Prayer Tracker
```

```text
Custom Backend ≠ Firebase
```

```text
Repository ≠ RepositoryImpl
```

```text
Repository ≠ Service
```

---

# 13. CUSTOM BACKEND

Backend:

```text
Node.js
Express
TypeScript
```

Provides:

```text
Quran
Azkar
Prayer Times
Hijri Date
```

Flutter consumes it through Dio.

Firebase remains responsible for:

```text
Authentication
User-specific Firestore data
```

---

# 14. ARCHITECTURAL GOLDEN RULE

> NO DIRECT DATA ACCESS FROM THE UI.

The standard principle is:

```text
View
 ↓
Cubit
 ↓
Repository
 ↓
RepositoryImpl
 ↓
Data Source
 ↓
External System
```
