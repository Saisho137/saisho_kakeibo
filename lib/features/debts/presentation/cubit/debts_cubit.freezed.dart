// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debts_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DebtsState {

 DebtsStatus get status;/// Every stream's latest value; `null` until it arrives.
 List<Debt>? get debts; List<Movement>? get movements; List<Account>? get accounts; Map<int, int>? get balances; List<Pillar>? get pillars; List<Currency> get currencies; AppSettings? get settings;/// Currency picked on the screen; the main one until then.
 String? get selectedCurrencyCode; Failure? get failure;
/// Create a copy of DebtsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebtsStateCopyWith<DebtsState> get copyWith => _$DebtsStateCopyWithImpl<DebtsState>(this as DebtsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DebtsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebtsState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.debts, _this.debts)&&const DeepCollectionEquality().equals(other.movements, _this.movements)&&const DeepCollectionEquality().equals(other.accounts, _this.accounts)&&const DeepCollectionEquality().equals(other.balances, _this.balances)&&const DeepCollectionEquality().equals(other.pillars, _this.pillars)&&const DeepCollectionEquality().equals(other.currencies, _this.currencies)&&(identical(other.settings, _this.settings) || other.settings == _this.settings)&&(identical(other.selectedCurrencyCode, _this.selectedCurrencyCode) || other.selectedCurrencyCode == _this.selectedCurrencyCode)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as DebtsState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.debts),const DeepCollectionEquality().hash(_this.movements),const DeepCollectionEquality().hash(_this.accounts),const DeepCollectionEquality().hash(_this.balances),const DeepCollectionEquality().hash(_this.pillars),const DeepCollectionEquality().hash(_this.currencies),_this.settings,_this.selectedCurrencyCode,_this.failure);
}

