// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payee_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PayeeDetailState {

 PayeeDetailStatus get status; int? get payeeId; LocalDate? get today;/// Every stream's latest value; `null` until it arrives.
 List<Payee>? get payees; List<Movement>? get movements; List<Account>? get accounts; List<Category>? get categories; List<Debt>? get debts; List<LocalDate>? get periodStarts; List<Currency> get currencies; AppSettings? get settings;/// Currency picked on the screen; that of the latest movement until
/// then.
 String? get selectedCurrencyCode;/// Last failure of an action, shown once by the UI.
 Failure? get failure;
/// Create a copy of PayeeDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayeeDetailStateCopyWith<PayeeDetailState> get copyWith => _$PayeeDetailStateCopyWithImpl<PayeeDetailState>(this as PayeeDetailState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PayeeDetailState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayeeDetailState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.payeeId, _this.payeeId) || other.payeeId == _this.payeeId)&&(identical(other.today, _this.today) || other.today == _this.today)&&const DeepCollectionEquality().equals(other.payees, _this.payees)&&const DeepCollectionEquality().equals(other.movements, _this.movements)&&const DeepCollectionEquality().equals(other.accounts, _this.accounts)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.debts, _this.debts)&&const DeepCollectionEquality().equals(other.periodStarts, _this.periodStarts)&&const DeepCollectionEquality().equals(other.currencies, _this.currencies)&&(identical(other.settings, _this.settings) || other.settings == _this.settings)&&(identical(other.selectedCurrencyCode, _this.selectedCurrencyCode) || other.selectedCurrencyCode == _this.selectedCurrencyCode)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as PayeeDetailState;
  return Object.hash(runtimeType,_this.status,_this.payeeId,_this.today,const DeepCollectionEquality().hash(_this.payees),const DeepCollectionEquality().hash(_this.movements),const DeepCollectionEquality().hash(_this.accounts),const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.debts),const DeepCollectionEquality().hash(_this.periodStarts),const DeepCollectionEquality().hash(_this.currencies),_this.settings,_this.selectedCurrencyCode,_this.failure);
}

