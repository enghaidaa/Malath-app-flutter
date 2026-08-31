import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_poject_final/main.dart';

void main() {
  testWidgets('App loads with placeholder home route', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('ملاذ'), findsOneWidget);
    expect(find.textContaining('Route: /home'), findsOneWidget);
  });
}
