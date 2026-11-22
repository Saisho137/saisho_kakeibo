// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecurringFormState {

 RecurringFormStatus get status;/// The stored template when editing; `null` when creating.
 RecurringTemplate? get original; MovementType get type; RecurringCadence get cadence; int? get categoryId; int? get accountId; int? get toAccountId; String get amountText;/// What a transfer adds to [toAccountId]; only between currencies.
 String get toAmountText; String? get payeeName; String get note; int? get dueDay; bool get remind; List<Account> get accounts; List<Category> get categories; List<Currency> get currencies; List<Payee> get payees; Set<MovementError> get errors; bool get showErrors;/// Last failure of a save or delete, shown once by the UI.
 Failure? get failure;
/// Create a copy of RecurringFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringFormStateCopyWith<RecurringFormState> get copyWith => _$RecurringFormStateCopyWithImpl<RecurringFormState>(this as RecurringFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RecurringFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringFormState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.original, _this.original) || other.original == _this.original)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.cadence, _this.cadence) || other.cadence == _this.cadence)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.toAccountId, _this.toAccountId) || other.toAccountId == _this.toAccountId)&&(identical(other.amountText, _this.amountText) || other.amountText == _this.amountText)&&(identical(other.toAmountText, _this.toAmountText) || other.toAmountText == _this.toAmountText)&&(identical(other.payeeName, _this.payeeName) || other.payeeName == _this.payeeName)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.dueDay, _this.dueDay) || other.dueDay == _this.dueDay)&&(identical(other.remind, _this.remind) || other.remind == _this.remind)&&const DeepCollectionEquality().equals(other.accounts, _this.accounts)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.currencies, _this.currencies)&&const DeepCollectionEquality().equals(other.payees, _this.payees)&&const DeepCollectionEquality().equals(other.errors, _this.errors)&&(identical(other.showErrors, _this.showErrors) || other.showErrors == _this.showErrors)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as RecurringFormState;
  return Object.hashAll([runtimeType,_this.status,_this.original,_this.type,_this.cadence,_this.categoryId,_this.accountId,_this.toAccountId,_this.amountText,_this.toAmountText,_this.payeeName,_this.note,_this.dueDay,_this.remind,const DeepCollectionEquality().hash(_this.accounts),const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.currencies),const DeepCollectionEquality().hash(_this.payees),const DeepCollectionEquality().hash(_this.errors),_this.showErrors,_this.failure]);
}

