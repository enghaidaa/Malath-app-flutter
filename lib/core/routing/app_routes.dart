import 'package:flutter/material.dart';

import 'routes_name.dart';

class AppRoutes {
  static const String initialRoute = RoutesName.home;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
      case RoutesName.signup:
      case RoutesName.home:
      case RoutesName.quran:
      case RoutesName.surahDetails:
      case RoutesName.azkar:
      case RoutesName.prayers:
      case RoutesName.myAzkar:
      case RoutesName.prayerTracker:
      case RoutesName.settings:
        return MaterialPageRoute(
          builder: (_) => _PlaceholderView(routeName: settings.name!),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const _PlaceholderView(routeName: RoutesName.home),
          settings: settings,
        );
    }
  }
}

class _PlaceholderView extends StatelessWidget {
  final String routeName;

  const _PlaceholderView({required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ملاذ'),
      ),
      body: Center(
        child: Text('Route: $routeName\n(Feature coming soon)'),
      ),
    );
  }
}
