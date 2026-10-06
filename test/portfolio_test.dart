import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webportfolio/app.dart';
import 'package:webportfolio/moveup_project_page.dart';

void main() {
  test('WhatsApp contact URL includes the message and correct number', () {
    const text = 'Nome: João\nE-mail: joao@example.com\n\nOlá!';
    final uri = Uri.parse(buildWhatsAppUrl(text));

    expect(uri.scheme, 'https');
    expect(uri.host, 'wa.me');
    expect(uri.path, '/5516981261172');
    expect(uri.queryParameters['text'], text);
  });

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
        find.text('Send via WhatsApp'),
        700,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Send via WhatsApp'));
      await tester.pump();
      expect(find.text('Please complete this field.'), findsNWidgets(2));
      expect(find.text('Enter a valid email address.'), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }

  for (final width in [360.0, 1440.0]) {
    testWidgets('MoveUp opens the complete project context at $width', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const PortfolioApp());
      await tester.pump(const Duration(milliseconds: 100));

      final scroll = find.byType(Scrollable).first;
      await tester.scrollUntilVisible(
        find.text('MoveUp'),
        700,
        scrollable: scroll,
      );
      final cards = find.byType(HoverCard);
      expect(cards, findsOneWidget);
      expect(find.text('ExpenseTracker'), findsNothing);
      expect(find.text('CloudTask API'), findsNothing);
      expect(find.text('AI Document API'), findsNothing);
      final explore = find.byKey(const ValueKey('explore-project-0'));
      await tester.ensureVisible(explore);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.tap(explore);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(MoveUpProjectPage), findsOneWidget);
      expect(
        find.text('Organize sua rotina. Treine no seu ritmo.'),
        findsOneWidget,
      );
      expect(find.text('Do planejamento à evolução.'), findsOneWidget);
      expect(
        find.text('Camadas independentes, produto flexível.'),
        findsOneWidget,
      );
      expect(find.text('Integridade pensada desde a base.'), findsOneWidget);
      expect(find.byTooltip('Voltar'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
    });
  }
}
