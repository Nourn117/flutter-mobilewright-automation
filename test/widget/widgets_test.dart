import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:mobilewright_demo_app/app/app.dart';
import 'package:mobilewright_demo_app/core/di/injection.dart';
import 'package:mobilewright_demo_app/domain/entities/products/product.dart';
import 'package:mobilewright_demo_app/presentation/common/widgets/quantity_stepper.dart';
import 'package:mobilewright_demo_app/presentation/products/widgets/product_card.dart';

/// Widget tests: render real widgets in a test environment and interact with them.
void main() {
  testWidgets('WIDGET-01 · Login shows validation errors when submitted empty', (tester) async {
    await GetIt.instance.reset();
    configureDependencies();

    await tester.pumpWidget(const App());
    await tester.tap(find.text('Log in'));
    await tester.pump();

    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
  });

  testWidgets('WIDGET-02 · ProductCard shows the product data and reacts to taps', (tester) async {
    const product = Product(
      id: 'p2',
      name: 'Smart Watch',
      description: '',
      category: 'Wearables',
      price: 5999,
    );
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 200,
              height: 236,
              child: ProductCard(product: product, onTap: () => tapped = true),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Smart Watch'), findsOneWidget);
    expect(find.text('Wearables'), findsOneWidget);
    expect(find.text('EGP 5,999'), findsOneWidget);

    await tester.tap(find.byType(ProductCard));
    expect(tapped, isTrue);
  });

  testWidgets('WIDGET-03 · QuantityStepper disables minus at 1 and increases on plus', (tester) async {
    int? newValue;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: QuantityStepper(
              value: 1,
              onChanged: (v) => newValue = v,
              minusId: 'minus',
              valueId: 'value',
              plusId: 'plus',
            ),
          ),
        ),
      ),
    );

    final minus = tester.widget<IconButton>(
      find.widgetWithIcon(IconButton, Icons.remove_rounded),
    );
    expect(minus.onPressed, isNull);
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.widgetWithIcon(IconButton, Icons.add_rounded));
    expect(newValue, 2);
  });
}
