// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutDetails {

 String get fullName; String get phone; String get city; String get address; DateTime get deliveryDate; DeliverySlot get slot; PaymentMethod get paymentMethod; bool get saveAddress; String get notes;
/// Create a copy of CheckoutDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutDetailsCopyWith<CheckoutDetails> get copyWith => _$CheckoutDetailsCopyWithImpl<CheckoutDetails>(this as CheckoutDetails, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CheckoutDetails;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutDetails&&(identical(other.fullName, _this.fullName) || other.fullName == _this.fullName)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.deliveryDate, _this.deliveryDate) || other.deliveryDate == _this.deliveryDate)&&(identical(other.slot, _this.slot) || other.slot == _this.slot)&&(identical(other.paymentMethod, _this.paymentMethod) || other.paymentMethod == _this.paymentMethod)&&(identical(other.saveAddress, _this.saveAddress) || other.saveAddress == _this.saveAddress)&&(identical(other.notes, _this.notes) || other.notes == _this.notes));
}


@override
int get hashCode {
  final _this = this as CheckoutDetails;
  return Object.hash(runtimeType,_this.fullName,_this.phone,_this.city,_this.address,_this.deliveryDate,_this.slot,_this.paymentMethod,_this.saveAddress,_this.notes);
}

@override
String toString() {
  final _this = this as CheckoutDetails;
  return 'CheckoutDetails(fullName: ${_this.fullName}, phone: ${_this.phone}, city: ${_this.city}, address: ${_this.address}, deliveryDate: ${_this.deliveryDate}, slot: ${_this.slot}, paymentMethod: ${_this.paymentMethod}, saveAddress: ${_this.saveAddress}, notes: ${_this.notes})';
}


}

/// @nodoc
abstract mixin class $CheckoutDetailsCopyWith<$Res>  {
  factory $CheckoutDetailsCopyWith(CheckoutDetails value, $Res Function(CheckoutDetails) _then) = _$CheckoutDetailsCopyWithImpl;
@useResult
$Res call({
 String fullName, String phone, String city, String address, DateTime deliveryDate, DeliverySlot slot, PaymentMethod paymentMethod, bool saveAddress, String notes
});




}
/// @nodoc
class _$CheckoutDetailsCopyWithImpl<$Res>
    implements $CheckoutDetailsCopyWith<$Res> {
  _$CheckoutDetailsCopyWithImpl(this._self, this._then);

  final CheckoutDetails _self;
  final $Res Function(CheckoutDetails) _then;

/// Create a copy of CheckoutDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? phone = null,Object? city = null,Object? address = null,Object? deliveryDate = null,Object? slot = null,Object? paymentMethod = null,Object? saveAddress = null,Object? notes = null,}) {
  return _then(CheckoutDetails(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,deliveryDate: null == deliveryDate ? _self.deliveryDate : deliveryDate // ignore: cast_nullable_to_non_nullable
as DateTime,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as DeliverySlot,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,saveAddress: null == saveAddress ? _self.saveAddress : saveAddress // ignore: cast_nullable_to_non_nullable
as bool,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutDetails].
extension CheckoutDetailsPatterns on CheckoutDetails {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutDetails() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutDetails value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutDetails():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutDetails value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutDetails() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  String phone,  String city,  String address,  DateTime deliveryDate,  DeliverySlot slot,  PaymentMethod paymentMethod,  bool saveAddress,  String notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutDetails() when $default != null:
return $default(_that.fullName,_that.phone,_that.city,_that.address,_that.deliveryDate,_that.slot,_that.paymentMethod,_that.saveAddress,_that.notes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  String phone,  String city,  String address,  DateTime deliveryDate,  DeliverySlot slot,  PaymentMethod paymentMethod,  bool saveAddress,  String notes)  $default,) {final _that = this;
switch (_that) {
case _CheckoutDetails():
return $default(_that.fullName,_that.phone,_that.city,_that.address,_that.deliveryDate,_that.slot,_that.paymentMethod,_that.saveAddress,_that.notes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  String phone,  String city,  String address,  DateTime deliveryDate,  DeliverySlot slot,  PaymentMethod paymentMethod,  bool saveAddress,  String notes)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutDetails() when $default != null:
return $default(_that.fullName,_that.phone,_that.city,_that.address,_that.deliveryDate,_that.slot,_that.paymentMethod,_that.saveAddress,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _CheckoutDetails implements CheckoutDetails {
  const _CheckoutDetails({required this.fullName, required this.phone, required this.city, required this.address, required this.deliveryDate, required this.slot, required this.paymentMethod, this.saveAddress = false, this.notes = ''});
  

@override final  String fullName;
@override final  String phone;
@override final  String city;
@override final  String address;
@override final  DateTime deliveryDate;
@override final  DeliverySlot slot;
@override final  PaymentMethod paymentMethod;
@override@JsonKey() final  bool saveAddress;
@override@JsonKey() final  String notes;

/// Create a copy of CheckoutDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutDetailsCopyWith<_CheckoutDetails> get copyWith => __$CheckoutDetailsCopyWithImpl<_CheckoutDetails>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutDetails&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.city, city) || other.city == city)&&(identical(other.address, address) || other.address == address)&&(identical(other.deliveryDate, deliveryDate) || other.deliveryDate == deliveryDate)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.saveAddress, saveAddress) || other.saveAddress == saveAddress)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,fullName,phone,city,address,deliveryDate,slot,paymentMethod,saveAddress,notes);
}

@override
String toString() {
    return 'CheckoutDetails(fullName: $fullName, phone: $phone, city: $city, address: $address, deliveryDate: $deliveryDate, slot: $slot, paymentMethod: $paymentMethod, saveAddress: $saveAddress, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$CheckoutDetailsCopyWith<$Res> implements $CheckoutDetailsCopyWith<$Res> {
  factory _$CheckoutDetailsCopyWith(_CheckoutDetails value, $Res Function(_CheckoutDetails) _then) = __$CheckoutDetailsCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String phone, String city, String address, DateTime deliveryDate, DeliverySlot slot, PaymentMethod paymentMethod, bool saveAddress, String notes
});




}
/// @nodoc
class __$CheckoutDetailsCopyWithImpl<$Res>
    implements _$CheckoutDetailsCopyWith<$Res> {
  __$CheckoutDetailsCopyWithImpl(this._self, this._then);

  final _CheckoutDetails _self;
  final $Res Function(_CheckoutDetails) _then;

/// Create a copy of CheckoutDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? phone = null,Object? city = null,Object? address = null,Object? deliveryDate = null,Object? slot = null,Object? paymentMethod = null,Object? saveAddress = null,Object? notes = null,}) {
  return _then(_CheckoutDetails(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,deliveryDate: null == deliveryDate ? _self.deliveryDate : deliveryDate // ignore: cast_nullable_to_non_nullable
as DateTime,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as DeliverySlot,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,saveAddress: null == saveAddress ? _self.saveAddress : saveAddress // ignore: cast_nullable_to_non_nullable
as bool,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