@override
String toString() {
  final _this = this as PayeeDetailState;
  return 'PayeeDetailState(status: ${_this.status}, payeeId: ${_this.payeeId}, today: ${_this.today}, payees: ${_this.payees}, movements: ${_this.movements}, accounts: ${_this.accounts}, categories: ${_this.categories}, debts: ${_this.debts}, periodStarts: ${_this.periodStarts}, currencies: ${_this.currencies}, settings: ${_this.settings}, selectedCurrencyCode: ${_this.selectedCurrencyCode}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $PayeeDetailStateCopyWith<$Res>  {
  factory $PayeeDetailStateCopyWith(PayeeDetailState value, $Res Function(PayeeDetailState) _then) = _$PayeeDetailStateCopyWithImpl;
@useResult
$Res call({
 PayeeDetailStatus status, int? payeeId, LocalDate? today, List<Payee>? payees, List<Movement>? movements, List<Account>? accounts, List<Category>? categories, List<Debt>? debts, List<LocalDate>? periodStarts, List<Currency> currencies, AppSettings? settings, String? selectedCurrencyCode, Failure? failure
});


$AppSettingsCopyWith<$Res>? get settings;

}
/// @nodoc
class _$PayeeDetailStateCopyWithImpl<$Res>
    implements $PayeeDetailStateCopyWith<$Res> {
  _$PayeeDetailStateCopyWithImpl(this._self, this._then);

  final PayeeDetailState _self;
  final $Res Function(PayeeDetailState) _then;

/// Create a copy of PayeeDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? payeeId = freezed,Object? today = freezed,Object? payees = freezed,Object? movements = freezed,Object? accounts = freezed,Object? categories = freezed,Object? debts = freezed,Object? periodStarts = freezed,Object? currencies = null,Object? settings = freezed,Object? selectedCurrencyCode = freezed,Object? failure = freezed,}) {
  return _then(PayeeDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PayeeDetailStatus,payeeId: freezed == payeeId ? _self.payeeId : payeeId // ignore: cast_nullable_to_non_nullable
as int?,today: freezed == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as LocalDate?,payees: freezed == payees ? _self.payees : payees // ignore: cast_nullable_to_non_nullable
as List<Payee>?,movements: freezed == movements ? _self.movements : movements // ignore: cast_nullable_to_non_nullable
as List<Movement>?,accounts: freezed == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>?,categories: freezed == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>?,debts: freezed == debts ? _self.debts : debts // ignore: cast_nullable_to_non_nullable
as List<Debt>?,periodStarts: freezed == periodStarts ? _self.periodStarts : periodStarts // ignore: cast_nullable_to_non_nullable
as List<LocalDate>?,currencies: null == currencies ? _self.currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as AppSettings?,selectedCurrencyCode: freezed == selectedCurrencyCode ? _self.selectedCurrencyCode : selectedCurrencyCode // ignore: cast_nullable_to_non_nullable
as String?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of PayeeDetailState
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


/// Adds pattern-matching-related methods to [PayeeDetailState].
extension PayeeDetailStatePatterns on PayeeDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PayeeDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PayeeDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PayeeDetailState value)  $default,){
final _that = this;
switch (_that) {
case _PayeeDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PayeeDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _PayeeDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PayeeDetailStatus status,  int? payeeId,  LocalDate? today,  List<Payee>? payees,  List<Movement>? movements,  List<Account>? accounts,  List<Category>? categories,  List<Debt>? debts,  List<LocalDate>? periodStarts,  List<Currency> currencies,  AppSettings? settings,  String? selectedCurrencyCode,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PayeeDetailState() when $default != null:
return $default(_that.status,_that.payeeId,_that.today,_that.payees,_that.movements,_that.accounts,_that.categories,_that.debts,_that.periodStarts,_that.currencies,_that.settings,_that.selectedCurrencyCode,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PayeeDetailStatus status,  int? payeeId,  LocalDate? today,  List<Payee>? payees,  List<Movement>? movements,  List<Account>? accounts,  List<Category>? categories,  List<Debt>? debts,  List<LocalDate>? periodStarts,  List<Currency> currencies,  AppSettings? settings,  String? selectedCurrencyCode,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _PayeeDetailState():
return $default(_that.status,_that.payeeId,_that.today,_that.payees,_that.movements,_that.accounts,_that.categories,_that.debts,_that.periodStarts,_that.currencies,_that.settings,_that.selectedCurrencyCode,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PayeeDetailStatus status,  int? payeeId,  LocalDate? today,  List<Payee>? payees,  List<Movement>? movements,  List<Account>? accounts,  List<Category>? categories,  List<Debt>? debts,  List<LocalDate>? periodStarts,  List<Currency> currencies,  AppSettings? settings,  String? selectedCurrencyCode,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _PayeeDetailState() when $default != null:
return $default(_that.status,_that.payeeId,_that.today,_that.payees,_that.movements,_that.accounts,_that.categories,_that.debts,_that.periodStarts,_that.currencies,_that.settings,_that.selectedCurrencyCode,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _PayeeDetailState extends PayeeDetailState {
  const _PayeeDetailState({this.status = PayeeDetailStatus.loading, this.payeeId, this.today,  List<Payee>? payees,  List<Movement>? movements,  List<Account>? accounts,  List<Category>? categories,  List<Debt>? debts,  List<LocalDate>? periodStarts,  List<Currency> currencies = const <Currency>[], this.settings, this.selectedCurrencyCode, this.failure}): _payees = payees,_movements = movements,_accounts = accounts,_categories = categories,_debts = debts,_periodStarts = periodStarts,_currencies = currencies,super._();
  

@override@JsonKey() final  PayeeDetailStatus status;
@override final  int? payeeId;
@override final  LocalDate? today;
/// Every stream's latest value; `null` until it arrives.
 final  List<Payee>? _payees;
/// Every stream's latest value; `null` until it arrives.
@override List<Payee>? get payees {
  final value = _payees;
  if (value == null) return null;
  if (_payees is EqualUnmodifiableListView) return _payees;
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

 final  List<Category>? _categories;
@override List<Category>? get categories {
  final value = _categories;
  if (value == null) return null;
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Debt>? _debts;
@override List<Debt>? get debts {
  final value = _debts;
  if (value == null) return null;
  if (_debts is EqualUnmodifiableListView) return _debts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<LocalDate>? _periodStarts;
@override List<LocalDate>? get periodStarts {
  final value = _periodStarts;
  if (value == null) return null;
  if (_periodStarts is EqualUnmodifiableListView) return _periodStarts;
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
/// Currency picked on the screen; that of the latest movement until
/// then.
@override final  String? selectedCurrencyCode;
/// Last failure of an action, shown once by the UI.
@override final  Failure? failure;

/// Create a copy of PayeeDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayeeDetailStateCopyWith<_PayeeDetailState> get copyWith => __$PayeeDetailStateCopyWithImpl<_PayeeDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayeeDetailState&&(identical(other.status, status) || other.status == status)&&(identical(other.payeeId, payeeId) || other.payeeId == payeeId)&&(identical(other.today, today) || other.today == today)&&const DeepCollectionEquality().equals(other.payees, _payees)&&const DeepCollectionEquality().equals(other.movements, _movements)&&const DeepCollectionEquality().equals(other.accounts, _accounts)&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.debts, _debts)&&const DeepCollectionEquality().equals(other.periodStarts, _periodStarts)&&const DeepCollectionEquality().equals(other.currencies, _currencies)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.selectedCurrencyCode, selectedCurrencyCode) || other.selectedCurrencyCode == selectedCurrencyCode)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,payeeId,today,const DeepCollectionEquality().hash(_payees),const DeepCollectionEquality().hash(_movements),const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_debts),const DeepCollectionEquality().hash(_periodStarts),const DeepCollectionEquality().hash(_currencies),settings,selectedCurrencyCode,failure);
}

@override
String toString() {
    return 'PayeeDetailState(status: $status, payeeId: $payeeId, today: $today, payees: $payees, movements: $movements, accounts: $accounts, categories: $categories, debts: $debts, periodStarts: $periodStarts, currencies: $currencies, settings: $settings, selectedCurrencyCode: $selectedCurrencyCode, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$PayeeDetailStateCopyWith<$Res> implements $PayeeDetailStateCopyWith<$Res> {
  factory _$PayeeDetailStateCopyWith(_PayeeDetailState value, $Res Function(_PayeeDetailState) _then) = __$PayeeDetailStateCopyWithImpl;
@override @useResult
$Res call({
 PayeeDetailStatus status, int? payeeId, LocalDate? today, List<Payee>? payees, List<Movement>? movements, List<Account>? accounts, List<Category>? categories, List<Debt>? debts, List<LocalDate>? periodStarts, List<Currency> currencies, AppSettings? settings, String? selectedCurrencyCode, Failure? failure
});


@override $AppSettingsCopyWith<$Res>? get settings;

}
/// @nodoc
class __$PayeeDetailStateCopyWithImpl<$Res>
    implements _$PayeeDetailStateCopyWith<$Res> {
  __$PayeeDetailStateCopyWithImpl(this._self, this._then);

  final _PayeeDetailState _self;
  final $Res Function(_PayeeDetailState) _then;

/// Create a copy of PayeeDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? payeeId = freezed,Object? today = freezed,Object? payees = freezed,Object? movements = freezed,Object? accounts = freezed,Object? categories = freezed,Object? debts = freezed,Object? periodStarts = freezed,Object? currencies = null,Object? settings = freezed,Object? selectedCurrencyCode = freezed,Object? failure = freezed,}) {
  return _then(_PayeeDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PayeeDetailStatus,payeeId: freezed == payeeId ? _self.payeeId : payeeId // ignore: cast_nullable_to_non_nullable
as int?,today: freezed == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as LocalDate?,payees: freezed == payees ? _self._payees : payees // ignore: cast_nullable_to_non_nullable
as List<Payee>?,movements: freezed == movements ? _self._movements : movements // ignore: cast_nullable_to_non_nullable
as List<Movement>?,accounts: freezed == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>?,categories: freezed == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>?,debts: freezed == debts ? _self._debts : debts // ignore: cast_nullable_to_non_nullable
as List<Debt>?,periodStarts: freezed == periodStarts ? _self._periodStarts : periodStarts // ignore: cast_nullable_to_non_nullable
as List<LocalDate>?,currencies: null == currencies ? _self._currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as AppSettings?,selectedCurrencyCode: freezed == selectedCurrencyCode ? _self.selectedCurrencyCode : selectedCurrencyCode // ignore: cast_nullable_to_non_nullable
as String?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of PayeeDetailState
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
