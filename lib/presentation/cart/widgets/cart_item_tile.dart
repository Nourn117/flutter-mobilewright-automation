import 'package:flutter/material.dart';

import 'package:mobilewright_demo_app/core/testing/test_ids.dart';
import 'package:mobilewright_demo_app/core/utils/format.dart';
import 'package:mobilewright_demo_app/core/widgets/test_id.dart';
import 'package:mobilewright_demo_app/domain/entities/cart/cart_item.dart';
import 'package:mobilewright_demo_app/domain/usecases/cart/update_quantity_usecase.dart';
import 'package:mobilewright_demo_app/presentation/common/widgets/product_visual.dart';
import 'package:mobilewright_demo_app/presentation/common/widgets/quantity_stepper.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  final CartItem item;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final id = item.product.id;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return TestId(
      TestIds.cartItem(id),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImage(product: item.product, size: 72, iconSize: 36),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(item.product.name,
                              style: text.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w700)),
                        ),
                        TestId(
                          TestIds.cartRemove(id),
                          child: IconButton(
                            tooltip: 'Remove ${item.product.name}',
                            visualDensity: VisualDensity.compact,
                            icon: Icon(Icons.delete_outline_rounded,
                                color: scheme.error),
                            onPressed: onRemove,
                          ),
                        ),
                      ],
                    ),
                    Text(formatPrice(item.product.price),
                        style: text.bodyMedium
                            ?.copyWith(color: scheme.onSurfaceVariant)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        QuantityStepper(
                          value: item.quantity,
                          max: UpdateQuantityUseCase.maxQuantity,
                          onChanged: onQuantityChanged,
                          minusId: TestIds.cartItemMinus(id),
                          valueId: TestIds.cartItemQuantity(id),
                          plusId: TestIds.cartItemPlus(id),
                        ),
                        const Spacer(),
                        TestId(
                          TestIds.cartItemTotal(id),
                          child: Text(formatPrice(item.total),
                              style: text.titleSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: scheme.primary,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
