import 'package:mobilewright_demo_app/domain/repositories/cart/cart_repository.dart';

class UpdateQuantityUseCase {
  const UpdateQuantityUseCase(this._repository);

  static const int maxQuantity = 10;

  final CartRepository _repository;

  void call(String productId, int quantity) =>
      _repository.setQuantity(productId, quantity.clamp(0, maxQuantity));
}
