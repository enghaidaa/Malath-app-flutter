# AI MASTER RULES

## Islamic App — ملاذ

> **MANDATORY AI PROJECT RULES**

This file defines the highest-level rules for AI-assisted development in this project.

The AI MUST read and follow this file before implementing, modifying, refactoring, or deleting any Flutter/Dart code.

The AI must also read the other project rule files inside `AI_RULES/` when they are relevant.

---

# 1. PROJECT IDENTITY

Project:

**Islamic App — ملاذ**

Technology:

* Flutter
* Dart
* flutter_bloc / Cubit
* Dio
* Firebase Authentication
* Firebase Firestore
* SharedPreferences
* GetIt
* dartz
* Custom Node.js / Express / TypeScript Backend

This is a university project.

The professor evaluates both:

1. The implementation.
2. The student's ability to understand and explain the implementation.

Therefore:

> Code must be understandable before it is sophisticated.

---

# 2. HIGHEST PRIORITY PRINCIPLE

The most important rule is:

> **DO NOT CHANGE ESTABLISHED ARCHITECTURAL DECISIONS SILENTLY.**

The architecture has already been decided.

Use:

```text
Feature-Based Architecture
+
MVVM
+
Cubit
+
Repository Pattern
+
Repository Implementation
+
Dio
+
Firebase
+
SharedPreferences
+
GetIt
+
Dartz Either
```

Do NOT replace the architecture with another architecture.

---

# 3. AI MUST INSPECT BEFORE CODING

Before writing or modifying code, the AI MUST:

1. Inspect the existing project structure.
2. Inspect the relevant feature.
3. Inspect `lib/core/`.
4. Inspect similar existing implementations.
5. Inspect GetIt/service locator registration.
6. Inspect routing if the feature requires routing.
7. Read the relevant files inside `AI_RULES/`.
8. Identify the existing internal coding style.
9. Only then implement the requested change.

Do NOT assume that generic Flutter best practices are more important than the existing project conventions.

The existing project conventions have priority.

---

# 4. ARCHITECTURE VS CODING STYLE

These are two different things.

Architecture answers:

> WHERE does the code belong?

Coding style answers:

> HOW should the code be written?

The AI MUST follow both.

The architecture is defined in:

```text
AI_RULES/01_ARCHITECTURE.md
```

The professor's internal coding style is defined in:

```text
AI_RULES/02_PROFESSOR_CODING_STYLE.md
```

Feature-specific rules are defined in:

```text
AI_RULES/03_FEATURE_RULES.md
```

Development workflow is defined in:

```text
AI_RULES/04_WORKFLOW.md
```

---

# 5. DO NOT OVER-ENGINEER

This is a university project.

Do NOT automatically introduce:

* UseCases
* Interactors
* DTOs
* Mappers
* Generic repositories
* Base repositories
* Base Cubits
* Base states
* DataSource abstractions
* Factories
* Adapters
* Service factories
* Complex dependency graphs
* Generic result wrappers
* Additional architecture layers

unless the existing project explicitly requires them or the user explicitly requests them.

The project should remain:

```text
Simple
Direct
Readable
Consistent
Explainable
```

---

# 6. DO NOT ADD TECHNOLOGIES WITHOUT PERMISSION

Do not add new packages or technologies just because they are popular.

Do not introduce:

```text
Freezed
Equatable
json_serializable
Riverpod
Provider
GetX
Hive
Isar
Drift
Retrofit
Bloc code generation
Clean Architecture frameworks
```

unless explicitly requested.

The current technology stack is intentional.

---

# 7. NO DIRECT DATA ACCESS FROM VIEW

Never write:

```text
View → Dio
```

Never write:

```text
View → Firebase
```

Never write:

```text
View → SharedPreferences
```

The View communicates with the Cubit.

---

# 8. NO DIRECT DATA ACCESS FROM CUBIT

Never write:

```text
Cubit → Dio
```

Never write:

```text
Cubit → Firebase
```

Never write:

```text
Cubit → SharedPreferences
```

The Cubit communicates with the Repository abstraction.

---

# 9. STANDARD DATA FLOW

