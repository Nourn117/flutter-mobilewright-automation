import 'package:flutter/material.dart';

import 'package:mobilewright_demo_app/core/widgets/test_id.dart';

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.value,
    required this.onChanged,
    required this.minusId,
    required this.valueId,
    required this.plusId,
    this.min = 1,
    this.max = 10,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final String minusId;
  final String valueId;
  final String plusId;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TestId(
            minusId,
            child: IconButton(
              tooltip: 'Decrease quantity',
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.remove_rounded),
              onPressed: value > min ? () => onChanged(value - 1) : null,
            ),
          ),
          SizedBox(
            width: 28,
            child: TestId(
              valueId,
              child: Text(
                '$value',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          TestId(
            plusId,
            child: IconButton(
              tooltip: 'Increase quantity',
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.add_rounded),
              onPressed: value < max ? () => onChanged(value + 1) : null,
            ),
          ),
        ],
      ),
    );
  }
}
