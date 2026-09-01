# PROFESSOR INTERNAL CODING STYLE

## Islamic App — ملاذ

This document defines HOW Dart/Flutter code should be written inside the approved architecture.

It does NOT redefine the architecture.

---

# 1. GENERAL STYLE

Code must be:

```text
Simple
Direct
Readable
Consistent
Student-friendly
Easy to explain
```

Avoid enterprise-style code.

---

# 2. CLASSES

Prefer simple Dart classes.

Example:

```dart
class ApiService {
  final ApiConsumer apiConsumer;

  ApiService({
    required this.apiConsumer,
  });
}
```

Avoid unnecessary inheritance and abstraction.

---

# 3. DEPENDENCIES

Use constructor injection.

Prefer:

```dart
class FeatureRepoImpl implements FeatureRepo {
  final ApiService apiService;

  FeatureRepoImpl({
    required this.apiService,
  });
}
```

Use `final`.

Do not instantiate dependencies manually inside the class.

---

# 4. CONSTRUCTORS

Keep constructors simple.

Preferred:

```dart
FeatureCubit(this.featureRepo) : super(FeatureInitial());
```

or:

```dart
FeatureRepoImpl({
  required this.apiService,
});
```

Do not add unnecessary constructor logic.

---

# 5. FINAL

Use `final` whenever a value does not need reassignment.

Example:

```dart
final response = await apiService.get(...);
final settings = SettingsModel(...);
```

---

# 6. ASYNC / AWAIT

Use ordinary:

```dart
Future<void>
```

and:

```dart
async
await
```

Keep asynchronous operations sequential and readable.

Example:

```dart
Future<void> loadData() async {
  emit(FeatureLoading());

  final result = await featureRepo.getData();

  result.fold(
    (failure) => emit(
      FeatureFailure(
        errorMessage: failure.message,
      ),
    ),
    (data) => emit(
      FeatureLoaded(
        data: data,
      ),
    ),
  );
}
```

---

# 7. REPOSITORY STYLE

Abstract repository:

```dart
abstract class FeatureRepo {
  Future<Either<Failure, FeatureModel>> getData();
}
```

Implementation:

```dart
class FeatureRepoImpl implements FeatureRepo {
  final ApiService apiService;

  FeatureRepoImpl({
    required this.apiService,
  });

  @override
  Future<Either<Failure, FeatureModel>> getData() async {
    try {
      final response = await apiService.get(...);

      final data = FeatureModel.fromJson(response);

      return right(data);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
```

Keep the flow obvious:

```text
call
 ↓
receive
 ↓
convert
 ↓
return
```

---

# 8. DARTZ

Use:

```dart
Either<Failure, T>
```

from:

```dart
package:dartz/dartz.dart
```

Success:

```dart
return right(data);
```

Failure:

```dart
return left(ServerFailure(e.toString()));
```

For void-style successful operations:

```dart
Either<Failure, Unit>
```

and:

```dart
return right(unit);
```

Do not create a custom Result class.

---

# 9. TRY / CATCH

Catch exceptions at the appropriate data/repository boundary.

Example:

```dart
try {
  final response = await apiService.get(...);

  return right(data);
} catch (e) {
  return left(ServerFailure(e.toString()));
}
```

Do not expose raw exceptions to the UI.

---

# 10. FAILURE

Use the existing project Failure classes.

Examples:

```text
ServerFailure
CacheFailure
FirebaseAuthFailure
FirebaseFirestoreFailure
```

Do not create duplicate error classes.

---

# 11. CUBIT

Cubit should be straightforward.

Example:

```dart
class FeatureCubit extends Cubit<FeatureState> {
  final FeatureRepo featureRepo;

  FeatureCubit(this.featureRepo) : super(FeatureInitial());

  Future<void> loadData() async {
    emit(FeatureLoading());

    final result = await featureRepo.getData();

    result.fold(
      (failure) => emit(
        FeatureFailure(
          errorMessage: failure.message,
        ),
      ),
      (data) => emit(
        FeatureLoaded(
          data: data,
        ),
      ),
    );
  }
}
```

No direct data-source access.

---

# 12. CUBIT STATES

Use:

```dart
part 'feature_state.dart';
```

and in state file:

```dart
part of 'feature_cubit.dart';
```

Use:

```dart
sealed class FeatureState {}
```

Then:

