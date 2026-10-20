import 'package:flutter/material.dart';

import 'package:mobilewright_demo_app/core/testing/test_ids.dart';
import 'package:mobilewright_demo_app/core/widgets/test_id.dart';
import 'package:mobilewright_demo_app/domain/entities/products/product.dart';
import 'package:mobilewright_demo_app/presentation/common/widgets/product_visual.dart';

enum AddedToCartAction { continueShopping, goToCart }

class AddedToCartSheet extends StatelessWidget {
  const AddedToCartSheet({
    super.key,
    required this.product,
    required this.quantity,
  });

  final Product product;
  final int quantity;

  static Future<AddedToCartAction?> show(
    BuildContext context, {
    required Product product,
    required int quantity,
  }) {
    return showModalBottomSheet<AddedToCartAction>(
      context: context,
      showDragHandle: true,
      builder: (_) => AddedToCartSheet(product: product, quantity: quantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return TestId(
      TestIds.addedSheet,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ProductImage(product: product, size: 56, iconSize: 28),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.check_circle_rounded,
                                size: 20, color: Color(0xFF10B981)),
                            const SizedBox(width: 6),
                            Text('Added to cart',
                                style: text.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('$quantity × ${product.name}',
                            style: text.bodyMedium
                                ?.copyWith(color: scheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TestId(
                      TestIds.addedSheetContinue,
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context)
                            .pop(AddedToCartAction.continueShopping),
                        child: const Text('Keep shopping'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TestId(
                      TestIds.addedSheetGoToCart,
                      child: FilledButton(
                        onPressed: () => Navigator.of(context)
                            .pop(AddedToCartAction.goToCart),
                        child: const Text('Go to cart'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