@override
String toString() {
  final _this = this as DebtsState;
  return 'DebtsState(status: ${_this.status}, debts: ${_this.debts}, movements: ${_this.movements}, accounts: ${_this.accounts}, balances: ${_this.balances}, pillars: ${_this.pillars}, currencies: ${_this.currencies}, settings: ${_this.settings}, selectedCurrencyCode: ${_this.selectedCurrencyCode}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $DebtsStateCopyWith<$Res>  {
  factory $DebtsStateCopyWith(DebtsState value, $Res Function(DebtsState) _then) = _$DebtsStateCopyWithImpl;
@useResult
$Res call({
 DebtsStatus status, List<Debt>? debts, List<Movement>? movements, List<Account>? accounts, Map<int, int>? balances, List<Pillar>? pillars, List<Currency> currencies, AppSettings? settings, String? selectedCurrencyCode, Failure? failure
});


$AppSettingsCopyWith<$Res>? get settings;

}
/// @nodoc
class _$DebtsStateCopyWithImpl<$Res>
    implements $DebtsStateCopyWith<$Res> {
  _$DebtsStateCopyWithImpl(this._self, this._then);

  final DebtsState _self;
  final $Res Function(DebtsState) _then;

/// Create a copy of DebtsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? debts = freezed,Object? movements = freezed,Object? accounts = freezed,Object? balances = freezed,Object? pillars = freezed,Object? currencies = null,Object? settings = freezed,Object? selectedCurrencyCode = freezed,Object? failure = freezed,}) {
  return _then(DebtsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DebtsStatus,debts: freezed == debts ? _self.debts : debts // ignore: cast_nullable_to_non_nullable
as List<Debt>?,movements: freezed == movements ? _self.movements : movements // ignore: cast_nullable_to_non_nullable
as List<Movement>?,accounts: freezed == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>?,balances: freezed == balances ? _self.balances : balances // ignore: cast_nullable_to_non_nullable
as Map<int, int>?,pillars: freezed == pillars ? _self.pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<Pillar>?,currencies: null == currencies ? _self.currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as AppSettings?,selectedCurrencyCode: freezed == selectedCurrencyCode ? _self.selectedCurrencyCode : selectedCurrencyCode // ignore: cast_nullable_to_non_nullable
as String?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of DebtsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $AppSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}


/// Adds pattern-matching-related methods to [DebtsState].
extension DebtsStatePatterns on DebtsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebtsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebtsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebtsState value)  $default,){
final _that = this;
switch (_that) {
case _DebtsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebtsState value)?  $default,){
final _that = this;
switch (_that) {
case _DebtsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DebtsStatus status,  List<Debt>? debts,  List<Movement>? movements,  List<Account>? accounts,  Map<int, int>? balances,  List<Pillar>? pillars,  List<Currency> currencies,  AppSettings? settings,  String? selectedCurrencyCode,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebtsState() when $default != null:
return $default(_that.status,_that.debts,_that.movements,_that.accounts,_that.balances,_that.pillars,_that.currencies,_that.settings,_that.selectedCurrencyCode,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DebtsStatus status,  List<Debt>? debts,  List<Movement>? movements,  List<Account>? accounts,  Map<int, int>? balances,  List<Pillar>? pillars,  List<Currency> currencies,  AppSettings? settings,  String? selectedCurrencyCode,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _DebtsState():
return $default(_that.status,_that.debts,_that.movements,_that.accounts,_that.balances,_that.pillars,_that.currencies,_that.settings,_that.selectedCurrencyCode,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DebtsStatus status,  List<Debt>? debts,  List<Movement>? movements,  List<Account>? accounts,  Map<int, int>? balances,  List<Pillar>? pillars,  List<Currency> currencies,  AppSettings? settings,  String? selectedCurrencyCode,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _DebtsState() when $default != null:
return $default(_that.status,_that.debts,_that.movements,_that.accounts,_that.balances,_that.pillars,_that.currencies,_that.settings,_that.selectedCurrencyCode,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _DebtsState extends DebtsState {
  const _DebtsState({this.status = DebtsStatus.loading,  List<Debt>? debts,  List<Movement>? movements,  List<Account>? accounts,  Map<int, int>? balances,  List<Pillar>? pillars,  List<Currency> currencies = const <Currency>[], this.settings, this.selectedCurrencyCode, this.failure}): _debts = debts,_movements = movements,_accounts = accounts,_balances = balances,_pillars = pillars,_currencies = currencies,super._();
  

@override@JsonKey() final  DebtsStatus status;
/// Every stream's latest value; `null` until it arrives.
 final  List<Debt>? _debts;
/// Every stream's latest value; `null` until it arrives.
@override List<Debt>? get debts {
  final value = _debts;
  if (value == null) return null;
  if (_debts is EqualUnmodifiableListView) return _debts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Movement>? _movements;
@override List<Movement>? get movements {
  final value = _movements;
  if (value == null) return null;
  if (_movements is EqualUnmodifiableListView) return _movements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Account>? _accounts;
@override List<Account>? get accounts {
  final value = _accounts;
  if (value == null) return null;
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<int, int>? _balances;
@override Map<int, int>? get balances {
  final value = _balances;
  if (value == null) return null;
  if (_balances is EqualUnmodifiableMapView) return _balances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<Pillar>? _pillars;
@override List<Pillar>? get pillars {
  final value = _pillars;
  if (value == null) return null;
  if (_pillars is EqualUnmodifiableListView) return _pillars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Currency> _currencies;
@override@JsonKey() List<Currency> get currencies {
  if (_currencies is EqualUnmodifiableListView) return _currencies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currencies);
}

@override final  AppSettings? settings;
/// Currency picked on the screen; the main one until then.
@override final  String? selectedCurrencyCode;
@override final  Failure? failure;

/// Create a copy of DebtsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebtsStateCopyWith<_DebtsState> get copyWith => __$DebtsStateCopyWithImpl<_DebtsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebtsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.debts, _debts)&&const DeepCollectionEquality().equals(other.movements, _movements)&&const DeepCollectionEquality().equals(other.accounts, _accounts)&&const DeepCollectionEquality().equals(other.balances, _balances)&&const DeepCollectionEquality().equals(other.pillars, _pillars)&&const DeepCollectionEquality().equals(other.currencies, _currencies)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.selectedCurrencyCode, selectedCurrencyCode) || other.selectedCurrencyCode == selectedCurrencyCode)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_debts),const DeepCollectionEquality().hash(_movements),const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_balances),const DeepCollectionEquality().hash(_pillars),const DeepCollectionEquality().hash(_currencies),settings,selectedCurrencyCode,failure);
}

@override
String toString() {
    return 'DebtsState(status: $status, debts: $debts, movements: $movements, accounts: $accounts, balances: $balances, pillars: $pillars, currencies: $currencies, settings: $settings, selectedCurrencyCode: $selectedCurrencyCode, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$DebtsStateCopyWith<$Res> implements $DebtsStateCopyWith<$Res> {
  factory _$DebtsStateCopyWith(_DebtsState value, $Res Function(_DebtsState) _then) = __$DebtsStateCopyWithImpl;
@override @useResult
$Res call({
 DebtsStatus status, List<Debt>? debts, List<Movement>? movements, List<Account>? accounts, Map<int, int>? balances, List<Pillar>? pillars, List<Currency> currencies, AppSettings? settings, String? selectedCurrencyCode, Failure? failure
});


@override $AppSettingsCopyWith<$Res>? get settings;

}
/// @nodoc
class __$DebtsStateCopyWithImpl<$Res>
    implements _$DebtsStateCopyWith<$Res> {
  __$DebtsStateCopyWithImpl(this._self, this._then);

  final _DebtsState _self;
  final $Res Function(_DebtsState) _then;

/// Create a copy of DebtsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? debts = freezed,Object? movements = freezed,Object? accounts = freezed,Object? balances = freezed,Object? pillars = freezed,Object? currencies = null,Object? settings = freezed,Object? selectedCurrencyCode = freezed,Object? failure = freezed,}) {
  return _then(_DebtsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DebtsStatus,debts: freezed == debts ? _self._debts : debts // ignore: cast_nullable_to_non_nullable
as List<Debt>?,movements: freezed == movements ? _self._movements : movements // ignore: cast_nullable_to_non_nullable
as List<Movement>?,accounts: freezed == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>?,balances: freezed == balances ? _self._balances : balances // ignore: cast_nullable_to_non_nullable
as Map<int, int>?,pillars: freezed == pillars ? _self._pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<Pillar>?,currencies: null == currencies ? _self._currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as AppSettings?,selectedCurrencyCode: freezed == selectedCurrencyCode ? _self.selectedCurrencyCode : selectedCurrencyCode // ignore: cast_nullable_to_non_nullable
as String?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of DebtsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $AppSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}

// dart format on
