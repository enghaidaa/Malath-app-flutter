import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/quran/presentation/manager/quran_cubit.dart';
import '../../features/quran/presentation/views/quran_view.dart';
import '../../features/quran/presentation/views/surah_details_view.dart';
import '../../features/auth/presentation/manager/login_cubit.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/manager/signup_cubit.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/settings/presentation/manager/settings_cubit.dart';
import '../../features/settings/presentation/views/settings_view.dart';
import '../../core/di/service_locator.dart';
import 'routes_name.dart';

import '../../features/azkar/presentation/manager/azkar_cubit.dart';
import '../../features/azkar/presentation/views/azkar_view.dart';

class AppRoutes {
  static const String initialRoute = RoutesName.login;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<LoginCubit>(),
            child: const LoginView(),
          ),
          settings: settings,
        );

      case RoutesName.signup:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<SignupCubit>(),
            child: const SignupView(),
          ),
          settings: settings,
        );
      case RoutesName.quran:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<QuranCubit>(),
            child: const QuranView(),
          ),
          settings: settings,
        );

      case RoutesName.surahDetails:
        final surahId = settings.arguments as int;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<QuranCubit>(),
            child: SurahDetailsView(
              surahId: surahId,
            ),
          ),
          settings: settings,
        );
      case RoutesName.azkar:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AzkarCubit>(),
            child: const AzkarView(),
          ),
          settings: settings,
        );

      case RoutesName.prayers:
      case RoutesName.myAzkar:
      case RoutesName.prayerTracker:
        return MaterialPageRoute(
          builder: (_) => _PlaceholderView(
            routeName: settings.name!,
          ),
          settings: settings,
        );

      case RoutesName.home:
        return MaterialPageRoute(
          builder: (_) => const TemporaryHomeSettingsTestView(),
          settings: settings,
        );

      case RoutesName.settings:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<SettingsCubit>(),
            child: const SettingsView(),
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const _PlaceholderView(
            routeName: RoutesName.home,
          ),
          settings: settings,
        );
    }
  }
}

class TemporaryHomeSettingsTestView extends StatelessWidget {
  const TemporaryHomeSettingsTestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ملاذ — Feature Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RoutesName.quran,
                  );
                },
                child: const Text('Open Quran'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RoutesName.azkar,
                  );
                },
                child: const Text('Open Azkar'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RoutesName.settings,
                  );
                },
                child: const Text('Open Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderView extends StatelessWidget {
  final String routeName;

  const _PlaceholderView({
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ملاذ'),
      ),
      body: Center(
        child: Text(
          'Route: $routeName\n(Feature coming soon)',
        ),
      ),
    );
  }
}