@override
String toString() {
  final _this = this as RecurringFormState;
  return 'RecurringFormState(status: ${_this.status}, original: ${_this.original}, type: ${_this.type}, cadence: ${_this.cadence}, categoryId: ${_this.categoryId}, accountId: ${_this.accountId}, toAccountId: ${_this.toAccountId}, amountText: ${_this.amountText}, toAmountText: ${_this.toAmountText}, payeeName: ${_this.payeeName}, note: ${_this.note}, dueDay: ${_this.dueDay}, remind: ${_this.remind}, accounts: ${_this.accounts}, categories: ${_this.categories}, currencies: ${_this.currencies}, payees: ${_this.payees}, errors: ${_this.errors}, showErrors: ${_this.showErrors}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $RecurringFormStateCopyWith<$Res>  {
  factory $RecurringFormStateCopyWith(RecurringFormState value, $Res Function(RecurringFormState) _then) = _$RecurringFormStateCopyWithImpl;
@useResult
$Res call({
 RecurringFormStatus status, RecurringTemplate? original, MovementType type, RecurringCadence cadence, int? categoryId, int? accountId, int? toAccountId, String amountText, String toAmountText, String? payeeName, String note, int? dueDay, bool remind, List<Account> accounts, List<Category> categories, List<Currency> currencies, List<Payee> payees, Set<MovementError> errors, bool showErrors, Failure? failure
});


$RecurringTemplateCopyWith<$Res>? get original;

}
/// @nodoc
class _$RecurringFormStateCopyWithImpl<$Res>
    implements $RecurringFormStateCopyWith<$Res> {
  _$RecurringFormStateCopyWithImpl(this._self, this._then);

  final RecurringFormState _self;
  final $Res Function(RecurringFormState) _then;

/// Create a copy of RecurringFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? original = freezed,Object? type = null,Object? cadence = null,Object? categoryId = freezed,Object? accountId = freezed,Object? toAccountId = freezed,Object? amountText = null,Object? toAmountText = null,Object? payeeName = freezed,Object? note = null,Object? dueDay = freezed,Object? remind = null,Object? accounts = null,Object? categories = null,Object? currencies = null,Object? payees = null,Object? errors = null,Object? showErrors = null,Object? failure = freezed,}) {
  return _then(RecurringFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecurringFormStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as RecurringTemplate?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MovementType,cadence: null == cadence ? _self.cadence : cadence // ignore: cast_nullable_to_non_nullable
as RecurringCadence,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as int?,amountText: null == amountText ? _self.amountText : amountText // ignore: cast_nullable_to_non_nullable
as String,toAmountText: null == toAmountText ? _self.toAmountText : toAmountText // ignore: cast_nullable_to_non_nullable
as String,payeeName: freezed == payeeName ? _self.payeeName : payeeName // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,dueDay: freezed == dueDay ? _self.dueDay : dueDay // ignore: cast_nullable_to_non_nullable
as int?,remind: null == remind ? _self.remind : remind // ignore: cast_nullable_to_non_nullable
as bool,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,currencies: null == currencies ? _self.currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,payees: null == payees ? _self.payees : payees // ignore: cast_nullable_to_non_nullable
as List<Payee>,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as Set<MovementError>,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of RecurringFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecurringTemplateCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $RecurringTemplateCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}


/// Adds pattern-matching-related methods to [RecurringFormState].
extension RecurringFormStatePatterns on RecurringFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurringFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurringFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurringFormState value)  $default,){
final _that = this;
switch (_that) {
case _RecurringFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurringFormState value)?  $default,){
final _that = this;
switch (_that) {
case _RecurringFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RecurringFormStatus status,  RecurringTemplate? original,  MovementType type,  RecurringCadence cadence,  int? categoryId,  int? accountId,  int? toAccountId,  String amountText,  String toAmountText,  String? payeeName,  String note,  int? dueDay,  bool remind,  List<Account> accounts,  List<Category> categories,  List<Currency> currencies,  List<Payee> payees,  Set<MovementError> errors,  bool showErrors,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurringFormState() when $default != null:
return $default(_that.status,_that.original,_that.type,_that.cadence,_that.categoryId,_that.accountId,_that.toAccountId,_that.amountText,_that.toAmountText,_that.payeeName,_that.note,_that.dueDay,_that.remind,_that.accounts,_that.categories,_that.currencies,_that.payees,_that.errors,_that.showErrors,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RecurringFormStatus status,  RecurringTemplate? original,  MovementType type,  RecurringCadence cadence,  int? categoryId,  int? accountId,  int? toAccountId,  String amountText,  String toAmountText,  String? payeeName,  String note,  int? dueDay,  bool remind,  List<Account> accounts,  List<Category> categories,  List<Currency> currencies,  List<Payee> payees,  Set<MovementError> errors,  bool showErrors,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _RecurringFormState():
return $default(_that.status,_that.original,_that.type,_that.cadence,_that.categoryId,_that.accountId,_that.toAccountId,_that.amountText,_that.toAmountText,_that.payeeName,_that.note,_that.dueDay,_that.remind,_that.accounts,_that.categories,_that.currencies,_that.payees,_that.errors,_that.showErrors,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RecurringFormStatus status,  RecurringTemplate? original,  MovementType type,  RecurringCadence cadence,  int? categoryId,  int? accountId,  int? toAccountId,  String amountText,  String toAmountText,  String? payeeName,  String note,  int? dueDay,  bool remind,  List<Account> accounts,  List<Category> categories,  List<Currency> currencies,  List<Payee> payees,  Set<MovementError> errors,  bool showErrors,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _RecurringFormState() when $default != null:
return $default(_that.status,_that.original,_that.type,_that.cadence,_that.categoryId,_that.accountId,_that.toAccountId,_that.amountText,_that.toAmountText,_that.payeeName,_that.note,_that.dueDay,_that.remind,_that.accounts,_that.categories,_that.currencies,_that.payees,_that.errors,_that.showErrors,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _RecurringFormState extends RecurringFormState {
  const _RecurringFormState({this.status = RecurringFormStatus.loading, this.original, this.type = MovementType.expense, this.cadence = RecurringCadence.period, this.categoryId, this.accountId, this.toAccountId, this.amountText = '', this.toAmountText = '', this.payeeName, this.note = '', this.dueDay, this.remind = false,  List<Account> accounts = const <Account>[],  List<Category> categories = const <Category>[],  List<Currency> currencies = const <Currency>[],  List<Payee> payees = const <Payee>[],  Set<MovementError> errors = const <MovementError>{}, this.showErrors = false, this.failure}): _accounts = accounts,_categories = categories,_currencies = currencies,_payees = payees,_errors = errors,super._();
  

@override@JsonKey() final  RecurringFormStatus status;
/// The stored template when editing; `null` when creating.
@override final  RecurringTemplate? original;
@override@JsonKey() final  MovementType type;
@override@JsonKey() final  RecurringCadence cadence;
@override final  int? categoryId;
@override final  int? accountId;
@override final  int? toAccountId;
@override@JsonKey() final  String amountText;
/// What a transfer adds to [toAccountId]; only between currencies.
@override@JsonKey() final  String toAmountText;
@override final  String? payeeName;
@override@JsonKey() final  String note;
@override final  int? dueDay;
@override@JsonKey() final  bool remind;
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

 final  List<Payee> _payees;
@override@JsonKey() List<Payee> get payees {
  if (_payees is EqualUnmodifiableListView) return _payees;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payees);
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

/// Create a copy of RecurringFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurringFormStateCopyWith<_RecurringFormState> get copyWith => __$RecurringFormStateCopyWithImpl<_RecurringFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurringFormState&&(identical(other.status, status) || other.status == status)&&(identical(other.original, original) || other.original == original)&&(identical(other.type, type) || other.type == type)&&(identical(other.cadence, cadence) || other.cadence == cadence)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.amountText, amountText) || other.amountText == amountText)&&(identical(other.toAmountText, toAmountText) || other.toAmountText == toAmountText)&&(identical(other.payeeName, payeeName) || other.payeeName == payeeName)&&(identical(other.note, note) || other.note == note)&&(identical(other.dueDay, dueDay) || other.dueDay == dueDay)&&(identical(other.remind, remind) || other.remind == remind)&&const DeepCollectionEquality().equals(other.accounts, _accounts)&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.currencies, _currencies)&&const DeepCollectionEquality().equals(other.payees, _payees)&&const DeepCollectionEquality().equals(other.errors, _errors)&&(identical(other.showErrors, showErrors) || other.showErrors == showErrors)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hashAll([runtimeType,status,original,type,cadence,categoryId,accountId,toAccountId,amountText,toAmountText,payeeName,note,dueDay,remind,const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_currencies),const DeepCollectionEquality().hash(_payees),const DeepCollectionEquality().hash(_errors),showErrors,failure]);
}

@override
String toString() {
    return 'RecurringFormState(status: $status, original: $original, type: $type, cadence: $cadence, categoryId: $categoryId, accountId: $accountId, toAccountId: $toAccountId, amountText: $amountText, toAmountText: $toAmountText, payeeName: $payeeName, note: $note, dueDay: $dueDay, remind: $remind, accounts: $accounts, categories: $categories, currencies: $currencies, payees: $payees, errors: $errors, showErrors: $showErrors, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$RecurringFormStateCopyWith<$Res> implements $RecurringFormStateCopyWith<$Res> {
  factory _$RecurringFormStateCopyWith(_RecurringFormState value, $Res Function(_RecurringFormState) _then) = __$RecurringFormStateCopyWithImpl;
@override @useResult
$Res call({
 RecurringFormStatus status, RecurringTemplate? original, MovementType type, RecurringCadence cadence, int? categoryId, int? accountId, int? toAccountId, String amountText, String toAmountText, String? payeeName, String note, int? dueDay, bool remind, List<Account> accounts, List<Category> categories, List<Currency> currencies, List<Payee> payees, Set<MovementError> errors, bool showErrors, Failure? failure
});


@override $RecurringTemplateCopyWith<$Res>? get original;

}
/// @nodoc
class __$RecurringFormStateCopyWithImpl<$Res>
    implements _$RecurringFormStateCopyWith<$Res> {
  __$RecurringFormStateCopyWithImpl(this._self, this._then);

  final _RecurringFormState _self;
  final $Res Function(_RecurringFormState) _then;

/// Create a copy of RecurringFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? original = freezed,Object? type = null,Object? cadence = null,Object? categoryId = freezed,Object? accountId = freezed,Object? toAccountId = freezed,Object? amountText = null,Object? toAmountText = null,Object? payeeName = freezed,Object? note = null,Object? dueDay = freezed,Object? remind = null,Object? accounts = null,Object? categories = null,Object? currencies = null,Object? payees = null,Object? errors = null,Object? showErrors = null,Object? failure = freezed,}) {
  return _then(_RecurringFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecurringFormStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as RecurringTemplate?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MovementType,cadence: null == cadence ? _self.cadence : cadence // ignore: cast_nullable_to_non_nullable
as RecurringCadence,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as int?,amountText: null == amountText ? _self.amountText : amountText // ignore: cast_nullable_to_non_nullable
as String,toAmountText: null == toAmountText ? _self.toAmountText : toAmountText // ignore: cast_nullable_to_non_nullable
as String,payeeName: freezed == payeeName ? _self.payeeName : payeeName // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,dueDay: freezed == dueDay ? _self.dueDay : dueDay // ignore: cast_nullable_to_non_nullable
as int?,remind: null == remind ? _self.remind : remind // ignore: cast_nullable_to_non_nullable
as bool,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,currencies: null == currencies ? _self._currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,payees: null == payees ? _self._payees : payees // ignore: cast_nullable_to_non_nullable
as List<Payee>,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Set<MovementError>,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of RecurringFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecurringTemplateCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $RecurringTemplateCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}

// dart format on
