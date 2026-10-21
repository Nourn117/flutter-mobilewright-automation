import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobilewright_demo_app/core/di/injection.dart';
import 'package:mobilewright_demo_app/core/testing/test_ids.dart';
import 'package:mobilewright_demo_app/core/widgets/empty_state.dart';
import 'package:mobilewright_demo_app/core/widgets/test_id.dart';
import 'package:mobilewright_demo_app/domain/entities/products/product.dart';
import 'package:mobilewright_demo_app/presentation/common/cubit/session_cubit.dart';
import 'package:mobilewright_demo_app/presentation/product_details/page/product_details_page.dart';
import 'package:mobilewright_demo_app/presentation/products/cubit/products_cubit.dart';
import 'package:mobilewright_demo_app/presentation/products/cubit/products_state.dart';
import 'package:mobilewright_demo_app/presentation/products/widgets/product_card.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductsCubit>()..load(),
      child: const _ProductsView(),
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final name = context.select((SessionCubit s) => s.state?.name ?? '');
    final firstName = name.split(' ').first;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Text(
                firstName.isEmpty ? 'Hello 👋' : 'Hello, $firstName 👋',
                style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Find your next gadget',
                  style: text.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w800)),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TestId(
                TestIds.productsSearch,
                child: TextField(
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                    hintText: 'Search products',
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                  onChanged: context.read<ProductsCubit>().search,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) => switch (state) {
                  ProductsLoading() => const Center(
                      child: TestId(
                        TestIds.productsLoading,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ProductsFailure(:final message) => EmptyState(
                      id: TestIds.productsError,
                      icon: Icons.cloud_off_rounded,
                      title: 'Something went wrong',
                      message: message,
                      action: TestId(
                        TestIds.productsRetry,
                        child: FilledButton(
                          onPressed: context.read<ProductsCubit>().load,
                          child: const Text('Try again'),
                        ),
                      ),
                    ),
                  ProductsLoaded loaded =>
                    _ProductGrid(products: loaded.filtered),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  const _ProductGrid({required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const EmptyState(
        id: TestIds.productsEmpty,
        icon: Icons.search_off_rounded,
        title: 'No products found',
        message: 'Try a different search term.',
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        mainAxisExtent: 236,
      ),
      itemCount: products.length,
      itemBuilder: (context, i) {
        final product = products[i];
        return ProductCard(
          key: ValueKey(product.id),
          product: product,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => ProductDetailsPage(product: product),
            ),
          ),
        );
      },
    );
  }
}
