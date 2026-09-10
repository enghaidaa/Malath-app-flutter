import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/service_locator.dart';
import 'core/routing/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/presentation/manager/settings_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة مكتبة الترجمة
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupServiceLocator();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),
      child: BlocProvider(
        create: (_) => sl<SettingsCubit>()..loadSettings(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final bool isDarkMode =
            state is SettingsLoaded ? state.settings.isDarkMode : false;

        final double fontSize =
            state is SettingsLoaded ? state.settings.fontSize : 18.0;

        return MaterialApp(
          title: 'app.title'.tr(),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.buildTheme(
            isDark: false,
            fontSize: fontSize,
          ),
          darkTheme: AppTheme.buildTheme(
            isDark: true,
            fontSize: fontSize,
          ),
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

          // إعدادات الـ EasyLocalization للغة
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,

          initialRoute: AppRoutes.initialRoute,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        );
      },
    );
  }
}
