import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobilewright_demo_app/core/testing/test_ids.dart';
import 'package:mobilewright_demo_app/core/utils/format.dart';
import 'package:mobilewright_demo_app/core/widgets/test_id.dart';
import 'package:mobilewright_demo_app/domain/entities/products/product.dart';
import 'package:mobilewright_demo_app/domain/usecases/cart/update_quantity_usecase.dart';
import 'package:mobilewright_demo_app/presentation/cart/cubit/cart_cubit.dart';
import 'package:mobilewright_demo_app/presentation/common/widgets/product_visual.dart';
import 'package:mobilewright_demo_app/presentation/common/widgets/quantity_stepper.dart';
import 'package:mobilewright_demo_app/presentation/home/cubit/home_tab_cubit.dart';
import 'package:mobilewright_demo_app/presentation/product_details/widgets/added_to_cart_sheet.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _qty = 1;

  Future<void> _addToCart() async {
    final product = widget.product;
    final quantity = _qty;
    context.read<CartCubit>().add(product, quantity);

    final action = await AddedToCartSheet.show(
      context,
      product: product,
      quantity: quantity,
    );
    if (!mounted) return;

    switch (action) {
      case AddedToCartAction.goToCart:
        context.read<HomeTabCubit>().select(HomeTab.cart);
        Navigator.of(context).popUntil((route) => route.isFirst);
      case AddedToCartAction.continueShopping:
        Navigator.of(context).pop();
      case null:
        setState(() => _qty = 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final visual = ProductVisual.of(p);

    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Container(
            height: 230,
            decoration: BoxDecoration(
              color: visual.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Icon(visual.icon, size: 110, color: visual.color),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: visual.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(p.category,
                  style: text.labelLarge?.copyWith(color: visual.color)),
            ),
          ),
          const SizedBox(height: 12),
          TestId(
            TestIds.detailsName,
            child: Text(p.name,
                style:
                    text.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
          ),
          const SizedBox(height: 6),
          TestId(
            TestIds.detailsPrice,
            child: Text(formatPrice(p.price),
                style: text.headlineSmall?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w800,
                )),
          ),
          const SizedBox(height: 20),
          Text('About this product',
              style: text.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(p.description,
              style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant)),
          const SizedBox(height: 24),
          Row(
            children: [
              Text('Quantity',
                  style:
                      text.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const Spacer(),
              QuantityStepper(
                value: _qty,
                max: UpdateQuantityUseCase.maxQuantity,
                onChanged: (v) => setState(() => _qty = v),
                minusId: TestIds.detailsQtyMinus,
                valueId: TestIds.detailsQuantity,
                plusId: TestIds.detailsQtyPlus,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: TestId(
            TestIds.detailsAddToCart,
            child: FilledButton.icon(
              onPressed: _addToCart,
              icon: const Icon(Icons.add_shopping_cart_rounded),
              label: Text('Add to cart · ${formatPrice(p.price * _qty)}'),
            ),
          ),
        ),
      ),
    );
  }
}
