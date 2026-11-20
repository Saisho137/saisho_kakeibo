// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountDetailState {

 AccountDetailStatus get status; int? get accountId;/// The day the screen opened; its period is shown first.
 LocalDate? get today;/// Every stream's latest value; `null` until it arrives.
 List<Account>? get accounts; Map<int, int>? get balances; List<Currency> get currencies; List<Movement>? get movements; List<Category>? get categories; List<Payee>? get payees; AppSettings? get settings; List<LocalDate>? get periodStarts;/// Last failure of an action, shown once by the UI.
 Failure? get failure;
/// Create a copy of AccountDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountDetailStateCopyWith<AccountDetailState> get copyWith => _$AccountDetailStateCopyWithImpl<AccountDetailState>(this as AccountDetailState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AccountDetailState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountDetailState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.today, _this.today) || other.today == _this.today)&&const DeepCollectionEquality().equals(other.accounts, _this.accounts)&&const DeepCollectionEquality().equals(other.balances, _this.balances)&&const DeepCollectionEquality().equals(other.currencies, _this.currencies)&&const DeepCollectionEquality().equals(other.movements, _this.movements)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.payees, _this.payees)&&(identical(other.settings, _this.settings) || other.settings == _this.settings)&&const DeepCollectionEquality().equals(other.periodStarts, _this.periodStarts)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as AccountDetailState;
  return Object.hash(runtimeType,_this.status,_this.accountId,_this.today,const DeepCollectionEquality().hash(_this.accounts),const DeepCollectionEquality().hash(_this.balances),const DeepCollectionEquality().hash(_this.currencies),const DeepCollectionEquality().hash(_this.movements),const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.payees),_this.settings,const DeepCollectionEquality().hash(_this.periodStarts),_this.failure);
}

