import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';

import 'package:mobilewright_demo_app/app/app.dart';
import 'package:mobilewright_demo_app/core/di/injection.dart';

/// Performance tests: run on a real device/emulator in profile mode.
///
///   flutter drive --profile -d emulator-5554 \
///     --driver=test_driver/perf_driver.dart \
///     --target=integration_test/performance_test.dart
///
/// Results are saved to build/integration_response_data.json.

/// One frame at 60 fps.
const double frameBudgetMs = 16;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> startApp(WidgetTester tester) async {
    await GetIt.instance.reset();
    configureDependencies();
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();
  }

  /// Pumps frames until [finder] matches (the app uses real delays for mock data).
  Future<void> pumpUntilFound(
    WidgetTester tester,
    Finder finder, {
    Duration timeout = const Duration(seconds: 10),
  }) async {
    final end = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(end)) {
      await tester.pump(const Duration(milliseconds: 50));
      if (finder.evaluate().isNotEmpty) return;
    }
    throw TestFailure('Not found within $timeout: $finder');
  }

  /// Sets a field's text through its controller. On a real device the test
  /// keyboard is not used, so `enterText` would not reach the field.
  void setFieldText(WidgetTester tester, String label, String text) {
    final field = find.widgetWithText(TextFormField, label);
    final editable = tester.widget<EditableText>(
      find.descendant(of: field, matching: find.byType(EditableText)),
    );
    editable.controller.text = text;
  }

  Future<void> login(WidgetTester tester) async {
    setFieldText(tester, 'Email', 'test@demo.com');
    setFieldText(tester, 'Password', 'Test@1234');
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Log in'));
    await tester.tap(find.text('Log in'));
  }

  Finder navTab(String label) =>
      find.descendant(of: find.byType(NavigationBar), matching: find.text(label));

  /// Fails if the average build or raster time of a recorded interaction is over budget.
  void expectSmoothFrames(String reportKey) {
    final summary = binding.reportData![reportKey] as Map<String, dynamic>;
    final build = (summary['average_frame_build_time_millis'] as num).toDouble();
    final raster = (summary['average_frame_rasterizer_time_millis'] as num).toDouble();
    expect(build, lessThan(frameBudgetMs), reason: 'average frame build time (ms)');
    expect(raster, lessThan(frameBudgetMs), reason: 'average frame raster time (ms)');
  }

  testWidgets('PERF-01 · login to product list in under 3 seconds', (tester) async {
    await startApp(tester);

    final stopwatch = Stopwatch()..start();
    await login(tester);
    await pumpUntilFound(tester, find.byKey(const ValueKey('p1')));
    stopwatch.stop();

    binding.reportData = {
      ...?binding.reportData,
      'login_to_products_ms': stopwatch.elapsedMilliseconds,
    };
    expect(stopwatch.elapsedMilliseconds, lessThan(3000));
  });

  testWidgets('PERF-02 · product grid scrolls within the frame budget', (tester) async {
    await startApp(tester);
    await login(tester);
    await pumpUntilFound(tester, find.byKey(const ValueKey('p1')));

    final grid = find.byType(GridView);
    await binding.watchPerformance(() async {
      for (var i = 0; i < 3; i++) {
        await tester.fling(grid, const Offset(0, -400), 1500);
        await tester.pumpAndSettle();
        await tester.fling(grid, const Offset(0, 400), 1500);
        await tester.pumpAndSettle();
      }
    }, reportKey: 'products_scroll');

    expectSmoothFrames('products_scroll');
  });

  testWidgets('PERF-03 · switching tabs stays within the frame budget', (tester) async {
    await startApp(tester);
    await login(tester);
    await pumpUntilFound(tester, find.byKey(const ValueKey('p1')));

    await binding.watchPerformance(() async {
      for (var i = 0; i < 3; i++) {
        await tester.tap(navTab('Cart'));
        await tester.pumpAndSettle();
        await tester.tap(navTab('Profile'));
        await tester.pumpAndSettle();
        await tester.tap(navTab('Shop'));
        await tester.pumpAndSettle();
      }
    }, reportKey: 'tab_switching');

    expectSmoothFrames('tab_switching');
  });
}
