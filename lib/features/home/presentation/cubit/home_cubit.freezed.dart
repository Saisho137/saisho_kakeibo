// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {

 HomeStatus get status;/// The day the Home opened; its period is shown first.
 LocalDate? get today;/// Every stream's latest value; `null` until it arrives.
 AppSettings? get settings; List<Account>? get accounts; Map<int, int>? get balances; List<Currency> get currencies; List<Movement>? get movements; List<LocalDate>? get periodStarts; List<Category>? get categories; List<Pillar>? get pillars; List<Payee>? get payees;/// Currency picked in the quick menu; the main one until then.
 String? get selectedCurrencyCode;/// Period swiped to; today's until then.
 Period? get selectedPeriod; Failure? get failure;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HomeState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.today, _this.today) || other.today == _this.today)&&(identical(other.settings, _this.settings) || other.settings == _this.settings)&&const DeepCollectionEquality().equals(other.accounts, _this.accounts)&&const DeepCollectionEquality().equals(other.balances, _this.balances)&&const DeepCollectionEquality().equals(other.currencies, _this.currencies)&&const DeepCollectionEquality().equals(other.movements, _this.movements)&&const DeepCollectionEquality().equals(other.periodStarts, _this.periodStarts)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.pillars, _this.pillars)&&const DeepCollectionEquality().equals(other.payees, _this.payees)&&(identical(other.selectedCurrencyCode, _this.selectedCurrencyCode) || other.selectedCurrencyCode == _this.selectedCurrencyCode)&&(identical(other.selectedPeriod, _this.selectedPeriod) || other.selectedPeriod == _this.selectedPeriod)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as HomeState;
  return Object.hash(runtimeType,_this.status,_this.today,_this.settings,const DeepCollectionEquality().hash(_this.accounts),const DeepCollectionEquality().hash(_this.balances),const DeepCollectionEquality().hash(_this.currencies),const DeepCollectionEquality().hash(_this.movements),const DeepCollectionEquality().hash(_this.periodStarts),const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.pillars),const DeepCollectionEquality().hash(_this.payees),_this.selectedCurrencyCode,_this.selectedPeriod,_this.failure);
}

@override
String toString() {
  final _this = this as HomeState;
  return 'HomeState(status: ${_this.status}, today: ${_this.today}, settings: ${_this.settings}, accounts: ${_this.accounts}, balances: ${_this.balances}, currencies: ${_this.currencies}, movements: ${_this.movements}, periodStarts: ${_this.periodStarts}, categories: ${_this.categories}, pillars: ${_this.pillars}, payees: ${_this.payees}, selectedCurrencyCode: ${_this.selectedCurrencyCode}, selectedPeriod: ${_this.selectedPeriod}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 HomeStatus status, LocalDate? today, AppSettings? settings, List<Account>? accounts, Map<int, int>? balances, List<Currency> currencies, List<Movement>? movements, List<LocalDate>? periodStarts, List<Category>? categories, List<Pillar>? pillars, List<Payee>? payees, String? selectedCurrencyCode, Period? selectedPeriod, Failure? failure
});


