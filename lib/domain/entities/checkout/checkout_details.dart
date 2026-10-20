import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_details.freezed.dart';

enum DeliverySlot { morning, evening }

enum PaymentMethod { cashOnDelivery, card }

@freezed
abstract class CheckoutDetails with _$CheckoutDetails {
  const factory CheckoutDetails({
    required String fullName,
    required String phone,
    required String city,
    required String address,
    required DateTime deliveryDate,
    required DeliverySlot slot,
    required PaymentMethod paymentMethod,
    @Default(false) bool saveAddress,
    @Default('') String notes,
  }) = _CheckoutDetails;
}
