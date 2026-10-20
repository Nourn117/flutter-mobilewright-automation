import 'package:mobilewright_demo_app/domain/entities/cart/cart_item.dart';
import 'package:mobilewright_demo_app/domain/repositories/cart/cart_repository.dart';

class GetCartUseCase {
  const GetCartUseCase(this._repository);

  final CartRepository _repository;

  List<CartItem> call() => _repository.getItems();
}