For API features:

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

For Firebase features:

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

For local settings:

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

---

# 10. REPOSITORY RULE

When a feature accesses external or persistent data, use:

```text
Repository
+
RepositoryImpl
```

The abstract repository defines:

> WHAT operations are available.

The implementation defines:

> HOW those operations are performed.

The Cubit must depend on the abstract Repository.

Example:

```dart
class FeatureCubit extends Cubit<FeatureState> {
  final FeatureRepo featureRepo;

  FeatureCubit(this.featureRepo) : super(FeatureInitial());
}
```

Do NOT inject `FeatureRepoImpl` into the Cubit.

---

# 11. ERROR HANDLING

Repository methods use:

```dart
Either<Failure, T>
```

from:

```dart
package:dartz/dartz.dart
```

Technical exceptions must be converted into project-level Failures.

Concept:

```text
Exception
 ↓
Repository
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

Do not expose technical exceptions directly to the View.

Use the existing error system inside:

```text
lib/core/errors/
```

---

# 12. CUBIT RULE

Cubit is responsible for:

* Calling repository methods.
* Managing loading state.
* Handling success.
* Handling failure.
* Updating UI state.

Cubit is NOT responsible for:

* HTTP implementation.
* Firebase implementation.
* SharedPreferences implementation.
* API URLs.
* Data storage.
* JSON parsing.

Use:

```dart
result.fold(
  (failure) => emit(...),
  (data) => emit(...),
);
```

---

# 13. STATE RULE

Use:

```dart
part 'feature_state.dart';
```

and:

```dart
part of 'feature_cubit.dart';
```

Use:

```dart
sealed class FeatureState {}
```

with simple states.

Normally:

```text
Initial
Loading
Loaded / Success
Failure
```

Do not create unnecessary states.

---

# 14. VIEW RULE

Views must remain thin.

The View handles:

* Layout.
* Widgets.
* User interaction.
* Displaying Cubit state.
* Calling Cubit methods.

The View must NOT contain:

* API logic.
* Firebase logic.
* Repository logic.
* SharedPreferences logic.
* Data parsing.
* Business/data access logic.

Use:

```dart
BlocBuilder
```

for UI rebuilding.

Use:

```dart
BlocListener
```

for side effects.

Use:

```dart
BlocConsumer
```

when both are required.

---

# 15. MODEL RULE

Use simple Dart classes.

Prefer:

```dart
class FeatureModel {
  final String name;

  const FeatureModel({
    required this.name,
  });
}
```

When JSON conversion is required, manually implement:

```dart
fromJson()
```

and:

```dart
toJson()
```

Do not automatically introduce generated serialization.

Use `copyWith()` where updating immutable model values is useful.

---

# 16. DEPENDENCY INJECTION

Use the existing:

```dart
GetIt.instance
```

service locator.

Dependencies should be injected through constructors.

Do not instantiate repositories/services manually inside Views or Cubits.

Do not create multiple service locators.

---

# 17. CORE RULE

The Core layer contains shared infrastructure.

Examples:

```text
core/api
core/errors
core/routing
core/services
core/theme
core/utils
core/widgets
core/di
```

Do not put feature-specific models inside Core.

Examples:

```text
SurahModel → Quran
AyahModel → Quran
AzkarModel → Azkar
PrayerTimesModel → Prayers
CustomZikrModel → My Azkar
```

---

# 18. FEATURE SEPARATION

Never mix:

```text
General Azkar
```

with:

```text
My Azkar
```

General Azkar:

```text
Custom Backend
```

My Azkar:

```text
Firebase Firestore
```

Never mix:

```text
Prayer Times
```

with:

```text
Prayer Tracker
```

Prayer Times:

```text
Custom Backend
```

Prayer Tracker:

```text
Firebase Firestore
```

---

# 19. BACKEND VS FIREBASE

Custom Backend handles public/general application data:

```text
Quran
Azkar
Prayer Times
Hijri Date
```

Firebase handles:

```text
Authentication
User-specific Firestore data
My Azkar
Favorites
Prayer Tracker
```

SharedPreferences handles:

```text
Theme
Language
Font Size
```

Do NOT replace Firebase with the Custom Backend.

Do NOT move user-specific data to the public backend.

---

# 20. PROFESSOR STYLE HAS PRIORITY

The professor's demonstrated style should be followed.

The implementation should be:

```text
Simple
Direct
Structured
Student-friendly
Easy to explain
```

Do not make the code unnecessarily enterprise-level.

If two implementations are technically valid, choose the one that is:

1. Simpler.
2. Shorter.
3. Easier to understand.
4. Easier to explain.
5. More consistent with existing files.

---

# 21. EXISTING CODE HAS PRIORITY OVER GENERIC AI HABITS

Do not automatically apply generic AI coding patterns.

Before creating a class, ask:

```text
Does this project already have a pattern for this?

