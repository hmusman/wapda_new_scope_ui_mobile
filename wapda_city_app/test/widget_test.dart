import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wapda_city_app/main.dart';

void main() {
  testWidgets('App launches and shows splash/onboarding', (WidgetTester tester) async {
    await tester.pumpWidget(const WapdaCityApp());
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
