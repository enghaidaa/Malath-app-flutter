import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/azkar/data/repos/azkar_repo.dart';
import '../../features/azkar/data/repos/azkar_repo_impl.dart';
import '../../features/azkar/presentation/manager/azkar_cubit.dart';
import '../../features/quran/data/repos/quran_repo.dart';
import '../../features/quran/data/repos/quran_repo_impl.dart';
import '../../features/quran/presentation/manager/quran_cubit.dart';
import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/auth/presentation/manager/login_cubit.dart';
import '../../features/auth/presentation/manager/signup_cubit.dart';
import '../../features/settings/data/repos/settings_repo.dart';
import '../../features/settings/data/repos/settings_repo_impl.dart';
import '../../features/settings/presentation/manager/settings_cubit.dart';
import '../api/api_consumer.dart';
import '../api/dio_consumer.dart';
import '../api/end_points.dart';
import '../services/api_service.dart';
import '../services/firebase_auth_service.dart';
import '../services/firebase_firestore_service.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Local Storage
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );

  // Dio
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: const {
          'Content-Type': 'application/json',
        },
      ),
    ),
  );

  // API
  sl.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(
      dio: sl<Dio>(),
    ),
  );

  sl.registerLazySingleton<ApiService>(
    () => ApiService(
      apiConsumer: sl<ApiConsumer>(),
    ),
  );

  // Firebase Services
  sl.registerLazySingleton<FirebaseAuthService>(
    () => FirebaseAuthService(),
  );

  sl.registerLazySingleton<FirebaseFirestoreService>(
    () => FirebaseFirestoreService(),
  );
  // Quran Repository
  sl.registerLazySingleton<QuranRepo>(
    () => QuranRepoImpl(
      apiService: sl<ApiService>(),
    ),
  );

// Quran Cubit
  sl.registerFactory<QuranCubit>(
    () => QuranCubit(
      sl<QuranRepo>(),
    ),
  );

  // Azkar Repository

  sl.registerLazySingleton<AzkarRepo>(
    () => AzkarRepoImpl(
      apiService: sl<ApiService>(),
    ),
  );

  // Azkar Cubit

  sl.registerFactory<AzkarCubit>(
    () => AzkarCubit(
      sl<AzkarRepo>(),
    ),
  );

  // Auth Repository
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      firebaseAuthService: sl<FirebaseAuthService>(),
    ),
  );

  // Auth Cubits
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(
      sl<AuthRepo>(),
    ),
  );

  sl.registerFactory<SignupCubit>(
    () => SignupCubit(
      sl<AuthRepo>(),
    ),
  );

  // Settings Repository
  sl.registerLazySingleton<SettingsRepo>(
    () => SettingsRepoImpl(
      sharedPreferences: sl<SharedPreferences>(),
    ),
  );

  // Settings Cubit
  sl.registerLazySingleton<SettingsCubit>(
    () => SettingsCubit(
      sl<SettingsRepo>(),
    ),
  );
}