Does a similar feature already solve this problem?

Can I reuse existing infrastructure?

Am I creating an unnecessary abstraction?

Would the professor expect a student to write this this way?
```

If the answer indicates a simpler existing pattern, follow that pattern.

---

# 22. NO UNRELATED REFACTORING

When implementing a requested feature:

Do NOT refactor unrelated files.

Do NOT rename unrelated classes.

Do NOT restructure the entire project.

Do NOT change working Core infrastructure without a reason.

Do NOT modify another feature unless required for integration.

Keep changes scoped to the requested task.

---

# 23. CONFLICT RULE

If a new requirement conflicts with the established architecture:

DO NOT silently change the architecture.

Report:

```text
ARCHITECTURAL CONFLICT

Current architecture:
...

Requested change:
...

Conflict:
...

Recommended solution:
...
```

Then wait for user approval before making an architectural change.

---

# 24. VERIFICATION RULE

After implementation, run static analysis when available:

```text
flutter analyze
```

If tests exist and are relevant, run the relevant tests.

Do not claim:

```text
Everything works perfectly.
```

just because static analysis passed.

Distinguish between:

```text
Static analysis
Compilation
Unit tests
Runtime testing
```

---

# 25. CODE OUTPUT RULE

When the user asks for implementation, provide complete files.

Always specify:

```text
FILE:
lib/...
```

Then provide the complete implementation.

Do not omit imports.

Do not use placeholders such as:

```dart
...
```

to represent missing implementation.

Do not provide pseudo-code when real Dart code is requested.

---

# 26. EXPLANATION RULE

After implementation, explain briefly:

* What each file does.
* Why it exists.
* How the data flows.
* Why the implementation follows the architecture.

Do not give unnecessary theoretical explanations.

The explanation should help the student defend the code to the professor.

---

# 27. FINAL AI CHECK

Before generating code, internally verify:

```text
[ ] I inspected the existing project.
[ ] I checked similar implementations.
[ ] I read the relevant AI_RULES files.
[ ] I am not changing the architecture.
[ ] I am not adding unnecessary technologies.
[ ] I am not adding unnecessary abstractions.
[ ] The Cubit only communicates with Repository.
[ ] RepositoryImpl handles data access.
[ ] Views remain thin.
[ ] Either/Failure is used correctly.
[ ] Existing Core infrastructure is reused.
[ ] Existing GetIt is reused.
[ ] Naming matches the project.
[ ] Code is simple enough for a student to explain.
```

---

# 28. GOLDEN RULE

> **DO NOT WRITE THE MOST ADVANCED CODE YOU CAN WRITE.**
>
> **WRITE THE SIMPLEST CORRECT CODE THAT FITS THIS PROJECT.**

The objective is not to impress the professor with complexity.

The objective is to demonstrate:

```text
Understanding
+
Correct Architecture
+
Clean Separation
+
Simple Implementation
+
Consistency
```

---

# 29. FINAL INSTRUCTION

Treat the files inside `AI_RULES/` as the project's permanent AI development rules.

These rules are more important than generic coding preferences.

Whenever there is uncertainty:

1. Inspect existing code.
2. Follow existing project patterns.
3. Prefer simplicity.
4. Preserve architecture.
5. Do not introduce unnecessary complexity.

The AI is an implementation assistant for this project.

It is NOT the architect of the project unless the user explicitly asks for architectural changes.
