import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobilewright_demo_app/core/testing/test_ids.dart';
import 'package:mobilewright_demo_app/core/utils/format.dart';
import 'package:mobilewright_demo_app/core/widgets/test_id.dart';
import 'package:mobilewright_demo_app/domain/entities/checkout/checkout_details.dart';
import 'package:mobilewright_demo_app/domain/entities/checkout/order.dart';
import 'package:mobilewright_demo_app/presentation/common/widgets/summary_row.dart';
import 'package:mobilewright_demo_app/presentation/home/cubit/home_tab_cubit.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key, required this.order});

  final Order order;

  void _backHome(BuildContext context) {
    context.read<HomeTabCubit>().select(HomeTab.products);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final details = order.details;
    final slot = switch (details.slot) {
      DeliverySlot.morning => '9 AM - 1 PM',
      DeliverySlot.evening => '5 PM - 9 PM',
    };
    final payment = switch (details.paymentMethod) {
      PaymentMethod.cashOnDelivery => 'Cash on delivery',
      PaymentMethod.card => 'Card on delivery',
    };

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _backHome(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const SizedBox(height: 24),
              const Center(
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Color(0x2210B981),
                  child: Icon(Icons.check_rounded,
                      size: 56, color: Color(0xFF10B981)),
                ),
              ),
              const SizedBox(height: 20),
              TestId(
                TestIds.orderSuccessTitle,
                child: Text('Order placed!',
                    textAlign: TextAlign.center,
                    style: text.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w800)),
              ),
              const SizedBox(height: 8),
              Text(
                'Thanks ${details.fullName.split(' ').first}, we will deliver to '
                '${details.city} on ${formatDate(details.deliveryDate)}.',
                textAlign: TextAlign.center,
                style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 28),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SummaryRow(
                        label: 'Order number',
                        value: order.id,
                        valueId: TestIds.orderNumber,
                        emphasized: true,
                      ),
                      const Divider(height: 20),
                      SummaryRow(label: 'Time slot', value: slot),
                      SummaryRow(label: 'Payment', value: payment),
                      SummaryRow(
                          label: 'Items', value: '${order.itemCount}'),
                      SummaryRow(
                        label: 'Delivery',
                        value: formatPrice(order.deliveryFee),
                      ),
                      const Divider(height: 20),
                      SummaryRow(
                        label: 'Total paid',
                        value: formatPrice(order.total),
                        valueId: TestIds.orderTotal,
                        emphasized: true,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Column(
                  children: [
                    for (final item in order.items)
                      ListTile(
                        title: Text(item.product.name),
                        subtitle: Text('Qty ${item.quantity}'),
                        trailing: Text(formatPrice(item.total)),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
            child: TestId(
              TestIds.orderBackHome,
              child: FilledButton(
                onPressed: () => _backHome(context),
                child: const Text('Back to shopping'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
