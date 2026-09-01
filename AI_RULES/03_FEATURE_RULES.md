# FEATURE RULES

## Islamic App — ملاذ

This file defines the responsibilities and data sources of each feature.

---

# 1. AUTH

Source:

```text
Firebase Authentication
```

Responsibilities:

* Register
* Login
* Logout
* Authentication
* User profile/account information

Architecture:

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

# 2. QURAN

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

Data:

Surah:

* number
* name
* englishName
* englishNameTranslation
* numberOfAyahs
* revelationType

Ayah:

* numberInSurah
* text
* juz
* page
* hizbQuarter

---

# 3. AZKAR

Source:

```text
Custom Backend
```

Endpoints:

```text
GET /api/v1/azkar
GET /api/v1/azkar/category/:category
```

Categories can include:

```text
morning
evening
after-prayer
```

General Azkar are public/general application data.

---

# 4. PRAYERS

Source:

```text
Custom Backend
```

Endpoint:

```text
GET /api/v1/prayers/timings
```

Data:

```text
Fajr
Sunrise
Dhuhr
Asr
Maghrib
Isha
Hijri Date
```

Backend uses Adhan for calculations.

---

# 5. HOME

Home is a dashboard/aggregation feature.

It may display:

```text
Hijri Date
Today's information
Next Prayer
Prayer Times
Quran shortcut
Azkar shortcut
User information
```

Home must not directly access Dio or Firebase.

---

# 6. MY AZKAR

Source:

```text
Firebase Firestore
```

This is different from general Azkar.

Responsibilities:

```text
Add
Edit
Delete
Count
Complete
```

Example:

```text
Subhan Allah
Target: 100
Counter: 100
```

Counter decreases until:

```text
0
```

At zero, the Zikr is considered completed according to application logic.

---

# 7. PRAYER TRACKER

Source:

```text
Firebase Firestore
```

Purpose:

Track whether the user performed prayers.

Do NOT confuse with Prayer Times.

```text
Prayer Times
=
General schedule
```

```text
Prayer Tracker
=
User's personal completion tracking
```

---

# 8. SETTINGS

Source:

```text
SharedPreferences
```

Responsibilities:

```text
Theme
Language
Font Size
```

Example keys:

```text
is_dark_mode
language_code
font_size
```

No backend is required.

---

# 9. FAVORITES

Source:

```text
Firebase Firestore
```

Favorites are user-specific.

Do not create a separate artificial feature merely for Favorites.

---

# 10. DATA SOURCE TABLE

```text
Auth             → Firebase Authentication

Quran            → Custom Backend → Dio

Azkar            → Custom Backend → Dio

Prayers          → Custom Backend → Dio

Home             → Aggregates required data

My Azkar         → Firebase Firestore

Prayer Tracker   → Firebase Firestore

Settings         → SharedPreferences

Favorites        → Firebase Firestore

Hijri Date       → Custom Backend / Prayer response
```

---

# 11. IMPORTANT DISTINCTIONS

Never mix:

```text
Azkar
```

with:

```text
My Azkar
```

Never mix:

```text
Prayers
```

with:

```text
Prayer Tracker
```

Never replace:

```text
Firebase
```

with:

```text
Custom Backend
```

Never move:

```text
Theme / Language / Font Size
```

to the backend.

---

# 12. FEATURE IMPLEMENTATION ORDER

Preferred order:

```text
Quran
Prayers
Azkar
Auth
My Azkar
Prayer Tracker
Settings
Home integration
```

The order can change if there is a practical reason.

The architecture cannot change without approval.
