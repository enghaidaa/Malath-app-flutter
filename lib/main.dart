import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di/service_locator.dart';
import 'core/routing/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/presentation/manager/settings_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupServiceLocator();

  runApp(
    BlocProvider(
      create: (_) => sl<SettingsCubit>()..loadSettings(),
      child: const MyApp(),
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

        final String languageCode =
            state is SettingsLoaded ? state.settings.languageCode : 'en';

        final double fontSize =
            state is SettingsLoaded ? state.settings.fontSize : 18.0;

        final Locale locale = const ['en', 'ar'].contains(languageCode)
            ? Locale(languageCode)
            : const Locale('en');

        return MaterialApp(
          title: 'ملاذ',
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
          locale: locale,
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialRoute: AppRoutes.initialRoute,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        );
      },
    );
  }
}
