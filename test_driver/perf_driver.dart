import 'package:integration_test/integration_test_driver.dart';

/// Runs integration_test/performance_test.dart on the device and writes the
/// collected numbers to build/integration_response_data.json.
Future<void> main() => integrationDriver();
