// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movement_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MovementFormState {

 MovementFormStatus get status;/// The stored movement when editing; `null` when creating.
 Movement? get original; MovementType get type; int? get categoryId; int? get accountId; AmountInput get amount;/// A prefilled amount is replaced by the first digit typed.
 bool get amountSelected; String? get payeeName; String get note; LocalDate? get date; bool get startsPeriod;/// Whether the user set "Starts period"; then the date no longer
/// changes it.
 bool get startsPeriodTouched;/// A pending movement shows "Confirm" instead of "Save" (RF-06).
 bool get isPending; List<Account> get accounts; List<Category> get categories; List<Currency> get currencies; List<Payee> get payees;/// Every debt with its status, and the pillars a new debt can take.
 List<DebtWithStatus> get debts; List<Pillar> get pillars;/// The debt picked; `null` with [newDebt] or before picking.
 int? get debtId;/// The movement creates its debt (RF-09).
 bool get newDebt;/// Whether the user picked the debt; then the payee no longer does.
 bool get debtTouched;/// Pillar of the debt a loan received creates.
 int? get debtPillarId;/// What a loan received leaves pending; the amount when empty.
 String get debtPendingText; Set<MovementError> get errors; bool get showErrors;/// Last failure of a save or delete, shown once by the UI.
 Failure? get failure;
/// Create a copy of MovementFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovementFormStateCopyWith<MovementFormState> get copyWith => _$MovementFormStateCopyWithImpl<MovementFormState>(this as MovementFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MovementFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovementFormState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.original, _this.original) || other.original == _this.original)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.amountSelected, _this.amountSelected) || other.amountSelected == _this.amountSelected)&&(identical(other.payeeName, _this.payeeName) || other.payeeName == _this.payeeName)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.startsPeriod, _this.startsPeriod) || other.startsPeriod == _this.startsPeriod)&&(identical(other.startsPeriodTouched, _this.startsPeriodTouched) || other.startsPeriodTouched == _this.startsPeriodTouched)&&(identical(other.isPending, _this.isPending) || other.isPending == _this.isPending)&&const DeepCollectionEquality().equals(other.accounts, _this.accounts)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.currencies, _this.currencies)&&const DeepCollectionEquality().equals(other.payees, _this.payees)&&const DeepCollectionEquality().equals(other.debts, _this.debts)&&const DeepCollectionEquality().equals(other.pillars, _this.pillars)&&(identical(other.debtId, _this.debtId) || other.debtId == _this.debtId)&&(identical(other.newDebt, _this.newDebt) || other.newDebt == _this.newDebt)&&(identical(other.debtTouched, _this.debtTouched) || other.debtTouched == _this.debtTouched)&&(identical(other.debtPillarId, _this.debtPillarId) || other.debtPillarId == _this.debtPillarId)&&(identical(other.debtPendingText, _this.debtPendingText) || other.debtPendingText == _this.debtPendingText)&&const DeepCollectionEquality().equals(other.errors, _this.errors)&&(identical(other.showErrors, _this.showErrors) || other.showErrors == _this.showErrors)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as MovementFormState;
  return Object.hashAll([runtimeType,_this.status,_this.original,_this.type,_this.categoryId,_this.accountId,_this.amount,_this.amountSelected,_this.payeeName,_this.note,_this.date,_this.startsPeriod,_this.startsPeriodTouched,_this.isPending,const DeepCollectionEquality().hash(_this.accounts),const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.currencies),const DeepCollectionEquality().hash(_this.payees),const DeepCollectionEquality().hash(_this.debts),const DeepCollectionEquality().hash(_this.pillars),_this.debtId,_this.newDebt,_this.debtTouched,_this.debtPillarId,_this.debtPendingText,const DeepCollectionEquality().hash(_this.errors),_this.showErrors,_this.failure]);
}

