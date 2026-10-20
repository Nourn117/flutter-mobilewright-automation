import 'package:mobilewright_demo_app/domain/entities/products/product.dart';

class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
  });

  final String id;
  final String name;
  final String description;
  final String category;
  final double price;

  Product toEntity() => Product(
        id: id,
        name: name,
        description: description,
        category: category,
        price: price,
      );
}
