// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransferFormState {

 TransferFormStatus get status;/// The stored transfer when editing; `null` when creating.
 Movement? get original; int? get fromAccountId; int? get toAccountId;/// What leaves [fromAccountId].
 AmountInput get amount;/// What arrives at [toAccountId]; only between currencies (RT-05).
 AmountInput get toAmount;/// Whether the keypad types [toAmount].
 bool get editingTo; int? get categoryId;/// Whether the user picked the category; then accounts no longer
/// change it.
 bool get categoryTouched; String get note; LocalDate? get date; List<Account> get accounts; List<Category> get categories; List<Currency> get currencies; Set<MovementError> get errors; bool get showErrors;/// Last failure of a save or delete, shown once by the UI.
 Failure? get failure;
/// Create a copy of TransferFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferFormStateCopyWith<TransferFormState> get copyWith => _$TransferFormStateCopyWithImpl<TransferFormState>(this as TransferFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TransferFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferFormState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.original, _this.original) || other.original == _this.original)&&(identical(other.fromAccountId, _this.fromAccountId) || other.fromAccountId == _this.fromAccountId)&&(identical(other.toAccountId, _this.toAccountId) || other.toAccountId == _this.toAccountId)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.toAmount, _this.toAmount) || other.toAmount == _this.toAmount)&&(identical(other.editingTo, _this.editingTo) || other.editingTo == _this.editingTo)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.categoryTouched, _this.categoryTouched) || other.categoryTouched == _this.categoryTouched)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.date, _this.date) || other.date == _this.date)&&const DeepCollectionEquality().equals(other.accounts, _this.accounts)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.currencies, _this.currencies)&&const DeepCollectionEquality().equals(other.errors, _this.errors)&&(identical(other.showErrors, _this.showErrors) || other.showErrors == _this.showErrors)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as TransferFormState;
  return Object.hash(runtimeType,_this.status,_this.original,_this.fromAccountId,_this.toAccountId,_this.amount,_this.toAmount,_this.editingTo,_this.categoryId,_this.categoryTouched,_this.note,_this.date,const DeepCollectionEquality().hash(_this.accounts),const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.currencies),const DeepCollectionEquality().hash(_this.errors),_this.showErrors,_this.failure);
}

