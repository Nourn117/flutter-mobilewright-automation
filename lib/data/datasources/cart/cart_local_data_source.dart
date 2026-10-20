import 'package:mobilewright_demo_app/domain/entities/cart/cart_item.dart';

/// In-memory cart storage (cleared when the app restarts).
class CartLocalDataSource {
  final Map<String, CartItem> _items = {};

  List<CartItem> getAll() => List.unmodifiable(_items.values);

  CartItem? find(String productId) => _items[productId];

  void save(CartItem item) => _items[item.product.id] = item;

  void remove(String productId) => _items.remove(productId);

  void clear() => _items.clear();
}
