import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webportfolio/app.dart';

void main() {
  testWidgets(
    'Explicit play restores motion when the platform requests reduced motion',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(
        tester.platformDispatcher.clearAccessibilityFeaturesTestValue,
      );
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          FakeAccessibilityFeatures(disableAnimations: true);
      await tester.pumpWidget(const PortfolioApp());
      await tester.pump();
      Matrix4 matrix() => tester
          .widget<Transform>(find.byKey(const ValueKey('technology-motion')))
          .transform
          .clone();
      final stopped = matrix();
      await tester.pump(const Duration(seconds: 4));
      expect(matrix(), stopped);
      await tester.tap(find.byKey(const ValueKey('enable-motion')));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(matrix(), isNot(stopped));
      expect(find.byKey(const ValueKey('enable-motion')), findsNothing);
      await tester.pump(const Duration(seconds: 3));
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('Software Engineering'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.byKey(const ValueKey('toggle-motion')),
        700,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.byKey(const ValueKey('toggle-motion')));
      await tester.pump();
      final paused = matrix();
      await tester.pump(const Duration(seconds: 4));
      expect(matrix(), paused);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets('Mobile animations advance and respect reduced motion', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();
    Matrix4 matrix(String key) =>
        tester.widget<Transform>(find.byKey(ValueKey(key))).transform.clone();
    final orbit = matrix('portrait-orbit');
    final carousel = matrix('technology-motion');
    await tester.pump(const Duration(seconds: 1));
    expect(matrix('portrait-orbit'), isNot(orbit));
    expect(matrix('technology-motion'), isNot(carousel));
    await tester.pump(const Duration(milliseconds: 3500));
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text('Backend Developer'), findsOneWidget);
    expect(find.text('Software Developer'), findsNothing);
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        FakeAccessibilityFeatures(disableAnimations: true);
    await tester.pump();
    final stopped = matrix('technology-motion');
    await tester.pump(const Duration(seconds: 2));
    expect(matrix('technology-motion'), stopped);
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        FakeAccessibilityFeatures(disableAnimations: false);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(matrix('technology-motion'), isNot(stopped));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('Card responds to touch, release and cancellation', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: HoverCard(
              child: SizedBox(
                width: 250,
                height: 200,
                child: Center(child: Text('Project')),
              ),
            ),
          ),
        ),
      ),
    );
    double lift() => tester
        .widget<AnimatedContainer>(find.byType(AnimatedContainer))
        .transform!
        .storage[13];
    final first = await tester.startGesture(
      tester.getCenter(find.text('Project')),
      kind: PointerDeviceKind.touch,
    );
    await tester.pump();
    expect(lift(), -5);
    await first.up();
    await tester.pump();
    expect(lift(), 0);
    final second = await tester.startGesture(
      tester.getCenter(find.text('Project')),
      kind: PointerDeviceKind.touch,
    );
    await tester.pump();
    expect(lift(), -5);
    await second.cancel();
    await tester.pump();
    expect(lift(), 0);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
