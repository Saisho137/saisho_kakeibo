// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currency_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CurrencyFormState {

 CurrencyFormStatus get status;/// The stored currency when editing; `null` when creating.
 Currency? get original; String get code; String get symbol; int get decimals; String get thousandsSeparator; String get decimalSeparator; Set<CurrencyError> get errors;/// Errors appear after the first submit, then update while typing.
 bool get showErrors;/// Last failure of a save or delete, shown once by the UI.
 Failure? get failure;
/// Create a copy of CurrencyFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrencyFormStateCopyWith<CurrencyFormState> get copyWith => _$CurrencyFormStateCopyWithImpl<CurrencyFormState>(this as CurrencyFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CurrencyFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyFormState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.original, _this.original) || other.original == _this.original)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.symbol, _this.symbol) || other.symbol == _this.symbol)&&(identical(other.decimals, _this.decimals) || other.decimals == _this.decimals)&&(identical(other.thousandsSeparator, _this.thousandsSeparator) || other.thousandsSeparator == _this.thousandsSeparator)&&(identical(other.decimalSeparator, _this.decimalSeparator) || other.decimalSeparator == _this.decimalSeparator)&&const DeepCollectionEquality().equals(other.errors, _this.errors)&&(identical(other.showErrors, _this.showErrors) || other.showErrors == _this.showErrors)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as CurrencyFormState;
  return Object.hash(runtimeType,_this.status,_this.original,_this.code,_this.symbol,_this.decimals,_this.thousandsSeparator,_this.decimalSeparator,const DeepCollectionEquality().hash(_this.errors),_this.showErrors,_this.failure);
}