@override
String toString() {
  final _this = this as TransferFormState;
  return 'TransferFormState(status: ${_this.status}, original: ${_this.original}, fromAccountId: ${_this.fromAccountId}, toAccountId: ${_this.toAccountId}, amount: ${_this.amount}, toAmount: ${_this.toAmount}, editingTo: ${_this.editingTo}, categoryId: ${_this.categoryId}, categoryTouched: ${_this.categoryTouched}, note: ${_this.note}, date: ${_this.date}, accounts: ${_this.accounts}, categories: ${_this.categories}, currencies: ${_this.currencies}, errors: ${_this.errors}, showErrors: ${_this.showErrors}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $TransferFormStateCopyWith<$Res>  {
  factory $TransferFormStateCopyWith(TransferFormState value, $Res Function(TransferFormState) _then) = _$TransferFormStateCopyWithImpl;
@useResult
$Res call({
 TransferFormStatus status, Movement? original, int? fromAccountId, int? toAccountId, AmountInput amount, AmountInput toAmount, bool editingTo, int? categoryId, bool categoryTouched, String note, LocalDate? date, List<Account> accounts, List<Category> categories, List<Currency> currencies, Set<MovementError> errors, bool showErrors, Failure? failure
});


$MovementCopyWith<$Res>? get original;

}
/// @nodoc
class _$TransferFormStateCopyWithImpl<$Res>
    implements $TransferFormStateCopyWith<$Res> {
  _$TransferFormStateCopyWithImpl(this._self, this._then);

  final TransferFormState _self;
  final $Res Function(TransferFormState) _then;

/// Create a copy of TransferFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? original = freezed,Object? fromAccountId = freezed,Object? toAccountId = freezed,Object? amount = null,Object? toAmount = null,Object? editingTo = null,Object? categoryId = freezed,Object? categoryTouched = null,Object? note = null,Object? date = freezed,Object? accounts = null,Object? categories = null,Object? currencies = null,Object? errors = null,Object? showErrors = null,Object? failure = freezed,}) {
  return _then(TransferFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransferFormStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Movement?,fromAccountId: freezed == fromAccountId ? _self.fromAccountId : fromAccountId // ignore: cast_nullable_to_non_nullable
as int?,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as int?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as AmountInput,toAmount: null == toAmount ? _self.toAmount : toAmount // ignore: cast_nullable_to_non_nullable
as AmountInput,editingTo: null == editingTo ? _self.editingTo : editingTo // ignore: cast_nullable_to_non_nullable
as bool,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,categoryTouched: null == categoryTouched ? _self.categoryTouched : categoryTouched // ignore: cast_nullable_to_non_nullable
as bool,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as LocalDate?,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,currencies: null == currencies ? _self.currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as Set<MovementError>,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of TransferFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MovementCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $MovementCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}


/// Adds pattern-matching-related methods to [TransferFormState].
extension TransferFormStatePatterns on TransferFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferFormState value)  $default,){
final _that = this;
switch (_that) {
case _TransferFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferFormState value)?  $default,){
final _that = this;
switch (_that) {
case _TransferFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TransferFormStatus status,  Movement? original,  int? fromAccountId,  int? toAccountId,  AmountInput amount,  AmountInput toAmount,  bool editingTo,  int? categoryId,  bool categoryTouched,  String note,  LocalDate? date,  List<Account> accounts,  List<Category> categories,  List<Currency> currencies,  Set<MovementError> errors,  bool showErrors,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransferFormState() when $default != null:
return $default(_that.status,_that.original,_that.fromAccountId,_that.toAccountId,_that.amount,_that.toAmount,_that.editingTo,_that.categoryId,_that.categoryTouched,_that.note,_that.date,_that.accounts,_that.categories,_that.currencies,_that.errors,_that.showErrors,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TransferFormStatus status,  Movement? original,  int? fromAccountId,  int? toAccountId,  AmountInput amount,  AmountInput toAmount,  bool editingTo,  int? categoryId,  bool categoryTouched,  String note,  LocalDate? date,  List<Account> accounts,  List<Category> categories,  List<Currency> currencies,  Set<MovementError> errors,  bool showErrors,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _TransferFormState():
return $default(_that.status,_that.original,_that.fromAccountId,_that.toAccountId,_that.amount,_that.toAmount,_that.editingTo,_that.categoryId,_that.categoryTouched,_that.note,_that.date,_that.accounts,_that.categories,_that.currencies,_that.errors,_that.showErrors,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TransferFormStatus status,  Movement? original,  int? fromAccountId,  int? toAccountId,  AmountInput amount,  AmountInput toAmount,  bool editingTo,  int? categoryId,  bool categoryTouched,  String note,  LocalDate? date,  List<Account> accounts,  List<Category> categories,  List<Currency> currencies,  Set<MovementError> errors,  bool showErrors,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _TransferFormState() when $default != null:
return $default(_that.status,_that.original,_that.fromAccountId,_that.toAccountId,_that.amount,_that.toAmount,_that.editingTo,_that.categoryId,_that.categoryTouched,_that.note,_that.date,_that.accounts,_that.categories,_that.currencies,_that.errors,_that.showErrors,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _TransferFormState extends TransferFormState {
  const _TransferFormState({this.status = TransferFormStatus.loading, this.original, this.fromAccountId, this.toAccountId, this.amount = const AmountInput(), this.toAmount = const AmountInput(), this.editingTo = false, this.categoryId, this.categoryTouched = false, this.note = '', this.date,  List<Account> accounts = const <Account>[],  List<Category> categories = const <Category>[],  List<Currency> currencies = const <Currency>[],  Set<MovementError> errors = const <MovementError>{}, this.showErrors = false, this.failure}): _accounts = accounts,_categories = categories,_currencies = currencies,_errors = errors,super._();
  

@override@JsonKey() final  TransferFormStatus status;
/// The stored transfer when editing; `null` when creating.
@override final  Movement? original;
@override final  int? fromAccountId;
@override final  int? toAccountId;
/// What leaves [fromAccountId].
@override@JsonKey() final  AmountInput amount;
/// What arrives at [toAccountId]; only between currencies (RT-05).
@override@JsonKey() final  AmountInput toAmount;
/// Whether the keypad types [toAmount].
@override@JsonKey() final  bool editingTo;
@override final  int? categoryId;
/// Whether the user picked the category; then accounts no longer
/// change it.
@override@JsonKey() final  bool categoryTouched;
@override@JsonKey() final  String note;
@override final  LocalDate? date;
 final  List<Account> _accounts;
@override@JsonKey() List<Account> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}

 final  List<Category> _categories;
@override@JsonKey() List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<Currency> _currencies;
@override@JsonKey() List<Currency> get currencies {
  if (_currencies is EqualUnmodifiableListView) return _currencies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currencies);
}

 final  Set<MovementError> _errors;
@override@JsonKey() Set<MovementError> get errors {
  if (_errors is EqualUnmodifiableSetView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_errors);
}

@override@JsonKey() final  bool showErrors;
/// Last failure of a save or delete, shown once by the UI.
@override final  Failure? failure;

/// Create a copy of TransferFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferFormStateCopyWith<_TransferFormState> get copyWith => __$TransferFormStateCopyWithImpl<_TransferFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferFormState&&(identical(other.status, status) || other.status == status)&&(identical(other.original, original) || other.original == original)&&(identical(other.fromAccountId, fromAccountId) || other.fromAccountId == fromAccountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.toAmount, toAmount) || other.toAmount == toAmount)&&(identical(other.editingTo, editingTo) || other.editingTo == editingTo)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryTouched, categoryTouched) || other.categoryTouched == categoryTouched)&&(identical(other.note, note) || other.note == note)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.accounts, _accounts)&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.currencies, _currencies)&&const DeepCollectionEquality().equals(other.errors, _errors)&&(identical(other.showErrors, showErrors) || other.showErrors == showErrors)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,original,fromAccountId,toAccountId,amount,toAmount,editingTo,categoryId,categoryTouched,note,date,const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_currencies),const DeepCollectionEquality().hash(_errors),showErrors,failure);
}

@override
String toString() {
    return 'TransferFormState(status: $status, original: $original, fromAccountId: $fromAccountId, toAccountId: $toAccountId, amount: $amount, toAmount: $toAmount, editingTo: $editingTo, categoryId: $categoryId, categoryTouched: $categoryTouched, note: $note, date: $date, accounts: $accounts, categories: $categories, currencies: $currencies, errors: $errors, showErrors: $showErrors, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$TransferFormStateCopyWith<$Res> implements $TransferFormStateCopyWith<$Res> {
  factory _$TransferFormStateCopyWith(_TransferFormState value, $Res Function(_TransferFormState) _then) = __$TransferFormStateCopyWithImpl;
@override @useResult
$Res call({
 TransferFormStatus status, Movement? original, int? fromAccountId, int? toAccountId, AmountInput amount, AmountInput toAmount, bool editingTo, int? categoryId, bool categoryTouched, String note, LocalDate? date, List<Account> accounts, List<Category> categories, List<Currency> currencies, Set<MovementError> errors, bool showErrors, Failure? failure
});


@override $MovementCopyWith<$Res>? get original;

}
/// @nodoc
class __$TransferFormStateCopyWithImpl<$Res>
    implements _$TransferFormStateCopyWith<$Res> {
  __$TransferFormStateCopyWithImpl(this._self, this._then);

  final _TransferFormState _self;
  final $Res Function(_TransferFormState) _then;

/// Create a copy of TransferFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? original = freezed,Object? fromAccountId = freezed,Object? toAccountId = freezed,Object? amount = null,Object? toAmount = null,Object? editingTo = null,Object? categoryId = freezed,Object? categoryTouched = null,Object? note = null,Object? date = freezed,Object? accounts = null,Object? categories = null,Object? currencies = null,Object? errors = null,Object? showErrors = null,Object? failure = freezed,}) {
  return _then(_TransferFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransferFormStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Movement?,fromAccountId: freezed == fromAccountId ? _self.fromAccountId : fromAccountId // ignore: cast_nullable_to_non_nullable
as int?,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as int?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as AmountInput,toAmount: null == toAmount ? _self.toAmount : toAmount // ignore: cast_nullable_to_non_nullable
as AmountInput,editingTo: null == editingTo ? _self.editingTo : editingTo // ignore: cast_nullable_to_non_nullable
as bool,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,categoryTouched: null == categoryTouched ? _self.categoryTouched : categoryTouched // ignore: cast_nullable_to_non_nullable
as bool,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as LocalDate?,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,currencies: null == currencies ? _self._currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Set<MovementError>,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of TransferFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MovementCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $MovementCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}

// dart format on
