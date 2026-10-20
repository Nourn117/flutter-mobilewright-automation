import 'package:mobilewright_demo_app/domain/repositories/cart/cart_repository.dart';

class RemoveFromCartUseCase {
  const RemoveFromCartUseCase(this._repository);

  final CartRepository _repository;

  void call(String productId) => _repository.remove(productId);
}
