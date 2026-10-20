import 'package:flutter/material.dart';

import 'package:mobilewright_demo_app/domain/entities/products/product.dart';

/// Icon + colour used to draw a product (the mock catalogue has no images).
class ProductVisual {
  const ProductVisual(this.icon, this.color);

  final IconData icon;
  final Color color;

  static ProductVisual of(Product product) {
    final color = switch (product.category) {
      'Audio' => const Color(0xFF6366F1),
      'Wearables' => const Color(0xFF10B981),
      _ => const Color(0xFFF59E0B),
    };
    final icon = switch (product.id) {
      'p1' => Icons.headphones_rounded,
      'p2' => Icons.watch_rounded,
      'p3' => Icons.speaker_rounded,
      'p4' => Icons.laptop_rounded,
      'p5' => Icons.usb_rounded,
      'p6' => Icons.keyboard_rounded,
      'p7' => Icons.monitor_heart_rounded,
      'p8' => Icons.headset_rounded,
      _ => Icons.devices_other_rounded,
    };
    return ProductVisual(icon, color);
  }
}

/// Rounded tile showing the product icon on a tinted background.
class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.product,
    this.size = 64,
    this.iconSize = 32,
    this.radius = 16,
  });

  final Product product;
  final double size;
  final double iconSize;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final visual = ProductVisual.of(product);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: visual.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Icon(visual.icon, size: iconSize, color: visual.color),
    );
  }
}
