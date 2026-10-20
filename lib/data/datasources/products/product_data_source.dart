import 'package:mobilewright_demo_app/data/models/products/product_model.dart';

abstract interface class ProductDataSource {
  Future<List<ProductModel>> getProducts();
}

/// Fixed product catalogue used for testing (prices in EGP).
class ProductMockDataSource implements ProductDataSource {
  static const _latency = Duration(milliseconds: 500);

  static const List<ProductModel> _products = [
    ProductModel(id: 'p1', name: 'Wireless Headphones', category: 'Audio', price: 2499, description: 'Over-ear headphones with active noise cancelling and up to 30 hours of battery life.'),
    ProductModel(id: 'p2', name: 'Smart Watch', category: 'Wearables', price: 5999, description: 'AMOLED display, heart-rate and sleep tracking, and smartphone notifications.'),
    ProductModel(id: 'p3', name: 'Bluetooth Speaker', category: 'Audio', price: 1299, description: 'Portable waterproof speaker with deep bass and 12 hours of playtime.'),
    ProductModel(id: 'p4', name: 'Laptop Stand', category: 'Accessories', price: 899, description: 'Adjustable aluminium stand that raises your screen to eye level.'),
    ProductModel(id: 'p5', name: 'USB-C Hub', category: 'Accessories', price: 749, description: '7-in-1 hub with HDMI 4K, USB 3.0 ports and SD card reader.'),
    ProductModel(id: 'p6', name: 'Mechanical Keyboard', category: 'Accessories', price: 2199, description: 'RGB backlit keyboard with tactile blue switches.'),
    ProductModel(id: 'p7', name: 'Fitness Band', category: 'Wearables', price: 1499, description: 'Lightweight band that tracks steps, calories and workouts.'),
    ProductModel(id: 'p8', name: 'Wireless Earbuds', category: 'Audio', price: 1899, description: 'True wireless earbuds with charging case and touch controls.'),
  ];

  @override
  Future<List<ProductModel>> getProducts() async {
    await Future<void>.delayed(_latency);
    return _products;
  }
}
