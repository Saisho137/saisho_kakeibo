// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accounts_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountsState {

 AccountsStatus get status;/// Every account, archived included; `null` until loaded.
 List<Account>? get accounts;/// Own balance by account id; `null` until loaded.
 Map<int, int>? get balances; List<Currency> get currencies;/// Currency shown on the Accounts screen.
 String? get currencyCode; bool get showArchived;/// Last failure of an action, shown once by the UI.
 Failure? get failure;
/// Create a copy of AccountsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountsStateCopyWith<AccountsState> get copyWith => _$AccountsStateCopyWithImpl<AccountsState>(this as AccountsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AccountsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountsState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.accounts, _this.accounts)&&const DeepCollectionEquality().equals(other.balances, _this.balances)&&const DeepCollectionEquality().equals(other.currencies, _this.currencies)&&(identical(other.currencyCode, _this.currencyCode) || other.currencyCode == _this.currencyCode)&&(identical(other.showArchived, _this.showArchived) || other.showArchived == _this.showArchived)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as AccountsState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.accounts),const DeepCollectionEquality().hash(_this.balances),const DeepCollectionEquality().hash(_this.currencies),_this.currencyCode,_this.showArchived,_this.failure);
}

@override
String toString() {
  final _this = this as AccountsState;
  return 'AccountsState(status: ${_this.status}, accounts: ${_this.accounts}, balances: ${_this.balances}, currencies: ${_this.currencies}, currencyCode: ${_this.currencyCode}, showArchived: ${_this.showArchived}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $AccountsStateCopyWith<$Res>  {
  factory $AccountsStateCopyWith(AccountsState value, $Res Function(AccountsState) _then) = _$AccountsStateCopyWithImpl;
@useResult
$Res call({
 AccountsStatus status, List<Account>? accounts, Map<int, int>? balances, List<Currency> currencies, String? currencyCode, bool showArchived, Failure? failure
});




}
/// @nodoc
class _$AccountsStateCopyWithImpl<$Res>
    implements $AccountsStateCopyWith<$Res> {
  _$AccountsStateCopyWithImpl(this._self, this._then);

  final AccountsState _self;
  final $Res Function(AccountsState) _then;

/// Create a copy of AccountsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? accounts = freezed,Object? balances = freezed,Object? currencies = null,Object? currencyCode = freezed,Object? showArchived = null,Object? failure = freezed,}) {
  return _then(AccountsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AccountsStatus,accounts: freezed == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>?,balances: freezed == balances ? _self.balances : balances // ignore: cast_nullable_to_non_nullable
as Map<int, int>?,currencies: null == currencies ? _self.currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,currencyCode: freezed == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String?,showArchived: null == showArchived ? _self.showArchived : showArchived // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountsState].
extension AccountsStatePatterns on AccountsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountsState value)  $default,){
final _that = this;
switch (_that) {
case _AccountsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountsState value)?  $default,){
final _that = this;
switch (_that) {
case _AccountsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AccountsStatus status,  List<Account>? accounts,  Map<int, int>? balances,  List<Currency> currencies,  String? currencyCode,  bool showArchived,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountsState() when $default != null:
return $default(_that.status,_that.accounts,_that.balances,_that.currencies,_that.currencyCode,_that.showArchived,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AccountsStatus status,  List<Account>? accounts,  Map<int, int>? balances,  List<Currency> currencies,  String? currencyCode,  bool showArchived,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _AccountsState():
return $default(_that.status,_that.accounts,_that.balances,_that.currencies,_that.currencyCode,_that.showArchived,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AccountsStatus status,  List<Account>? accounts,  Map<int, int>? balances,  List<Currency> currencies,  String? currencyCode,  bool showArchived,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _AccountsState() when $default != null:
return $default(_that.status,_that.accounts,_that.balances,_that.currencies,_that.currencyCode,_that.showArchived,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _AccountsState extends AccountsState {
  const _AccountsState({this.status = AccountsStatus.loading,  List<Account>? accounts,  Map<int, int>? balances,  List<Currency> currencies = const <Currency>[], this.currencyCode, this.showArchived = false, this.failure}): _accounts = accounts,_balances = balances,_currencies = currencies,super._();
  

@override@JsonKey() final  AccountsStatus status;
/// Every account, archived included; `null` until loaded.
 final  List<Account>? _accounts;
/// Every account, archived included; `null` until loaded.
@override List<Account>? get accounts {
  final value = _accounts;
  if (value == null) return null;
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Own balance by account id; `null` until loaded.
 final  Map<int, int>? _balances;
/// Own balance by account id; `null` until loaded.
@override Map<int, int>? get balances {
  final value = _balances;
  if (value == null) return null;
  if (_balances is EqualUnmodifiableMapView) return _balances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<Currency> _currencies;
@override@JsonKey() List<Currency> get currencies {
  if (_currencies is EqualUnmodifiableListView) return _currencies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currencies);
}

/// Currency shown on the Accounts screen.
@override final  String? currencyCode;
@override@JsonKey() final  bool showArchived;
/// Last failure of an action, shown once by the UI.
@override final  Failure? failure;

/// Create a copy of AccountsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountsStateCopyWith<_AccountsState> get copyWith => __$AccountsStateCopyWithImpl<_AccountsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.accounts, _accounts)&&const DeepCollectionEquality().equals(other.balances, _balances)&&const DeepCollectionEquality().equals(other.currencies, _currencies)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.showArchived, showArchived) || other.showArchived == showArchived)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_balances),const DeepCollectionEquality().hash(_currencies),currencyCode,showArchived,failure);
}

@override
String toString() {
    return 'AccountsState(status: $status, accounts: $accounts, balances: $balances, currencies: $currencies, currencyCode: $currencyCode, showArchived: $showArchived, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$AccountsStateCopyWith<$Res> implements $AccountsStateCopyWith<$Res> {
  factory _$AccountsStateCopyWith(_AccountsState value, $Res Function(_AccountsState) _then) = __$AccountsStateCopyWithImpl;
@override @useResult
$Res call({
 AccountsStatus status, List<Account>? accounts, Map<int, int>? balances, List<Currency> currencies, String? currencyCode, bool showArchived, Failure? failure
});




}
/// @nodoc
class __$AccountsStateCopyWithImpl<$Res>
    implements _$AccountsStateCopyWith<$Res> {
  __$AccountsStateCopyWithImpl(this._self, this._then);

  final _AccountsState _self;
  final $Res Function(_AccountsState) _then;

/// Create a copy of AccountsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? accounts = freezed,Object? balances = freezed,Object? currencies = null,Object? currencyCode = freezed,Object? showArchived = null,Object? failure = freezed,}) {
  return _then(_AccountsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AccountsStatus,accounts: freezed == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>?,balances: freezed == balances ? _self._balances : balances // ignore: cast_nullable_to_non_nullable
as Map<int, int>?,currencies: null == currencies ? _self._currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,currencyCode: freezed == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String?,showArchived: null == showArchived ? _self.showArchived : showArchived // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