@override
String toString() {
  final _this = this as CurrencyFormState;
  return 'CurrencyFormState(status: ${_this.status}, original: ${_this.original}, code: ${_this.code}, symbol: ${_this.symbol}, decimals: ${_this.decimals}, thousandsSeparator: ${_this.thousandsSeparator}, decimalSeparator: ${_this.decimalSeparator}, errors: ${_this.errors}, showErrors: ${_this.showErrors}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $CurrencyFormStateCopyWith<$Res>  {
  factory $CurrencyFormStateCopyWith(CurrencyFormState value, $Res Function(CurrencyFormState) _then) = _$CurrencyFormStateCopyWithImpl;
@useResult
$Res call({
 CurrencyFormStatus status, Currency? original, String code, String symbol, int decimals, String thousandsSeparator, String decimalSeparator, Set<CurrencyError> errors, bool showErrors, Failure? failure
});


$CurrencyCopyWith<$Res>? get original;

}
/// @nodoc
class _$CurrencyFormStateCopyWithImpl<$Res>
    implements $CurrencyFormStateCopyWith<$Res> {
  _$CurrencyFormStateCopyWithImpl(this._self, this._then);

  final CurrencyFormState _self;
  final $Res Function(CurrencyFormState) _then;

/// Create a copy of CurrencyFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? original = freezed,Object? code = null,Object? symbol = null,Object? decimals = null,Object? thousandsSeparator = null,Object? decimalSeparator = null,Object? errors = null,Object? showErrors = null,Object? failure = freezed,}) {
  return _then(CurrencyFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CurrencyFormStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Currency?,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,thousandsSeparator: null == thousandsSeparator ? _self.thousandsSeparator : thousandsSeparator // ignore: cast_nullable_to_non_nullable
as String,decimalSeparator: null == decimalSeparator ? _self.decimalSeparator : decimalSeparator // ignore: cast_nullable_to_non_nullable
as String,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as Set<CurrencyError>,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of CurrencyFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrencyCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $CurrencyCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}


/// Adds pattern-matching-related methods to [CurrencyFormState].
extension CurrencyFormStatePatterns on CurrencyFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrencyFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrencyFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrencyFormState value)  $default,){
final _that = this;
switch (_that) {
case _CurrencyFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrencyFormState value)?  $default,){
final _that = this;
switch (_that) {
case _CurrencyFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CurrencyFormStatus status,  Currency? original,  String code,  String symbol,  int decimals,  String thousandsSeparator,  String decimalSeparator,  Set<CurrencyError> errors,  bool showErrors,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrencyFormState() when $default != null:
return $default(_that.status,_that.original,_that.code,_that.symbol,_that.decimals,_that.thousandsSeparator,_that.decimalSeparator,_that.errors,_that.showErrors,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CurrencyFormStatus status,  Currency? original,  String code,  String symbol,  int decimals,  String thousandsSeparator,  String decimalSeparator,  Set<CurrencyError> errors,  bool showErrors,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _CurrencyFormState():
return $default(_that.status,_that.original,_that.code,_that.symbol,_that.decimals,_that.thousandsSeparator,_that.decimalSeparator,_that.errors,_that.showErrors,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CurrencyFormStatus status,  Currency? original,  String code,  String symbol,  int decimals,  String thousandsSeparator,  String decimalSeparator,  Set<CurrencyError> errors,  bool showErrors,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _CurrencyFormState() when $default != null:
return $default(_that.status,_that.original,_that.code,_that.symbol,_that.decimals,_that.thousandsSeparator,_that.decimalSeparator,_that.errors,_that.showErrors,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _CurrencyFormState extends CurrencyFormState {
  const _CurrencyFormState({this.status = CurrencyFormStatus.loading, this.original, this.code = '', this.symbol = '', this.decimals = 2, this.thousandsSeparator = '.', this.decimalSeparator = ',',  Set<CurrencyError> errors = const <CurrencyError>{}, this.showErrors = false, this.failure}): _errors = errors,super._();
  

@override@JsonKey() final  CurrencyFormStatus status;
/// The stored currency when editing; `null` when creating.
@override final  Currency? original;
@override@JsonKey() final  String code;
@override@JsonKey() final  String symbol;
@override@JsonKey() final  int decimals;
@override@JsonKey() final  String thousandsSeparator;
@override@JsonKey() final  String decimalSeparator;
 final  Set<CurrencyError> _errors;
@override@JsonKey() Set<CurrencyError> get errors {
  if (_errors is EqualUnmodifiableSetView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_errors);
}

/// Errors appear after the first submit, then update while typing.
@override@JsonKey() final  bool showErrors;
/// Last failure of a save or delete, shown once by the UI.
@override final  Failure? failure;

/// Create a copy of CurrencyFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrencyFormStateCopyWith<_CurrencyFormState> get copyWith => __$CurrencyFormStateCopyWithImpl<_CurrencyFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrencyFormState&&(identical(other.status, status) || other.status == status)&&(identical(other.original, original) || other.original == original)&&(identical(other.code, code) || other.code == code)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.thousandsSeparator, thousandsSeparator) || other.thousandsSeparator == thousandsSeparator)&&(identical(other.decimalSeparator, decimalSeparator) || other.decimalSeparator == decimalSeparator)&&const DeepCollectionEquality().equals(other.errors, _errors)&&(identical(other.showErrors, showErrors) || other.showErrors == showErrors)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,original,code,symbol,decimals,thousandsSeparator,decimalSeparator,const DeepCollectionEquality().hash(_errors),showErrors,failure);
}

@override
String toString() {
    return 'CurrencyFormState(status: $status, original: $original, code: $code, symbol: $symbol, decimals: $decimals, thousandsSeparator: $thousandsSeparator, decimalSeparator: $decimalSeparator, errors: $errors, showErrors: $showErrors, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$CurrencyFormStateCopyWith<$Res> implements $CurrencyFormStateCopyWith<$Res> {
  factory _$CurrencyFormStateCopyWith(_CurrencyFormState value, $Res Function(_CurrencyFormState) _then) = __$CurrencyFormStateCopyWithImpl;
@override @useResult
$Res call({
 CurrencyFormStatus status, Currency? original, String code, String symbol, int decimals, String thousandsSeparator, String decimalSeparator, Set<CurrencyError> errors, bool showErrors, Failure? failure
});


@override $CurrencyCopyWith<$Res>? get original;

}
/// @nodoc
class __$CurrencyFormStateCopyWithImpl<$Res>
    implements _$CurrencyFormStateCopyWith<$Res> {
  __$CurrencyFormStateCopyWithImpl(this._self, this._then);

  final _CurrencyFormState _self;
  final $Res Function(_CurrencyFormState) _then;

/// Create a copy of CurrencyFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? original = freezed,Object? code = null,Object? symbol = null,Object? decimals = null,Object? thousandsSeparator = null,Object? decimalSeparator = null,Object? errors = null,Object? showErrors = null,Object? failure = freezed,}) {
  return _then(_CurrencyFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CurrencyFormStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Currency?,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,thousandsSeparator: null == thousandsSeparator ? _self.thousandsSeparator : thousandsSeparator // ignore: cast_nullable_to_non_nullable
as String,decimalSeparator: null == decimalSeparator ? _self.decimalSeparator : decimalSeparator // ignore: cast_nullable_to_non_nullable
as String,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Set<CurrencyError>,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of CurrencyFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrencyCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $CurrencyCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}

// dart format on