@override
String toString() {
  final _this = this as MovementFormState;
  return 'MovementFormState(status: ${_this.status}, original: ${_this.original}, type: ${_this.type}, categoryId: ${_this.categoryId}, accountId: ${_this.accountId}, amount: ${_this.amount}, amountSelected: ${_this.amountSelected}, payeeName: ${_this.payeeName}, note: ${_this.note}, date: ${_this.date}, startsPeriod: ${_this.startsPeriod}, startsPeriodTouched: ${_this.startsPeriodTouched}, isPending: ${_this.isPending}, accounts: ${_this.accounts}, categories: ${_this.categories}, currencies: ${_this.currencies}, payees: ${_this.payees}, debts: ${_this.debts}, pillars: ${_this.pillars}, debtId: ${_this.debtId}, newDebt: ${_this.newDebt}, debtTouched: ${_this.debtTouched}, debtPillarId: ${_this.debtPillarId}, debtPendingText: ${_this.debtPendingText}, errors: ${_this.errors}, showErrors: ${_this.showErrors}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $MovementFormStateCopyWith<$Res>  {
  factory $MovementFormStateCopyWith(MovementFormState value, $Res Function(MovementFormState) _then) = _$MovementFormStateCopyWithImpl;
@useResult
$Res call({
 MovementFormStatus status, Movement? original, MovementType type, int? categoryId, int? accountId, AmountInput amount, bool amountSelected, String? payeeName, String note, LocalDate? date, bool startsPeriod, bool startsPeriodTouched, bool isPending, List<Account> accounts, List<Category> categories, List<Currency> currencies, List<Payee> payees, List<DebtWithStatus> debts, List<Pillar> pillars, int? debtId, bool newDebt, bool debtTouched, int? debtPillarId, String debtPendingText, Set<MovementError> errors, bool showErrors, Failure? failure
});


$MovementCopyWith<$Res>? get original;

}
/// @nodoc
class _$MovementFormStateCopyWithImpl<$Res>
    implements $MovementFormStateCopyWith<$Res> {
  _$MovementFormStateCopyWithImpl(this._self, this._then);

  final MovementFormState _self;
  final $Res Function(MovementFormState) _then;

/// Create a copy of MovementFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? original = freezed,Object? type = null,Object? categoryId = freezed,Object? accountId = freezed,Object? amount = null,Object? amountSelected = null,Object? payeeName = freezed,Object? note = null,Object? date = freezed,Object? startsPeriod = null,Object? startsPeriodTouched = null,Object? isPending = null,Object? accounts = null,Object? categories = null,Object? currencies = null,Object? payees = null,Object? debts = null,Object? pillars = null,Object? debtId = freezed,Object? newDebt = null,Object? debtTouched = null,Object? debtPillarId = freezed,Object? debtPendingText = null,Object? errors = null,Object? showErrors = null,Object? failure = freezed,}) {
  return _then(MovementFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MovementFormStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Movement?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MovementType,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as AmountInput,amountSelected: null == amountSelected ? _self.amountSelected : amountSelected // ignore: cast_nullable_to_non_nullable
as bool,payeeName: freezed == payeeName ? _self.payeeName : payeeName // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as LocalDate?,startsPeriod: null == startsPeriod ? _self.startsPeriod : startsPeriod // ignore: cast_nullable_to_non_nullable
as bool,startsPeriodTouched: null == startsPeriodTouched ? _self.startsPeriodTouched : startsPeriodTouched // ignore: cast_nullable_to_non_nullable
as bool,isPending: null == isPending ? _self.isPending : isPending // ignore: cast_nullable_to_non_nullable
as bool,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,currencies: null == currencies ? _self.currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,payees: null == payees ? _self.payees : payees // ignore: cast_nullable_to_non_nullable
as List<Payee>,debts: null == debts ? _self.debts : debts // ignore: cast_nullable_to_non_nullable
as List<DebtWithStatus>,pillars: null == pillars ? _self.pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<Pillar>,debtId: freezed == debtId ? _self.debtId : debtId // ignore: cast_nullable_to_non_nullable
as int?,newDebt: null == newDebt ? _self.newDebt : newDebt // ignore: cast_nullable_to_non_nullable
as bool,debtTouched: null == debtTouched ? _self.debtTouched : debtTouched // ignore: cast_nullable_to_non_nullable
as bool,debtPillarId: freezed == debtPillarId ? _self.debtPillarId : debtPillarId // ignore: cast_nullable_to_non_nullable
as int?,debtPendingText: null == debtPendingText ? _self.debtPendingText : debtPendingText // ignore: cast_nullable_to_non_nullable
as String,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as Set<MovementError>,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of MovementFormState
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


/// Adds pattern-matching-related methods to [MovementFormState].
extension MovementFormStatePatterns on MovementFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MovementFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MovementFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MovementFormState value)  $default,){
final _that = this;
switch (_that) {
case _MovementFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MovementFormState value)?  $default,){
final _that = this;
switch (_that) {
case _MovementFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MovementFormStatus status,  Movement? original,  MovementType type,  int? categoryId,  int? accountId,  AmountInput amount,  bool amountSelected,  String? payeeName,  String note,  LocalDate? date,  bool startsPeriod,  bool startsPeriodTouched,  bool isPending,  List<Account> accounts,  List<Category> categories,  List<Currency> currencies,  List<Payee> payees,  List<DebtWithStatus> debts,  List<Pillar> pillars,  int? debtId,  bool newDebt,  bool debtTouched,  int? debtPillarId,  String debtPendingText,  Set<MovementError> errors,  bool showErrors,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MovementFormState() when $default != null:
return $default(_that.status,_that.original,_that.type,_that.categoryId,_that.accountId,_that.amount,_that.amountSelected,_that.payeeName,_that.note,_that.date,_that.startsPeriod,_that.startsPeriodTouched,_that.isPending,_that.accounts,_that.categories,_that.currencies,_that.payees,_that.debts,_that.pillars,_that.debtId,_that.newDebt,_that.debtTouched,_that.debtPillarId,_that.debtPendingText,_that.errors,_that.showErrors,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MovementFormStatus status,  Movement? original,  MovementType type,  int? categoryId,  int? accountId,  AmountInput amount,  bool amountSelected,  String? payeeName,  String note,  LocalDate? date,  bool startsPeriod,  bool startsPeriodTouched,  bool isPending,  List<Account> accounts,  List<Category> categories,  List<Currency> currencies,  List<Payee> payees,  List<DebtWithStatus> debts,  List<Pillar> pillars,  int? debtId,  bool newDebt,  bool debtTouched,  int? debtPillarId,  String debtPendingText,  Set<MovementError> errors,  bool showErrors,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _MovementFormState():
return $default(_that.status,_that.original,_that.type,_that.categoryId,_that.accountId,_that.amount,_that.amountSelected,_that.payeeName,_that.note,_that.date,_that.startsPeriod,_that.startsPeriodTouched,_that.isPending,_that.accounts,_that.categories,_that.currencies,_that.payees,_that.debts,_that.pillars,_that.debtId,_that.newDebt,_that.debtTouched,_that.debtPillarId,_that.debtPendingText,_that.errors,_that.showErrors,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MovementFormStatus status,  Movement? original,  MovementType type,  int? categoryId,  int? accountId,  AmountInput amount,  bool amountSelected,  String? payeeName,  String note,  LocalDate? date,  bool startsPeriod,  bool startsPeriodTouched,  bool isPending,  List<Account> accounts,  List<Category> categories,  List<Currency> currencies,  List<Payee> payees,  List<DebtWithStatus> debts,  List<Pillar> pillars,  int? debtId,  bool newDebt,  bool debtTouched,  int? debtPillarId,  String debtPendingText,  Set<MovementError> errors,  bool showErrors,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _MovementFormState() when $default != null:
return $default(_that.status,_that.original,_that.type,_that.categoryId,_that.accountId,_that.amount,_that.amountSelected,_that.payeeName,_that.note,_that.date,_that.startsPeriod,_that.startsPeriodTouched,_that.isPending,_that.accounts,_that.categories,_that.currencies,_that.payees,_that.debts,_that.pillars,_that.debtId,_that.newDebt,_that.debtTouched,_that.debtPillarId,_that.debtPendingText,_that.errors,_that.showErrors,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _MovementFormState extends MovementFormState {
  const _MovementFormState({this.status = MovementFormStatus.loading, this.original, this.type = MovementType.expense, this.categoryId, this.accountId, this.amount = const AmountInput(), this.amountSelected = false, this.payeeName, this.note = '', this.date, this.startsPeriod = false, this.startsPeriodTouched = false, this.isPending = false,  List<Account> accounts = const <Account>[],  List<Category> categories = const <Category>[],  List<Currency> currencies = const <Currency>[],  List<Payee> payees = const <Payee>[],  List<DebtWithStatus> debts = const <DebtWithStatus>[],  List<Pillar> pillars = const <Pillar>[], this.debtId, this.newDebt = false, this.debtTouched = false, this.debtPillarId, this.debtPendingText = '',  Set<MovementError> errors = const <MovementError>{}, this.showErrors = false, this.failure}): _accounts = accounts,_categories = categories,_currencies = currencies,_payees = payees,_debts = debts,_pillars = pillars,_errors = errors,super._();
  

@override@JsonKey() final  MovementFormStatus status;
/// The stored movement when editing; `null` when creating.
@override final  Movement? original;
@override@JsonKey() final  MovementType type;
@override final  int? categoryId;
@override final  int? accountId;
@override@JsonKey() final  AmountInput amount;
/// A prefilled amount is replaced by the first digit typed.
@override@JsonKey() final  bool amountSelected;
@override final  String? payeeName;
@override@JsonKey() final  String note;
@override final  LocalDate? date;
@override@JsonKey() final  bool startsPeriod;
/// Whether the user set "Starts period"; then the date no longer
/// changes it.
@override@JsonKey() final  bool startsPeriodTouched;
/// A pending movement shows "Confirm" instead of "Save" (RF-06).
@override@JsonKey() final  bool isPending;
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

/// Every debt with its status, and the pillars a new debt can take.
 final  List<DebtWithStatus> _debts;
/// Every debt with its status, and the pillars a new debt can take.
@override@JsonKey() List<DebtWithStatus> get debts {
  if (_debts is EqualUnmodifiableListView) return _debts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_debts);
}

 final  List<Pillar> _pillars;
@override@JsonKey() List<Pillar> get pillars {
  if (_pillars is EqualUnmodifiableListView) return _pillars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pillars);
}

/// The debt picked; `null` with [newDebt] or before picking.
@override final  int? debtId;
/// The movement creates its debt (RF-09).
@override@JsonKey() final  bool newDebt;
/// Whether the user picked the debt; then the payee no longer does.
@override@JsonKey() final  bool debtTouched;
/// Pillar of the debt a loan received creates.
@override final  int? debtPillarId;
/// What a loan received leaves pending; the amount when empty.
@override@JsonKey() final  String debtPendingText;
 final  Set<MovementError> _errors;
@override@JsonKey() Set<MovementError> get errors {
  if (_errors is EqualUnmodifiableSetView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_errors);
}

@override@JsonKey() final  bool showErrors;
/// Last failure of a save or delete, shown once by the UI.
@override final  Failure? failure;

/// Create a copy of MovementFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovementFormStateCopyWith<_MovementFormState> get copyWith => __$MovementFormStateCopyWithImpl<_MovementFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MovementFormState&&(identical(other.status, status) || other.status == status)&&(identical(other.original, original) || other.original == original)&&(identical(other.type, type) || other.type == type)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.amountSelected, amountSelected) || other.amountSelected == amountSelected)&&(identical(other.payeeName, payeeName) || other.payeeName == payeeName)&&(identical(other.note, note) || other.note == note)&&(identical(other.date, date) || other.date == date)&&(identical(other.startsPeriod, startsPeriod) || other.startsPeriod == startsPeriod)&&(identical(other.startsPeriodTouched, startsPeriodTouched) || other.startsPeriodTouched == startsPeriodTouched)&&(identical(other.isPending, isPending) || other.isPending == isPending)&&const DeepCollectionEquality().equals(other.accounts, _accounts)&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.currencies, _currencies)&&const DeepCollectionEquality().equals(other.payees, _payees)&&const DeepCollectionEquality().equals(other.debts, _debts)&&const DeepCollectionEquality().equals(other.pillars, _pillars)&&(identical(other.debtId, debtId) || other.debtId == debtId)&&(identical(other.newDebt, newDebt) || other.newDebt == newDebt)&&(identical(other.debtTouched, debtTouched) || other.debtTouched == debtTouched)&&(identical(other.debtPillarId, debtPillarId) || other.debtPillarId == debtPillarId)&&(identical(other.debtPendingText, debtPendingText) || other.debtPendingText == debtPendingText)&&const DeepCollectionEquality().equals(other.errors, _errors)&&(identical(other.showErrors, showErrors) || other.showErrors == showErrors)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hashAll([runtimeType,status,original,type,categoryId,accountId,amount,amountSelected,payeeName,note,date,startsPeriod,startsPeriodTouched,isPending,const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_currencies),const DeepCollectionEquality().hash(_payees),const DeepCollectionEquality().hash(_debts),const DeepCollectionEquality().hash(_pillars),debtId,newDebt,debtTouched,debtPillarId,debtPendingText,const DeepCollectionEquality().hash(_errors),showErrors,failure]);
}

@override
String toString() {
    return 'MovementFormState(status: $status, original: $original, type: $type, categoryId: $categoryId, accountId: $accountId, amount: $amount, amountSelected: $amountSelected, payeeName: $payeeName, note: $note, date: $date, startsPeriod: $startsPeriod, startsPeriodTouched: $startsPeriodTouched, isPending: $isPending, accounts: $accounts, categories: $categories, currencies: $currencies, payees: $payees, debts: $debts, pillars: $pillars, debtId: $debtId, newDebt: $newDebt, debtTouched: $debtTouched, debtPillarId: $debtPillarId, debtPendingText: $debtPendingText, errors: $errors, showErrors: $showErrors, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$MovementFormStateCopyWith<$Res> implements $MovementFormStateCopyWith<$Res> {
  factory _$MovementFormStateCopyWith(_MovementFormState value, $Res Function(_MovementFormState) _then) = __$MovementFormStateCopyWithImpl;
@override @useResult
$Res call({
 MovementFormStatus status, Movement? original, MovementType type, int? categoryId, int? accountId, AmountInput amount, bool amountSelected, String? payeeName, String note, LocalDate? date, bool startsPeriod, bool startsPeriodTouched, bool isPending, List<Account> accounts, List<Category> categories, List<Currency> currencies, List<Payee> payees, List<DebtWithStatus> debts, List<Pillar> pillars, int? debtId, bool newDebt, bool debtTouched, int? debtPillarId, String debtPendingText, Set<MovementError> errors, bool showErrors, Failure? failure
});


@override $MovementCopyWith<$Res>? get original;

}
/// @nodoc
class __$MovementFormStateCopyWithImpl<$Res>
    implements _$MovementFormStateCopyWith<$Res> {
  __$MovementFormStateCopyWithImpl(this._self, this._then);

  final _MovementFormState _self;
  final $Res Function(_MovementFormState) _then;

/// Create a copy of MovementFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? original = freezed,Object? type = null,Object? categoryId = freezed,Object? accountId = freezed,Object? amount = null,Object? amountSelected = null,Object? payeeName = freezed,Object? note = null,Object? date = freezed,Object? startsPeriod = null,Object? startsPeriodTouched = null,Object? isPending = null,Object? accounts = null,Object? categories = null,Object? currencies = null,Object? payees = null,Object? debts = null,Object? pillars = null,Object? debtId = freezed,Object? newDebt = null,Object? debtTouched = null,Object? debtPillarId = freezed,Object? debtPendingText = null,Object? errors = null,Object? showErrors = null,Object? failure = freezed,}) {
  return _then(_MovementFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MovementFormStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Movement?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MovementType,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as AmountInput,amountSelected: null == amountSelected ? _self.amountSelected : amountSelected // ignore: cast_nullable_to_non_nullable
as bool,payeeName: freezed == payeeName ? _self.payeeName : payeeName // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as LocalDate?,startsPeriod: null == startsPeriod ? _self.startsPeriod : startsPeriod // ignore: cast_nullable_to_non_nullable
as bool,startsPeriodTouched: null == startsPeriodTouched ? _self.startsPeriodTouched : startsPeriodTouched // ignore: cast_nullable_to_non_nullable
as bool,isPending: null == isPending ? _self.isPending : isPending // ignore: cast_nullable_to_non_nullable
as bool,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,currencies: null == currencies ? _self._currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,payees: null == payees ? _self._payees : payees // ignore: cast_nullable_to_non_nullable
as List<Payee>,debts: null == debts ? _self._debts : debts // ignore: cast_nullable_to_non_nullable
as List<DebtWithStatus>,pillars: null == pillars ? _self._pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<Pillar>,debtId: freezed == debtId ? _self.debtId : debtId // ignore: cast_nullable_to_non_nullable
as int?,newDebt: null == newDebt ? _self.newDebt : newDebt // ignore: cast_nullable_to_non_nullable
as bool,debtTouched: null == debtTouched ? _self.debtTouched : debtTouched // ignore: cast_nullable_to_non_nullable
as bool,debtPillarId: freezed == debtPillarId ? _self.debtPillarId : debtPillarId // ignore: cast_nullable_to_non_nullable
as int?,debtPendingText: null == debtPendingText ? _self.debtPendingText : debtPendingText // ignore: cast_nullable_to_non_nullable
as String,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Set<MovementError>,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of MovementFormState
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
