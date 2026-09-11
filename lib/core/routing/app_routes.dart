import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poject_final/features/home/presentation/views/home_view.dart';
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
import '../../features/my_azkar/presentation/manager/my_azkar_cubit.dart';
import '../../features/my_azkar/presentation/views/my_azkar_view.dart';
import '../../features/prayers/presentation/manager/prayers_cubit.dart';
import '../../features/prayers/presentation/views/prayers_view.dart';
import '../../features/azkar/presentation/manager/azkar_cubit.dart';
import '../../features/azkar/presentation/views/azkar_view.dart';
import '../../features/prayer_tracker/presentation/manager/prayer_tracker_cubit.dart';
import '../../features/prayer_tracker/presentation/views/prayer_tracker_view.dart';

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
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => sl<AzkarCubit>(),
              ),
              BlocProvider(
                create: (_) => sl<MyAzkarCubit>()..getMyAzkar(),
              ),
            ],
            child: const AzkarView(),
          ),
          settings: settings,
        );

      case RoutesName.prayers:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<PrayerCubit>(),
            child: const PrayersView(),
          ),
          settings: settings,
        );

      case RoutesName.myAzkar:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<MyAzkarCubit>(),
            child: const MyAzkarView(),
          ),
          settings: settings,
        );

      case RoutesName.prayerTracker:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<PrayerTrackerCubit>(),
            child: const PrayerTrackerView(),
          ),
          settings: settings,
        );

      case RoutesName.home:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
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
