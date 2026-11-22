// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecurringState {

 RecurringStatus get status;/// Every stream's latest value; `null` until it arrives.
 List<RecurringTemplate>? get templates; List<Account>? get accounts; List<Category>? get categories; List<Payee>? get payees; List<Currency> get currencies;/// Last failure of an action, shown once by the UI.
 Failure? get failure;
/// Create a copy of RecurringState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringStateCopyWith<RecurringState> get copyWith => _$RecurringStateCopyWithImpl<RecurringState>(this as RecurringState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RecurringState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.templates, _this.templates)&&const DeepCollectionEquality().equals(other.accounts, _this.accounts)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.payees, _this.payees)&&const DeepCollectionEquality().equals(other.currencies, _this.currencies)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as RecurringState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.templates),const DeepCollectionEquality().hash(_this.accounts),const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.payees),const DeepCollectionEquality().hash(_this.currencies),_this.failure);
}

@override
String toString() {
  final _this = this as RecurringState;
  return 'RecurringState(status: ${_this.status}, templates: ${_this.templates}, accounts: ${_this.accounts}, categories: ${_this.categories}, payees: ${_this.payees}, currencies: ${_this.currencies}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $RecurringStateCopyWith<$Res>  {
  factory $RecurringStateCopyWith(RecurringState value, $Res Function(RecurringState) _then) = _$RecurringStateCopyWithImpl;
@useResult
$Res call({
 RecurringStatus status, List<RecurringTemplate>? templates, List<Account>? accounts, List<Category>? categories, List<Payee>? payees, List<Currency> currencies, Failure? failure
});




}
/// @nodoc
class _$RecurringStateCopyWithImpl<$Res>
    implements $RecurringStateCopyWith<$Res> {
  _$RecurringStateCopyWithImpl(this._self, this._then);

  final RecurringState _self;
  final $Res Function(RecurringState) _then;

/// Create a copy of RecurringState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? templates = freezed,Object? accounts = freezed,Object? categories = freezed,Object? payees = freezed,Object? currencies = null,Object? failure = freezed,}) {
  return _then(RecurringState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecurringStatus,templates: freezed == templates ? _self.templates : templates // ignore: cast_nullable_to_non_nullable
as List<RecurringTemplate>?,accounts: freezed == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>?,categories: freezed == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>?,payees: freezed == payees ? _self.payees : payees // ignore: cast_nullable_to_non_nullable
as List<Payee>?,currencies: null == currencies ? _self.currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecurringState].
extension RecurringStatePatterns on RecurringState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurringState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurringState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurringState value)  $default,){
final _that = this;
switch (_that) {
case _RecurringState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurringState value)?  $default,){
final _that = this;
switch (_that) {
case _RecurringState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RecurringStatus status,  List<RecurringTemplate>? templates,  List<Account>? accounts,  List<Category>? categories,  List<Payee>? payees,  List<Currency> currencies,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurringState() when $default != null:
return $default(_that.status,_that.templates,_that.accounts,_that.categories,_that.payees,_that.currencies,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RecurringStatus status,  List<RecurringTemplate>? templates,  List<Account>? accounts,  List<Category>? categories,  List<Payee>? payees,  List<Currency> currencies,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _RecurringState():
return $default(_that.status,_that.templates,_that.accounts,_that.categories,_that.payees,_that.currencies,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RecurringStatus status,  List<RecurringTemplate>? templates,  List<Account>? accounts,  List<Category>? categories,  List<Payee>? payees,  List<Currency> currencies,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _RecurringState() when $default != null:
return $default(_that.status,_that.templates,_that.accounts,_that.categories,_that.payees,_that.currencies,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _RecurringState extends RecurringState {
  const _RecurringState({this.status = RecurringStatus.loading,  List<RecurringTemplate>? templates,  List<Account>? accounts,  List<Category>? categories,  List<Payee>? payees,  List<Currency> currencies = const <Currency>[], this.failure}): _templates = templates,_accounts = accounts,_categories = categories,_payees = payees,_currencies = currencies,super._();
  

@override@JsonKey() final  RecurringStatus status;
/// Every stream's latest value; `null` until it arrives.
 final  List<RecurringTemplate>? _templates;
/// Every stream's latest value; `null` until it arrives.
@override List<RecurringTemplate>? get templates {
  final value = _templates;
  if (value == null) return null;
  if (_templates is EqualUnmodifiableListView) return _templates;
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

 final  List<Currency> _currencies;
@override@JsonKey() List<Currency> get currencies {
  if (_currencies is EqualUnmodifiableListView) return _currencies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currencies);
}

/// Last failure of an action, shown once by the UI.
@override final  Failure? failure;

/// Create a copy of RecurringState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurringStateCopyWith<_RecurringState> get copyWith => __$RecurringStateCopyWithImpl<_RecurringState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurringState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.templates, _templates)&&const DeepCollectionEquality().equals(other.accounts, _accounts)&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.payees, _payees)&&const DeepCollectionEquality().equals(other.currencies, _currencies)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_templates),const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_payees),const DeepCollectionEquality().hash(_currencies),failure);
}

@override
String toString() {
    return 'RecurringState(status: $status, templates: $templates, accounts: $accounts, categories: $categories, payees: $payees, currencies: $currencies, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$RecurringStateCopyWith<$Res> implements $RecurringStateCopyWith<$Res> {
  factory _$RecurringStateCopyWith(_RecurringState value, $Res Function(_RecurringState) _then) = __$RecurringStateCopyWithImpl;
@override @useResult
$Res call({
 RecurringStatus status, List<RecurringTemplate>? templates, List<Account>? accounts, List<Category>? categories, List<Payee>? payees, List<Currency> currencies, Failure? failure
});




}
/// @nodoc
class __$RecurringStateCopyWithImpl<$Res>
    implements _$RecurringStateCopyWith<$Res> {
  __$RecurringStateCopyWithImpl(this._self, this._then);

  final _RecurringState _self;
  final $Res Function(_RecurringState) _then;

/// Create a copy of RecurringState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? templates = freezed,Object? accounts = freezed,Object? categories = freezed,Object? payees = freezed,Object? currencies = null,Object? failure = freezed,}) {
  return _then(_RecurringState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecurringStatus,templates: freezed == templates ? _self._templates : templates // ignore: cast_nullable_to_non_nullable
as List<RecurringTemplate>?,accounts: freezed == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>?,categories: freezed == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>?,payees: freezed == payees ? _self._payees : payees // ignore: cast_nullable_to_non_nullable
as List<Payee>?,currencies: null == currencies ? _self._currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
