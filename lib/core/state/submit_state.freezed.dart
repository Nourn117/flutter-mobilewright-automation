// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'submit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubmitState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SubmitState()';
}


}

/// @nodoc
class $SubmitStateCopyWith<$Res>  {
$SubmitStateCopyWith(SubmitState _, $Res Function(SubmitState) __);
}


/// Adds pattern-matching-related methods to [SubmitState].
extension SubmitStatePatterns on SubmitState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SubmitInitial value)?  initial,TResult Function( SubmitLoading value)?  loading,TResult Function( SubmitSuccess value)?  success,TResult Function( SubmitFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SubmitInitial() when initial != null:
return initial(_that);case SubmitLoading() when loading != null:
return loading(_that);case SubmitSuccess() when success != null:
return success(_that);case SubmitFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SubmitInitial value)  initial,required TResult Function( SubmitLoading value)  loading,required TResult Function( SubmitSuccess value)  success,required TResult Function( SubmitFailure value)  failure,}){
final _that = this;
switch (_that) {
case SubmitInitial():
return initial(_that);case SubmitLoading():
return loading(_that);case SubmitSuccess():
return success(_that);case SubmitFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SubmitInitial value)?  initial,TResult? Function( SubmitLoading value)?  loading,TResult? Function( SubmitSuccess value)?  success,TResult? Function( SubmitFailure value)?  failure,}){
final _that = this;
switch (_that) {
case SubmitInitial() when initial != null:
return initial(_that);case SubmitLoading() when loading != null:
return loading(_that);case SubmitSuccess() when success != null:
return success(_that);case SubmitFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SubmitInitial() when initial != null:
return initial();case SubmitLoading() when loading != null:
return loading();case SubmitSuccess() when success != null:
return success();case SubmitFailure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case SubmitInitial():
return initial();case SubmitLoading():
return loading();case SubmitSuccess():
return success();case SubmitFailure():
return failure(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case SubmitInitial() when initial != null:
return initial();case SubmitLoading() when loading != null:
return loading();case SubmitSuccess() when success != null:
return success();case SubmitFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SubmitInitial implements SubmitState {
  const SubmitInitial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SubmitState.initial()';
}


}




/// @nodoc


class SubmitLoading implements SubmitState {
  const SubmitLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SubmitState.loading()';
}


}




/// @nodoc


class SubmitSuccess implements SubmitState {
  const SubmitSuccess();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SubmitState.success()';
}


}




/// @nodoc


class SubmitFailure implements SubmitState {
  const SubmitFailure(this.message);
  

 final  String message;

/// Create a copy of SubmitState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitFailureCopyWith<SubmitFailure> get copyWith => _$SubmitFailureCopyWithImpl<SubmitFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'SubmitState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $SubmitFailureCopyWith<$Res> implements $SubmitStateCopyWith<$Res> {
  factory $SubmitFailureCopyWith(SubmitFailure value, $Res Function(SubmitFailure) _then) = _$SubmitFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SubmitFailureCopyWithImpl<$Res>
    implements $SubmitFailureCopyWith<$Res> {
  _$SubmitFailureCopyWithImpl(this._self, this._then);

  final SubmitFailure _self;
  final $Res Function(SubmitFailure) _then;

/// Create a copy of SubmitState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SubmitFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
