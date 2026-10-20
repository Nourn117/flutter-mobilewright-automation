abstract interface class OrderDataSource {
  /// Submits the order and returns the generated order number.
  Future<String> submitOrder();
}

/// Mock order API: always succeeds after a short delay.
/// Order numbers are sequential (ORD-1001, ORD-1002, ...) to keep tests predictable.
class OrderMockDataSource implements OrderDataSource {
  static const _latency = Duration(milliseconds: 1200);

  int _nextId = 1001;

  @override
  Future<String> submitOrder() async {
    await Future<void>.delayed(_latency);
    return 'ORD-${_nextId++}';
  }
}
