import 'package:flutter/material.dart';

import 'package:mobilewright_demo_app/core/testing/test_ids.dart';
import 'package:mobilewright_demo_app/core/utils/format.dart';
import 'package:mobilewright_demo_app/core/widgets/test_id.dart';
import 'package:mobilewright_demo_app/domain/entities/products/product.dart';
import 'package:mobilewright_demo_app/presentation/common/widgets/product_visual.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final visual = ProductVisual.of(product);

    return TestId(
      TestIds.productItem(product.id),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 116,
                color: visual.color.withValues(alpha: 0.12),
                child: Icon(visual.icon, size: 56, color: visual.color),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: text.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        product.category,
                        style: text.bodySmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                      const Spacer(),
                      Text(
                        formatPrice(product.price),
                        style: text.titleMedium?.copyWith(
                          color: scheme.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
