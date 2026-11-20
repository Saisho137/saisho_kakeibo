// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currencies_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CurrenciesState {

 CurrenciesStatus get status; List<Currency> get currencies; Failure? get failure;
/// Create a copy of CurrenciesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrenciesStateCopyWith<CurrenciesState> get copyWith => _$CurrenciesStateCopyWithImpl<CurrenciesState>(this as CurrenciesState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CurrenciesState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrenciesState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.currencies, _this.currencies)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as CurrenciesState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.currencies),_this.failure);
}

@override
String toString() {
  final _this = this as CurrenciesState;
  return 'CurrenciesState(status: ${_this.status}, currencies: ${_this.currencies}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $CurrenciesStateCopyWith<$Res>  {
  factory $CurrenciesStateCopyWith(CurrenciesState value, $Res Function(CurrenciesState) _then) = _$CurrenciesStateCopyWithImpl;
@useResult
$Res call({
 CurrenciesStatus status, List<Currency> currencies, Failure? failure
});




}
/// @nodoc
class _$CurrenciesStateCopyWithImpl<$Res>
    implements $CurrenciesStateCopyWith<$Res> {
  _$CurrenciesStateCopyWithImpl(this._self, this._then);

  final CurrenciesState _self;
  final $Res Function(CurrenciesState) _then;

/// Create a copy of CurrenciesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? currencies = null,Object? failure = freezed,}) {
  return _then(CurrenciesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CurrenciesStatus,currencies: null == currencies ? _self.currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrenciesState].
extension CurrenciesStatePatterns on CurrenciesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrenciesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrenciesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrenciesState value)  $default,){
final _that = this;
switch (_that) {
case _CurrenciesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrenciesState value)?  $default,){
final _that = this;
switch (_that) {
case _CurrenciesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CurrenciesStatus status,  List<Currency> currencies,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrenciesState() when $default != null:
return $default(_that.status,_that.currencies,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CurrenciesStatus status,  List<Currency> currencies,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _CurrenciesState():
return $default(_that.status,_that.currencies,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CurrenciesStatus status,  List<Currency> currencies,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _CurrenciesState() when $default != null:
return $default(_that.status,_that.currencies,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _CurrenciesState implements CurrenciesState {
  const _CurrenciesState({this.status = CurrenciesStatus.loading,  List<Currency> currencies = const <Currency>[], this.failure}): _currencies = currencies;
  

@override@JsonKey() final  CurrenciesStatus status;
 final  List<Currency> _currencies;
@override@JsonKey() List<Currency> get currencies {
  if (_currencies is EqualUnmodifiableListView) return _currencies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currencies);
}

@override final  Failure? failure;

/// Create a copy of CurrenciesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrenciesStateCopyWith<_CurrenciesState> get copyWith => __$CurrenciesStateCopyWithImpl<_CurrenciesState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrenciesState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.currencies, _currencies)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_currencies),failure);
}

@override
String toString() {
    return 'CurrenciesState(status: $status, currencies: $currencies, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$CurrenciesStateCopyWith<$Res> implements $CurrenciesStateCopyWith<$Res> {
  factory _$CurrenciesStateCopyWith(_CurrenciesState value, $Res Function(_CurrenciesState) _then) = __$CurrenciesStateCopyWithImpl;
@override @useResult
$Res call({
 CurrenciesStatus status, List<Currency> currencies, Failure? failure
});




}
/// @nodoc
class __$CurrenciesStateCopyWithImpl<$Res>
    implements _$CurrenciesStateCopyWith<$Res> {
  __$CurrenciesStateCopyWithImpl(this._self, this._then);

  final _CurrenciesState _self;
  final $Res Function(_CurrenciesState) _then;

/// Create a copy of CurrenciesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? currencies = null,Object? failure = freezed,}) {
  return _then(_CurrenciesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CurrenciesStatus,currencies: null == currencies ? _self._currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
