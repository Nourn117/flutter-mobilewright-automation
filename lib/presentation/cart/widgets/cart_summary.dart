import 'package:flutter/material.dart';

import 'package:mobilewright_demo_app/core/testing/test_ids.dart';
import 'package:mobilewright_demo_app/core/utils/format.dart';
import 'package:mobilewright_demo_app/core/widgets/test_id.dart';
import 'package:mobilewright_demo_app/presentation/cart/cubit/cart_state.dart';
import 'package:mobilewright_demo_app/presentation/common/widgets/summary_row.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key, required this.state, required this.onCheckout});

  final CartState state;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SummaryRow(
            label: 'Subtotal (${state.count} items)',
            value: formatPrice(state.subtotal),
            valueId: TestIds.cartSubtotal,
          ),
          SummaryRow(
            label: 'Delivery',
            value: formatPrice(state.deliveryFee),
            valueId: TestIds.cartDeliveryFee,
          ),
          const Divider(height: 20),
          SummaryRow(
            label: 'Total',
            value: formatPrice(state.total),
            valueId: TestIds.cartTotal,
            emphasized: true,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: TestId(
              TestIds.cartCheckout,
              child: FilledButton(
                onPressed: onCheckout,
                child: const Text('Proceed to checkout'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