```dart
final class FeatureInitial extends FeatureState {}

final class FeatureLoading extends FeatureState {}

final class FeatureLoaded extends FeatureState {
  final FeatureModel data;

  FeatureLoaded({
    required this.data,
  });
}

final class FeatureFailure extends FeatureState {
  final String errorMessage;

  FeatureFailure({
    required this.errorMessage,
  });
}
```

No Equatable.

No Freezed.

No generated state classes.

---

# 13. STATE DESIGN

Prefer:

```text
Initial
Loading
Loaded
Failure
```

Only add another state when the feature genuinely requires it.

Do not create states just to make the architecture appear complex.

---

# 14. MODELS

Use manually written classes.

Example:

```dart
class SettingsModel {
  final bool isDarkMode;
  final String languageCode;
  final double fontSize;

  const SettingsModel({
    required this.isDarkMode,
    required this.languageCode,
    required this.fontSize,
  });
}
```

No generated models.

---

# 15. FROM JSON

Use direct parsing.

Example:

```dart
factory FeatureModel.fromJson(Map<String, dynamic> json) {
  return FeatureModel(
    name: json['name'] ?? '',
  );
}
```

Keep parsing readable.

Do not introduce DTO/Mapper layers.

---

# 16. TO JSON

Use:

```dart
Map<String, dynamic> toJson() {
  return {
    'name': name,
  };
}
```

Keep it direct.

---

# 17. COPYWITH

Use simple `copyWith()` when needed.

Example:

```dart
FeatureModel copyWith({
  String? name,
}) {
  return FeatureModel(
    name: name ?? this.name,
  );
}
```

---

# 18. API SERVICE

Use the existing API infrastructure.

Expected flow:

```text
RepositoryImpl
 ↓
ApiService
 ↓
ApiConsumer
 ↓
Dio
```

Do not call raw Dio from repositories if an existing ApiService is available.

---

# 19. DIO

The project already centralizes Dio behavior.

Do not duplicate:

* Headers
* Error conversion
* DioException handling
* Base URL logic

inside every feature.

Reuse Core API infrastructure.

---

# 20. VIEW

Keep Views thin.

Example style:

```dart
BlocBuilder<FeatureCubit, FeatureState>(
  builder: (context, state) {
    if (state is FeatureLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is FeatureFailure) {
      return Center(
        child: Text(state.errorMessage),
      );
    }

    if (state is FeatureLoaded) {
      return ...;
    }

    return const SizedBox();
  },
)
```

Keep UI code straightforward.

---

# 21. WIDGETS

Prefer standard Flutter widgets.

Examples:

```text
Scaffold
AppBar
Column
Row
Padding
ListView
ListTile
Text
Switch
Slider
DropdownButton
ElevatedButton
```

Do not create a custom widget for every tiny element.

---

# 22. COMMENTS

Do not comment obvious code.

Bad:

```dart
// Create response
final response = ...
```

Comments should explain WHY when necessary.

---

# 23. IMPORTS

Keep imports clean.

Remove unused imports.

Do not add imports that are not required.

---

# 24. NAMING

Use normal Dart naming.

Classes:

```text
SettingsModel
SettingsRepo
SettingsRepoImpl
SettingsCubit
SettingsState
SettingsView
```

Variables:

```text
settingsRepo
apiService
sharedPreferences
response
settings
updatedSettings
```

Methods:

```text
loadSettings()
toggleTheme()
changeLanguage()
updateFontSize()
```

---

# 25. NO CODE GENERATION

Do not use:

```text
Freezed
Equatable
json_serializable
build_runner
```

unless explicitly requested.

---

# 26. NO ENTERPRISE ABSTRACTIONS

Do not automatically add:

```text
UseCase
DTO
Mapper
DataSource
BaseRepository
BaseCubit
BaseState
Factory
Adapter
Interactor
```

If the code can be written directly, write it directly.

---

# 27. SIMPLICITY TEST

Before adding any class, ask:

> Can this be implemented simply inside the existing layer?

If YES:

Do it simply.

Do not create another class.

---

# 28. PROFESSOR TEST

Before finishing, ask:

> Could a student explain this class to the professor line by line?

If NO:

Simplify the implementation.

---

# 29. INTERNAL STYLE GOLDEN RULE

> **Write the simplest correct Dart code that naturally fits the existing project.**

Do not optimize for architectural sophistication.

Optimize for:

```text
Clarity
+
Consistency
+
Understanding
```
