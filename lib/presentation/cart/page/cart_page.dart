import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobilewright_demo_app/core/testing/test_ids.dart';
import 'package:mobilewright_demo_app/core/widgets/empty_state.dart';
import 'package:mobilewright_demo_app/core/widgets/test_id.dart';
import 'package:mobilewright_demo_app/presentation/cart/cubit/cart_cubit.dart';
import 'package:mobilewright_demo_app/presentation/cart/cubit/cart_state.dart';
import 'package:mobilewright_demo_app/presentation/cart/widgets/cart_item_tile.dart';
import 'package:mobilewright_demo_app/presentation/cart/widgets/cart_summary.dart';
import 'package:mobilewright_demo_app/presentation/checkout/page/checkout_page.dart';
import 'package:mobilewright_demo_app/presentation/home/cubit/home_tab_cubit.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.isEmpty) {
            return EmptyState(
              id: TestIds.cartEmpty,
              icon: Icons.shopping_cart_outlined,
              title: 'Your cart is empty',
              message: 'Browse our products and add something you like.',
              action: TestId(
                TestIds.cartStartShopping,
                child: FilledButton(
                  onPressed: () =>
                      context.read<HomeTabCubit>().select(HomeTab.products),
                  child: const Text('Start shopping'),
                ),
              ),
            );
          }

          final cart = context.read<CartCubit>();
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.items.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final item = state.items[i];
                    return CartItemTile(
                      key: ValueKey(item.product.id),
                      item: item,
                      onQuantityChanged: (q) =>
                          cart.setQuantity(item.product.id, q),
                      onRemove: () => cart.remove(item.product.id),
                    );
                  },
                ),
              ),
              CartSummary(
                state: state,
                onCheckout: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => const CheckoutPage()),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
