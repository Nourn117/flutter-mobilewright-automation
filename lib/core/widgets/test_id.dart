import 'package:flutter/widgets.dart';

/// Wraps [child] with a Semantics identifier.
/// Android: exposed as resource-id. iOS: accessibilityIdentifier.
/// Mobilewright finds it with `screen.getByTestId(id)`.
class TestId extends StatelessWidget {
  const TestId(this.id, {super.key, required this.child});

  final String id;
  final Widget child;

  @override
  Widget build(BuildContext context) => Semantics(identifier: id, child: child);
}
