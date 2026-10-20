import 'package:mobilewright_demo_app/domain/repositories/cart/cart_repository.dart';

class ClearCartUseCase {
  const ClearCartUseCase(this._repository);

  final CartRepository _repository;

  void call() => _repository.clear();
}
