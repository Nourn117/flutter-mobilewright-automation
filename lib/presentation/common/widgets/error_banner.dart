import 'package:flutter/material.dart';

import 'package:mobilewright_demo_app/core/widgets/test_id.dart';

/// Inline error message shown inside a screen (instead of a snackbar).
class ErrorBanner extends StatelessWidget {
  const ErrorBanner({super.key, required this.id, required this.message});

  final String id;
  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, color: scheme.onErrorContainer),
          const SizedBox(width: 10),
          Expanded(
            child: TestId(
              id,
              child: Text(
                message,
                style: TextStyle(
                  color: scheme.onErrorContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
