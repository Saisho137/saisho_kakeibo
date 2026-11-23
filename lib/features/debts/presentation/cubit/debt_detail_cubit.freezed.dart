// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debt_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DebtDetailState {

 DebtDetailStatus get status; int? get debtId;/// Every stream's latest value; `null` until it arrives.
 List<Debt>? get debts; List<Movement>? get movements; List<Account>? get accounts; List<Category>? get categories; List<Payee>? get payees; List<Pillar>? get pillars; List<Currency> get currencies;/// Last failure of an action, shown once by the UI.
 Failure? get failure;
/// Create a copy of DebtDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebtDetailStateCopyWith<DebtDetailState> get copyWith => _$DebtDetailStateCopyWithImpl<DebtDetailState>(this as DebtDetailState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DebtDetailState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebtDetailState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.debtId, _this.debtId) || other.debtId == _this.debtId)&&const DeepCollectionEquality().equals(other.debts, _this.debts)&&const DeepCollectionEquality().equals(other.movements, _this.movements)&&const DeepCollectionEquality().equals(other.accounts, _this.accounts)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.payees, _this.payees)&&const DeepCollectionEquality().equals(other.pillars, _this.pillars)&&const DeepCollectionEquality().equals(other.currencies, _this.currencies)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as DebtDetailState;
  return Object.hash(runtimeType,_this.status,_this.debtId,const DeepCollectionEquality().hash(_this.debts),const DeepCollectionEquality().hash(_this.movements),const DeepCollectionEquality().hash(_this.accounts),const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.payees),const DeepCollectionEquality().hash(_this.pillars),const DeepCollectionEquality().hash(_this.currencies),_this.failure);
}

