# AI DEVELOPMENT WORKFLOW

## Islamic App — ملاذ

This file defines how AI should work on the project.

---

# STEP 1 — UNDERSTAND THE REQUEST

Identify exactly what the user requested.

Do not implement additional features unless required.

---

# STEP 2 — INSPECT

Before coding, inspect:

```text
Project structure
Relevant feature
Core
Similar existing feature
GetIt
Routing
Models
Repositories
Cubit patterns
Views
```

---

# STEP 3 — READ RULES

Read the relevant:

```text
AI_RULES/00_MASTER_RULES.md
AI_RULES/01_ARCHITECTURE.md
AI_RULES/02_PROFESSOR_CODING_STYLE.md
AI_RULES/03_FEATURE_RULES.md
AI_RULES/04_WORKFLOW.md
```

---

# STEP 4 — IDENTIFY EXISTING PATTERN

Find the closest existing implementation.

For example:

If implementing Quran:

Inspect an existing API-based feature.

If implementing My Azkar:

Inspect an existing Firebase/Firestore feature.

If implementing Settings:

Inspect local storage implementation.

Follow the established internal style.

---

# STEP 5 — IMPLEMENT INCREMENTALLY

Preferred sequence:

```text
Model
 ↓
Repository abstraction
 ↓
RepositoryImpl
 ↓
Cubit
 ↓
State
 ↓
View
 ↓
GetIt
 ↓
Routing
```

Only create files that are actually required.

---

# STEP 6 — ERROR HANDLING

Ensure:

```text
Exception
 ↓
Failure
 ↓
Either
 ↓
Cubit
 ↓
State
 ↓
View
```

Do not leak technical exceptions.

---

# STEP 7 — DEPENDENCY INJECTION

Register required dependencies using existing GetIt.

Do not create another service locator.

---

# STEP 8 — ROUTING

Only modify routing when the feature actually needs a route.

Do not make unrelated routing changes.

---

# STEP 9 — STATIC ANALYSIS

Run:

```text
flutter analyze
```

Fix actual issues.

Do not perform unrelated refactoring merely because you are touching the file.

---

# STEP 10 — TESTING

If relevant tests exist:

Run them.

Distinguish between:

```text
Analysis
Compilation
Unit tests
Runtime testing
```

Do not claim runtime behavior was verified if the app was not actually run.

---

# STEP 11 — REVIEW

Before finishing, check:

```text
Architecture
Coding Style
Error Handling
DI
State Management
UI Separation
Naming
Imports
Unused code
```

---

# STEP 12 — FINAL REPORT

After implementation, report:

```text
Implementation:
PASS / FAIL

Architecture:
PASS / FAIL

Repository:
PASS / FAIL

Cubit:
PASS / FAIL

State:
PASS / FAIL

View:
PASS / FAIL

GetIt:
PASS / FAIL

Routing:
PASS / FAIL / NOT REQUIRED

Error Handling:
PASS / FAIL

flutter analyze:
PASS / FAIL / NOT RUN
```

Then briefly explain the implementation.

---

# DO NOT

Do not:

* Rewrite the entire project.
* Change architecture.
* Add unnecessary packages.
* Add unnecessary classes.
* Refactor unrelated features.
* Generate huge datasets.
* Replace Firebase.
* Bypass repositories.
* Put API calls in Views.
* Put Firebase calls in Views.
* Put Dio calls in Cubits.
* Put Firestore calls in Cubits.

---

# GOLDEN WORKFLOW

```text
Inspect
 ↓
Understand
 ↓
Read Rules
 ↓
Find Existing Pattern
 ↓
Implement
 ↓
Integrate
 ↓
Analyze
 ↓
Test
 ↓
Review
 ↓
Report
```

The AI should work incrementally.

Do not dump an entire application implementation without understanding the existing project.
