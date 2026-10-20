import 'package:flutter/material.dart';

import 'package:mobilewright_demo_app/core/widgets/test_id.dart';

/// "Label ........ Value" row used in cart, checkout and order summaries.
class SummaryRow extends StatelessWidget {
  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.valueId,
    this.emphasized = false,
  });

  final String label;
  final String value;
  final String? valueId;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final style = emphasized
        ? text.titleMedium?.copyWith(fontWeight: FontWeight.w700)
        : text.bodyLarge;
    final valueText = Text(value, style: style);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          if (valueId != null) TestId(valueId!, child: valueText) else valueText,
        ],
      ),
    );
  }
}
