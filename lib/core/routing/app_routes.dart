import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/manager/login_cubit.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/manager/signup_cubit.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/settings/presentation/manager/settings_cubit.dart';
import '../../features/settings/presentation/views/settings_view.dart';
import '../../core/di/service_locator.dart';
import 'routes_name.dart';

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
      case RoutesName.surahDetails:
      case RoutesName.azkar:
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
        title: const Text('ملاذ — Settings Test'),
      ),
      body: Center(
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
