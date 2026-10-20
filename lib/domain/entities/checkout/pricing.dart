/// Business pricing rules shared by cart and checkout.
class Pricing {
  Pricing._();

  /// Flat delivery fee in EGP.
  static const double deliveryFee = 50;

  static const List<String> cities = [
    'Cairo',
    'Giza',
    'Alexandria',
    'Mansoura',
    'Tanta',
    'Aswan',
  ];
}
