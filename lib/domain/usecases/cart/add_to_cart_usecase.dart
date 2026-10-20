import 'package:mobilewright_demo_app/domain/repositories/cart/cart_repository.dart';
import 'package:mobilewright_demo_app/domain/entities/products/product.dart';

class AddToCartUseCase {
  const AddToCartUseCase(this._repository);

  final CartRepository _repository;

  void call(Product product, int quantity) {
    if (quantity <= 0) return;
    _repository.add(product, quantity);
  }
}
