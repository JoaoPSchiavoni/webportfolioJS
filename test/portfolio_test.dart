import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webportfolio/app.dart';

void main() {
  for (final width in [360.0, 768.0, 1440.0]) {
    testWidgets('Responsive layout and language switching at $width', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const PortfolioApp());
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
      expect(find.text('Olá, eu sou'), findsOneWidget);
      await tester.tap(find.text('EN'));
      await tester.pump();
      expect(find.text("Hello, I'm"), findsOneWidget);
      expect(find.text('Olá, eu sou'), findsNothing);
      final scroll = find.byType(SingleChildScrollView).first;
      await tester.drag(scroll, const Offset(0, -2300));
      await tester.pump(const Duration(seconds: 1));
      expect(tester.takeException(), isNull);
      await tester.scrollUntilVisible(
        find.text('Prepare email'),
        700,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Prepare email'));
      await tester.pump();
      expect(find.text('Please complete this field.'), findsNWidgets(2));
      expect(find.text('Enter a valid email address.'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }
}