@override
String toString() {
  final _this = this as AccountDetailState;
  return 'AccountDetailState(status: ${_this.status}, accountId: ${_this.accountId}, today: ${_this.today}, accounts: ${_this.accounts}, balances: ${_this.balances}, currencies: ${_this.currencies}, movements: ${_this.movements}, categories: ${_this.categories}, payees: ${_this.payees}, settings: ${_this.settings}, periodStarts: ${_this.periodStarts}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $AccountDetailStateCopyWith<$Res>  {
  factory $AccountDetailStateCopyWith(AccountDetailState value, $Res Function(AccountDetailState) _then) = _$AccountDetailStateCopyWithImpl;
@useResult
$Res call({
 AccountDetailStatus status, int? accountId, LocalDate? today, List<Account>? accounts, Map<int, int>? balances, List<Currency> currencies, List<Movement>? movements, List<Category>? categories, List<Payee>? payees, AppSettings? settings, List<LocalDate>? periodStarts, Failure? failure
});


$AppSettingsCopyWith<$Res>? get settings;

}
/// @nodoc
class _$AccountDetailStateCopyWithImpl<$Res>
    implements $AccountDetailStateCopyWith<$Res> {
  _$AccountDetailStateCopyWithImpl(this._self, this._then);

  final AccountDetailState _self;
  final $Res Function(AccountDetailState) _then;

/// Create a copy of AccountDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? accountId = freezed,Object? today = freezed,Object? accounts = freezed,Object? balances = freezed,Object? currencies = null,Object? movements = freezed,Object? categories = freezed,Object? payees = freezed,Object? settings = freezed,Object? periodStarts = freezed,Object? failure = freezed,}) {
  return _then(AccountDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AccountDetailStatus,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,today: freezed == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as LocalDate?,accounts: freezed == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>?,balances: freezed == balances ? _self.balances : balances // ignore: cast_nullable_to_non_nullable
as Map<int, int>?,currencies: null == currencies ? _self.currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,movements: freezed == movements ? _self.movements : movements // ignore: cast_nullable_to_non_nullable
as List<Movement>?,categories: freezed == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>?,payees: freezed == payees ? _self.payees : payees // ignore: cast_nullable_to_non_nullable
as List<Payee>?,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as AppSettings?,periodStarts: freezed == periodStarts ? _self.periodStarts : periodStarts // ignore: cast_nullable_to_non_nullable
as List<LocalDate>?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of AccountDetailState
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


/// Adds pattern-matching-related methods to [AccountDetailState].
extension AccountDetailStatePatterns on AccountDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountDetailState value)  $default,){
final _that = this;
switch (_that) {
case _AccountDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _AccountDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AccountDetailStatus status,  int? accountId,  LocalDate? today,  List<Account>? accounts,  Map<int, int>? balances,  List<Currency> currencies,  List<Movement>? movements,  List<Category>? categories,  List<Payee>? payees,  AppSettings? settings,  List<LocalDate>? periodStarts,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountDetailState() when $default != null:
return $default(_that.status,_that.accountId,_that.today,_that.accounts,_that.balances,_that.currencies,_that.movements,_that.categories,_that.payees,_that.settings,_that.periodStarts,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AccountDetailStatus status,  int? accountId,  LocalDate? today,  List<Account>? accounts,  Map<int, int>? balances,  List<Currency> currencies,  List<Movement>? movements,  List<Category>? categories,  List<Payee>? payees,  AppSettings? settings,  List<LocalDate>? periodStarts,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _AccountDetailState():
return $default(_that.status,_that.accountId,_that.today,_that.accounts,_that.balances,_that.currencies,_that.movements,_that.categories,_that.payees,_that.settings,_that.periodStarts,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AccountDetailStatus status,  int? accountId,  LocalDate? today,  List<Account>? accounts,  Map<int, int>? balances,  List<Currency> currencies,  List<Movement>? movements,  List<Category>? categories,  List<Payee>? payees,  AppSettings? settings,  List<LocalDate>? periodStarts,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _AccountDetailState() when $default != null:
return $default(_that.status,_that.accountId,_that.today,_that.accounts,_that.balances,_that.currencies,_that.movements,_that.categories,_that.payees,_that.settings,_that.periodStarts,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _AccountDetailState extends AccountDetailState {
  const _AccountDetailState({this.status = AccountDetailStatus.loading, this.accountId, this.today,  List<Account>? accounts,  Map<int, int>? balances,  List<Currency> currencies = const <Currency>[],  List<Movement>? movements,  List<Category>? categories,  List<Payee>? payees, this.settings,  List<LocalDate>? periodStarts, this.failure}): _accounts = accounts,_balances = balances,_currencies = currencies,_movements = movements,_categories = categories,_payees = payees,_periodStarts = periodStarts,super._();
  

@override@JsonKey() final  AccountDetailStatus status;
@override final  int? accountId;
/// The day the screen opened; its period is shown first.
@override final  LocalDate? today;
/// Every stream's latest value; `null` until it arrives.
 final  List<Account>? _accounts;
/// Every stream's latest value; `null` until it arrives.
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

 final  List<Currency> _currencies;
@override@JsonKey() List<Currency> get currencies {
  if (_currencies is EqualUnmodifiableListView) return _currencies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currencies);
}

 final  List<Movement>? _movements;
@override List<Movement>? get movements {
  final value = _movements;
  if (value == null) return null;
  if (_movements is EqualUnmodifiableListView) return _movements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Category>? _categories;
@override List<Category>? get categories {
  final value = _categories;
  if (value == null) return null;
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Payee>? _payees;
@override List<Payee>? get payees {
  final value = _payees;
  if (value == null) return null;
  if (_payees is EqualUnmodifiableListView) return _payees;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  AppSettings? settings;
 final  List<LocalDate>? _periodStarts;
@override List<LocalDate>? get periodStarts {
  final value = _periodStarts;
  if (value == null) return null;
  if (_periodStarts is EqualUnmodifiableListView) return _periodStarts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Last failure of an action, shown once by the UI.
@override final  Failure? failure;

/// Create a copy of AccountDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountDetailStateCopyWith<_AccountDetailState> get copyWith => __$AccountDetailStateCopyWithImpl<_AccountDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountDetailState&&(identical(other.status, status) || other.status == status)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.today, today) || other.today == today)&&const DeepCollectionEquality().equals(other.accounts, _accounts)&&const DeepCollectionEquality().equals(other.balances, _balances)&&const DeepCollectionEquality().equals(other.currencies, _currencies)&&const DeepCollectionEquality().equals(other.movements, _movements)&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.payees, _payees)&&(identical(other.settings, settings) || other.settings == settings)&&const DeepCollectionEquality().equals(other.periodStarts, _periodStarts)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,accountId,today,const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_balances),const DeepCollectionEquality().hash(_currencies),const DeepCollectionEquality().hash(_movements),const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_payees),settings,const DeepCollectionEquality().hash(_periodStarts),failure);
}

@override
String toString() {
    return 'AccountDetailState(status: $status, accountId: $accountId, today: $today, accounts: $accounts, balances: $balances, currencies: $currencies, movements: $movements, categories: $categories, payees: $payees, settings: $settings, periodStarts: $periodStarts, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$AccountDetailStateCopyWith<$Res> implements $AccountDetailStateCopyWith<$Res> {
  factory _$AccountDetailStateCopyWith(_AccountDetailState value, $Res Function(_AccountDetailState) _then) = __$AccountDetailStateCopyWithImpl;
@override @useResult
$Res call({
 AccountDetailStatus status, int? accountId, LocalDate? today, List<Account>? accounts, Map<int, int>? balances, List<Currency> currencies, List<Movement>? movements, List<Category>? categories, List<Payee>? payees, AppSettings? settings, List<LocalDate>? periodStarts, Failure? failure
});


@override $AppSettingsCopyWith<$Res>? get settings;

}
/// @nodoc
class __$AccountDetailStateCopyWithImpl<$Res>
    implements _$AccountDetailStateCopyWith<$Res> {
  __$AccountDetailStateCopyWithImpl(this._self, this._then);

  final _AccountDetailState _self;
  final $Res Function(_AccountDetailState) _then;

/// Create a copy of AccountDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? accountId = freezed,Object? today = freezed,Object? accounts = freezed,Object? balances = freezed,Object? currencies = null,Object? movements = freezed,Object? categories = freezed,Object? payees = freezed,Object? settings = freezed,Object? periodStarts = freezed,Object? failure = freezed,}) {
  return _then(_AccountDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AccountDetailStatus,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,today: freezed == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as LocalDate?,accounts: freezed == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>?,balances: freezed == balances ? _self._balances : balances // ignore: cast_nullable_to_non_nullable
as Map<int, int>?,currencies: null == currencies ? _self._currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,movements: freezed == movements ? _self._movements : movements // ignore: cast_nullable_to_non_nullable
as List<Movement>?,categories: freezed == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>?,payees: freezed == payees ? _self._payees : payees // ignore: cast_nullable_to_non_nullable
as List<Payee>?,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as AppSettings?,periodStarts: freezed == periodStarts ? _self._periodStarts : periodStarts // ignore: cast_nullable_to_non_nullable
as List<LocalDate>?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of AccountDetailState
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
