import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webportfolio/l10n/app_localizations.dart';
import 'package:webportfolio/moveup_project_page.dart';

void main() {
  for (final width in [360.0, 1440.0]) {
    testWidgets('MoveUp landing page is responsive at $width', (tester) async {
      tester.view.physicalSize = Size(width, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          locale: Locale('pt'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: MoveUpProjectPage(),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(
        find.text('Organize sua rotina. Treine no seu ritmo.'),
        findsOneWidget,
      );
      expect(find.text('Do planejamento à evolução.'), findsOneWidget);
    });
  }
}