$AppSettingsCopyWith<$Res>? get settings;$PeriodCopyWith<$Res>? get selectedPeriod;

}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? today = freezed,Object? settings = freezed,Object? accounts = freezed,Object? balances = freezed,Object? currencies = null,Object? movements = freezed,Object? periodStarts = freezed,Object? categories = freezed,Object? pillars = freezed,Object? payees = freezed,Object? selectedCurrencyCode = freezed,Object? selectedPeriod = freezed,Object? failure = freezed,}) {
  return _then(HomeState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HomeStatus,today: freezed == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as LocalDate?,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as AppSettings?,accounts: freezed == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>?,balances: freezed == balances ? _self.balances : balances // ignore: cast_nullable_to_non_nullable
as Map<int, int>?,currencies: null == currencies ? _self.currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,movements: freezed == movements ? _self.movements : movements // ignore: cast_nullable_to_non_nullable
as List<Movement>?,periodStarts: freezed == periodStarts ? _self.periodStarts : periodStarts // ignore: cast_nullable_to_non_nullable
as List<LocalDate>?,categories: freezed == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>?,pillars: freezed == pillars ? _self.pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<Pillar>?,payees: freezed == payees ? _self.payees : payees // ignore: cast_nullable_to_non_nullable
as List<Payee>?,selectedCurrencyCode: freezed == selectedCurrencyCode ? _self.selectedCurrencyCode : selectedCurrencyCode // ignore: cast_nullable_to_non_nullable
as String?,selectedPeriod: freezed == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as Period?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of HomeState
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
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PeriodCopyWith<$Res>? get selectedPeriod {
    if (_self.selectedPeriod == null) {
    return null;
  }

  return $PeriodCopyWith<$Res>(_self.selectedPeriod!, (value) {
    return _then(_self.copyWith(selectedPeriod: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeState value)  $default,){
final _that = this;
switch (_that) {
case _HomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HomeStatus status,  LocalDate? today,  AppSettings? settings,  List<Account>? accounts,  Map<int, int>? balances,  List<Currency> currencies,  List<Movement>? movements,  List<LocalDate>? periodStarts,  List<Category>? categories,  List<Pillar>? pillars,  List<Payee>? payees,  String? selectedCurrencyCode,  Period? selectedPeriod,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.status,_that.today,_that.settings,_that.accounts,_that.balances,_that.currencies,_that.movements,_that.periodStarts,_that.categories,_that.pillars,_that.payees,_that.selectedCurrencyCode,_that.selectedPeriod,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HomeStatus status,  LocalDate? today,  AppSettings? settings,  List<Account>? accounts,  Map<int, int>? balances,  List<Currency> currencies,  List<Movement>? movements,  List<LocalDate>? periodStarts,  List<Category>? categories,  List<Pillar>? pillars,  List<Payee>? payees,  String? selectedCurrencyCode,  Period? selectedPeriod,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _HomeState():
return $default(_that.status,_that.today,_that.settings,_that.accounts,_that.balances,_that.currencies,_that.movements,_that.periodStarts,_that.categories,_that.pillars,_that.payees,_that.selectedCurrencyCode,_that.selectedPeriod,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HomeStatus status,  LocalDate? today,  AppSettings? settings,  List<Account>? accounts,  Map<int, int>? balances,  List<Currency> currencies,  List<Movement>? movements,  List<LocalDate>? periodStarts,  List<Category>? categories,  List<Pillar>? pillars,  List<Payee>? payees,  String? selectedCurrencyCode,  Period? selectedPeriod,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.status,_that.today,_that.settings,_that.accounts,_that.balances,_that.currencies,_that.movements,_that.periodStarts,_that.categories,_that.pillars,_that.payees,_that.selectedCurrencyCode,_that.selectedPeriod,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _HomeState extends HomeState {
  const _HomeState({this.status = HomeStatus.loading, this.today, this.settings,  List<Account>? accounts,  Map<int, int>? balances,  List<Currency> currencies = const <Currency>[],  List<Movement>? movements,  List<LocalDate>? periodStarts,  List<Category>? categories,  List<Pillar>? pillars,  List<Payee>? payees, this.selectedCurrencyCode, this.selectedPeriod, this.failure}): _accounts = accounts,_balances = balances,_currencies = currencies,_movements = movements,_periodStarts = periodStarts,_categories = categories,_pillars = pillars,_payees = payees,super._();
  

@override@JsonKey() final  HomeStatus status;
/// The day the Home opened; its period is shown first.
@override final  LocalDate? today;
/// Every stream's latest value; `null` until it arrives.
@override final  AppSettings? settings;
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

 final  List<LocalDate>? _periodStarts;
@override List<LocalDate>? get periodStarts {
  final value = _periodStarts;
  if (value == null) return null;
  if (_periodStarts is EqualUnmodifiableListView) return _periodStarts;
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

 final  List<Pillar>? _pillars;
@override List<Pillar>? get pillars {
  final value = _pillars;
  if (value == null) return null;
  if (_pillars is EqualUnmodifiableListView) return _pillars;
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

/// Currency picked in the quick menu; the main one until then.
@override final  String? selectedCurrencyCode;
/// Period swiped to; today's until then.
@override final  Period? selectedPeriod;
@override final  Failure? failure;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&(identical(other.status, status) || other.status == status)&&(identical(other.today, today) || other.today == today)&&(identical(other.settings, settings) || other.settings == settings)&&const DeepCollectionEquality().equals(other.accounts, _accounts)&&const DeepCollectionEquality().equals(other.balances, _balances)&&const DeepCollectionEquality().equals(other.currencies, _currencies)&&const DeepCollectionEquality().equals(other.movements, _movements)&&const DeepCollectionEquality().equals(other.periodStarts, _periodStarts)&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.pillars, _pillars)&&const DeepCollectionEquality().equals(other.payees, _payees)&&(identical(other.selectedCurrencyCode, selectedCurrencyCode) || other.selectedCurrencyCode == selectedCurrencyCode)&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,today,settings,const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_balances),const DeepCollectionEquality().hash(_currencies),const DeepCollectionEquality().hash(_movements),const DeepCollectionEquality().hash(_periodStarts),const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_pillars),const DeepCollectionEquality().hash(_payees),selectedCurrencyCode,selectedPeriod,failure);
}

@override
String toString() {
    return 'HomeState(status: $status, today: $today, settings: $settings, accounts: $accounts, balances: $balances, currencies: $currencies, movements: $movements, periodStarts: $periodStarts, categories: $categories, pillars: $pillars, payees: $payees, selectedCurrencyCode: $selectedCurrencyCode, selectedPeriod: $selectedPeriod, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 HomeStatus status, LocalDate? today, AppSettings? settings, List<Account>? accounts, Map<int, int>? balances, List<Currency> currencies, List<Movement>? movements, List<LocalDate>? periodStarts, List<Category>? categories, List<Pillar>? pillars, List<Payee>? payees, String? selectedCurrencyCode, Period? selectedPeriod, Failure? failure
});


@override $AppSettingsCopyWith<$Res>? get settings;@override $PeriodCopyWith<$Res>? get selectedPeriod;

}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? today = freezed,Object? settings = freezed,Object? accounts = freezed,Object? balances = freezed,Object? currencies = null,Object? movements = freezed,Object? periodStarts = freezed,Object? categories = freezed,Object? pillars = freezed,Object? payees = freezed,Object? selectedCurrencyCode = freezed,Object? selectedPeriod = freezed,Object? failure = freezed,}) {
  return _then(_HomeState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HomeStatus,today: freezed == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as LocalDate?,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as AppSettings?,accounts: freezed == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>?,balances: freezed == balances ? _self._balances : balances // ignore: cast_nullable_to_non_nullable
as Map<int, int>?,currencies: null == currencies ? _self._currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,movements: freezed == movements ? _self._movements : movements // ignore: cast_nullable_to_non_nullable
as List<Movement>?,periodStarts: freezed == periodStarts ? _self._periodStarts : periodStarts // ignore: cast_nullable_to_non_nullable
as List<LocalDate>?,categories: freezed == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>?,pillars: freezed == pillars ? _self._pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<Pillar>?,payees: freezed == payees ? _self._payees : payees // ignore: cast_nullable_to_non_nullable
as List<Payee>?,selectedCurrencyCode: freezed == selectedCurrencyCode ? _self.selectedCurrencyCode : selectedCurrencyCode // ignore: cast_nullable_to_non_nullable
as String?,selectedPeriod: freezed == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as Period?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of HomeState
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
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PeriodCopyWith<$Res>? get selectedPeriod {
    if (_self.selectedPeriod == null) {
    return null;
  }

  return $PeriodCopyWith<$Res>(_self.selectedPeriod!, (value) {
    return _then(_self.copyWith(selectedPeriod: value));
  });
}
}

// dart format on