@override
String toString() {
  final _this = this as DebtDetailState;
  return 'DebtDetailState(status: ${_this.status}, debtId: ${_this.debtId}, debts: ${_this.debts}, movements: ${_this.movements}, accounts: ${_this.accounts}, categories: ${_this.categories}, payees: ${_this.payees}, pillars: ${_this.pillars}, currencies: ${_this.currencies}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $DebtDetailStateCopyWith<$Res>  {
  factory $DebtDetailStateCopyWith(DebtDetailState value, $Res Function(DebtDetailState) _then) = _$DebtDetailStateCopyWithImpl;
@useResult
$Res call({
 DebtDetailStatus status, int? debtId, List<Debt>? debts, List<Movement>? movements, List<Account>? accounts, List<Category>? categories, List<Payee>? payees, List<Pillar>? pillars, List<Currency> currencies, Failure? failure
});




}
/// @nodoc
class _$DebtDetailStateCopyWithImpl<$Res>
    implements $DebtDetailStateCopyWith<$Res> {
  _$DebtDetailStateCopyWithImpl(this._self, this._then);

  final DebtDetailState _self;
  final $Res Function(DebtDetailState) _then;

/// Create a copy of DebtDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? debtId = freezed,Object? debts = freezed,Object? movements = freezed,Object? accounts = freezed,Object? categories = freezed,Object? payees = freezed,Object? pillars = freezed,Object? currencies = null,Object? failure = freezed,}) {
  return _then(DebtDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DebtDetailStatus,debtId: freezed == debtId ? _self.debtId : debtId // ignore: cast_nullable_to_non_nullable
as int?,debts: freezed == debts ? _self.debts : debts // ignore: cast_nullable_to_non_nullable
as List<Debt>?,movements: freezed == movements ? _self.movements : movements // ignore: cast_nullable_to_non_nullable
as List<Movement>?,accounts: freezed == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>?,categories: freezed == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>?,payees: freezed == payees ? _self.payees : payees // ignore: cast_nullable_to_non_nullable
as List<Payee>?,pillars: freezed == pillars ? _self.pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<Pillar>?,currencies: null == currencies ? _self.currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// Adds pattern-matching-related methods to [DebtDetailState].
extension DebtDetailStatePatterns on DebtDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebtDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebtDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebtDetailState value)  $default,){
final _that = this;
switch (_that) {
case _DebtDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebtDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _DebtDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DebtDetailStatus status,  int? debtId,  List<Debt>? debts,  List<Movement>? movements,  List<Account>? accounts,  List<Category>? categories,  List<Payee>? payees,  List<Pillar>? pillars,  List<Currency> currencies,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebtDetailState() when $default != null:
return $default(_that.status,_that.debtId,_that.debts,_that.movements,_that.accounts,_that.categories,_that.payees,_that.pillars,_that.currencies,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DebtDetailStatus status,  int? debtId,  List<Debt>? debts,  List<Movement>? movements,  List<Account>? accounts,  List<Category>? categories,  List<Payee>? payees,  List<Pillar>? pillars,  List<Currency> currencies,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _DebtDetailState():
return $default(_that.status,_that.debtId,_that.debts,_that.movements,_that.accounts,_that.categories,_that.payees,_that.pillars,_that.currencies,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DebtDetailStatus status,  int? debtId,  List<Debt>? debts,  List<Movement>? movements,  List<Account>? accounts,  List<Category>? categories,  List<Payee>? payees,  List<Pillar>? pillars,  List<Currency> currencies,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _DebtDetailState() when $default != null:
return $default(_that.status,_that.debtId,_that.debts,_that.movements,_that.accounts,_that.categories,_that.payees,_that.pillars,_that.currencies,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _DebtDetailState extends DebtDetailState {
  const _DebtDetailState({this.status = DebtDetailStatus.loading, this.debtId,  List<Debt>? debts,  List<Movement>? movements,  List<Account>? accounts,  List<Category>? categories,  List<Payee>? payees,  List<Pillar>? pillars,  List<Currency> currencies = const <Currency>[], this.failure}): _debts = debts,_movements = movements,_accounts = accounts,_categories = categories,_payees = payees,_pillars = pillars,_currencies = currencies,super._();
  

@override@JsonKey() final  DebtDetailStatus status;
@override final  int? debtId;
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

/// Last failure of an action, shown once by the UI.
@override final  Failure? failure;

/// Create a copy of DebtDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebtDetailStateCopyWith<_DebtDetailState> get copyWith => __$DebtDetailStateCopyWithImpl<_DebtDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebtDetailState&&(identical(other.status, status) || other.status == status)&&(identical(other.debtId, debtId) || other.debtId == debtId)&&const DeepCollectionEquality().equals(other.debts, _debts)&&const DeepCollectionEquality().equals(other.movements, _movements)&&const DeepCollectionEquality().equals(other.accounts, _accounts)&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.payees, _payees)&&const DeepCollectionEquality().equals(other.pillars, _pillars)&&const DeepCollectionEquality().equals(other.currencies, _currencies)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,debtId,const DeepCollectionEquality().hash(_debts),const DeepCollectionEquality().hash(_movements),const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_payees),const DeepCollectionEquality().hash(_pillars),const DeepCollectionEquality().hash(_currencies),failure);
}

@override
String toString() {
    return 'DebtDetailState(status: $status, debtId: $debtId, debts: $debts, movements: $movements, accounts: $accounts, categories: $categories, payees: $payees, pillars: $pillars, currencies: $currencies, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$DebtDetailStateCopyWith<$Res> implements $DebtDetailStateCopyWith<$Res> {
  factory _$DebtDetailStateCopyWith(_DebtDetailState value, $Res Function(_DebtDetailState) _then) = __$DebtDetailStateCopyWithImpl;
@override @useResult
$Res call({
 DebtDetailStatus status, int? debtId, List<Debt>? debts, List<Movement>? movements, List<Account>? accounts, List<Category>? categories, List<Payee>? payees, List<Pillar>? pillars, List<Currency> currencies, Failure? failure
});




}
/// @nodoc
class __$DebtDetailStateCopyWithImpl<$Res>
    implements _$DebtDetailStateCopyWith<$Res> {
  __$DebtDetailStateCopyWithImpl(this._self, this._then);

  final _DebtDetailState _self;
  final $Res Function(_DebtDetailState) _then;

/// Create a copy of DebtDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? debtId = freezed,Object? debts = freezed,Object? movements = freezed,Object? accounts = freezed,Object? categories = freezed,Object? payees = freezed,Object? pillars = freezed,Object? currencies = null,Object? failure = freezed,}) {
  return _then(_DebtDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DebtDetailStatus,debtId: freezed == debtId ? _self.debtId : debtId // ignore: cast_nullable_to_non_nullable
as int?,debts: freezed == debts ? _self._debts : debts // ignore: cast_nullable_to_non_nullable
as List<Debt>?,movements: freezed == movements ? _self._movements : movements // ignore: cast_nullable_to_non_nullable
as List<Movement>?,accounts: freezed == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>?,categories: freezed == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>?,payees: freezed == payees ? _self._payees : payees // ignore: cast_nullable_to_non_nullable
as List<Payee>?,pillars: freezed == pillars ? _self._pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<Pillar>?,currencies: null == currencies ? _self._currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
