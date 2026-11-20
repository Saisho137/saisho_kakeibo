// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountFormState {

 AccountFormStatus get status;/// The stored account when editing; `null` when creating.
 Account? get original;/// Whether the edited account or one of its pockets has movements: its
/// currency is locked and it cannot be deleted.
 bool get hasMovements;/// Every account, for the parent picker and the delete rule.
 List<Account> get accounts; List<Currency> get currencies; String get name; String get iconKey; int get color;/// Whether the user picked the icon; until then it follows the type.
 bool get iconChosen; AccountType get type; String get currencyCode;/// Opening balance as typed. For credit cards it is the debt, positive.
 String get openingText; LocalDate? get openingDate; bool get includeInBalance; bool get isMain; int? get parentAccountId; String get creditLimitText; int? get paymentDay; Set<AccountError> get errors;/// Errors appear after the first submit, then update while typing.
 bool get showErrors;/// Last failure of a save, archive or delete, shown once by the UI.
 Failure? get failure;
/// Create a copy of AccountFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountFormStateCopyWith<AccountFormState> get copyWith => _$AccountFormStateCopyWithImpl<AccountFormState>(this as AccountFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AccountFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountFormState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.original, _this.original) || other.original == _this.original)&&(identical(other.hasMovements, _this.hasMovements) || other.hasMovements == _this.hasMovements)&&const DeepCollectionEquality().equals(other.accounts, _this.accounts)&&const DeepCollectionEquality().equals(other.currencies, _this.currencies)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.iconKey, _this.iconKey) || other.iconKey == _this.iconKey)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.iconChosen, _this.iconChosen) || other.iconChosen == _this.iconChosen)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.currencyCode, _this.currencyCode) || other.currencyCode == _this.currencyCode)&&(identical(other.openingText, _this.openingText) || other.openingText == _this.openingText)&&(identical(other.openingDate, _this.openingDate) || other.openingDate == _this.openingDate)&&(identical(other.includeInBalance, _this.includeInBalance) || other.includeInBalance == _this.includeInBalance)&&(identical(other.isMain, _this.isMain) || other.isMain == _this.isMain)&&(identical(other.parentAccountId, _this.parentAccountId) || other.parentAccountId == _this.parentAccountId)&&(identical(other.creditLimitText, _this.creditLimitText) || other.creditLimitText == _this.creditLimitText)&&(identical(other.paymentDay, _this.paymentDay) || other.paymentDay == _this.paymentDay)&&const DeepCollectionEquality().equals(other.errors, _this.errors)&&(identical(other.showErrors, _this.showErrors) || other.showErrors == _this.showErrors)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as AccountFormState;
  return Object.hashAll([runtimeType,_this.status,_this.original,_this.hasMovements,const DeepCollectionEquality().hash(_this.accounts),const DeepCollectionEquality().hash(_this.currencies),_this.name,_this.iconKey,_this.color,_this.iconChosen,_this.type,_this.currencyCode,_this.openingText,_this.openingDate,_this.includeInBalance,_this.isMain,_this.parentAccountId,_this.creditLimitText,_this.paymentDay,const DeepCollectionEquality().hash(_this.errors),_this.showErrors,_this.failure]);
}

@override
String toString() {
  final _this = this as AccountFormState;
  return 'AccountFormState(status: ${_this.status}, original: ${_this.original}, hasMovements: ${_this.hasMovements}, accounts: ${_this.accounts}, currencies: ${_this.currencies}, name: ${_this.name}, iconKey: ${_this.iconKey}, color: ${_this.color}, iconChosen: ${_this.iconChosen}, type: ${_this.type}, currencyCode: ${_this.currencyCode}, openingText: ${_this.openingText}, openingDate: ${_this.openingDate}, includeInBalance: ${_this.includeInBalance}, isMain: ${_this.isMain}, parentAccountId: ${_this.parentAccountId}, creditLimitText: ${_this.creditLimitText}, paymentDay: ${_this.paymentDay}, errors: ${_this.errors}, showErrors: ${_this.showErrors}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $AccountFormStateCopyWith<$Res>  {
  factory $AccountFormStateCopyWith(AccountFormState value, $Res Function(AccountFormState) _then) = _$AccountFormStateCopyWithImpl;
@useResult
$Res call({
 AccountFormStatus status, Account? original, bool hasMovements, List<Account> accounts, List<Currency> currencies, String name, String iconKey, int color, bool iconChosen, AccountType type, String currencyCode, String openingText, LocalDate? openingDate, bool includeInBalance, bool isMain, int? parentAccountId, String creditLimitText, int? paymentDay, Set<AccountError> errors, bool showErrors, Failure? failure
});


$AccountCopyWith<$Res>? get original;

}
/// @nodoc
class _$AccountFormStateCopyWithImpl<$Res>
    implements $AccountFormStateCopyWith<$Res> {
  _$AccountFormStateCopyWithImpl(this._self, this._then);

  final AccountFormState _self;
  final $Res Function(AccountFormState) _then;

/// Create a copy of AccountFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? original = freezed,Object? hasMovements = null,Object? accounts = null,Object? currencies = null,Object? name = null,Object? iconKey = null,Object? color = null,Object? iconChosen = null,Object? type = null,Object? currencyCode = null,Object? openingText = null,Object? openingDate = freezed,Object? includeInBalance = null,Object? isMain = null,Object? parentAccountId = freezed,Object? creditLimitText = null,Object? paymentDay = freezed,Object? errors = null,Object? showErrors = null,Object? failure = freezed,}) {
  return _then(AccountFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AccountFormStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Account?,hasMovements: null == hasMovements ? _self.hasMovements : hasMovements // ignore: cast_nullable_to_non_nullable
as bool,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>,currencies: null == currencies ? _self.currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,iconChosen: null == iconChosen ? _self.iconChosen : iconChosen // ignore: cast_nullable_to_non_nullable
as bool,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,openingText: null == openingText ? _self.openingText : openingText // ignore: cast_nullable_to_non_nullable
as String,openingDate: freezed == openingDate ? _self.openingDate : openingDate // ignore: cast_nullable_to_non_nullable
as LocalDate?,includeInBalance: null == includeInBalance ? _self.includeInBalance : includeInBalance // ignore: cast_nullable_to_non_nullable
as bool,isMain: null == isMain ? _self.isMain : isMain // ignore: cast_nullable_to_non_nullable
as bool,parentAccountId: freezed == parentAccountId ? _self.parentAccountId : parentAccountId // ignore: cast_nullable_to_non_nullable
as int?,creditLimitText: null == creditLimitText ? _self.creditLimitText : creditLimitText // ignore: cast_nullable_to_non_nullable
as String,paymentDay: freezed == paymentDay ? _self.paymentDay : paymentDay // ignore: cast_nullable_to_non_nullable
as int?,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as Set<AccountError>,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of AccountFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $AccountCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}


/// Adds pattern-matching-related methods to [AccountFormState].
extension AccountFormStatePatterns on AccountFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountFormState value)  $default,){
final _that = this;
switch (_that) {
case _AccountFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountFormState value)?  $default,){
final _that = this;
switch (_that) {
case _AccountFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AccountFormStatus status,  Account? original,  bool hasMovements,  List<Account> accounts,  List<Currency> currencies,  String name,  String iconKey,  int color,  bool iconChosen,  AccountType type,  String currencyCode,  String openingText,  LocalDate? openingDate,  bool includeInBalance,  bool isMain,  int? parentAccountId,  String creditLimitText,  int? paymentDay,  Set<AccountError> errors,  bool showErrors,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountFormState() when $default != null:
return $default(_that.status,_that.original,_that.hasMovements,_that.accounts,_that.currencies,_that.name,_that.iconKey,_that.color,_that.iconChosen,_that.type,_that.currencyCode,_that.openingText,_that.openingDate,_that.includeInBalance,_that.isMain,_that.parentAccountId,_that.creditLimitText,_that.paymentDay,_that.errors,_that.showErrors,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AccountFormStatus status,  Account? original,  bool hasMovements,  List<Account> accounts,  List<Currency> currencies,  String name,  String iconKey,  int color,  bool iconChosen,  AccountType type,  String currencyCode,  String openingText,  LocalDate? openingDate,  bool includeInBalance,  bool isMain,  int? parentAccountId,  String creditLimitText,  int? paymentDay,  Set<AccountError> errors,  bool showErrors,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _AccountFormState():
return $default(_that.status,_that.original,_that.hasMovements,_that.accounts,_that.currencies,_that.name,_that.iconKey,_that.color,_that.iconChosen,_that.type,_that.currencyCode,_that.openingText,_that.openingDate,_that.includeInBalance,_that.isMain,_that.parentAccountId,_that.creditLimitText,_that.paymentDay,_that.errors,_that.showErrors,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AccountFormStatus status,  Account? original,  bool hasMovements,  List<Account> accounts,  List<Currency> currencies,  String name,  String iconKey,  int color,  bool iconChosen,  AccountType type,  String currencyCode,  String openingText,  LocalDate? openingDate,  bool includeInBalance,  bool isMain,  int? parentAccountId,  String creditLimitText,  int? paymentDay,  Set<AccountError> errors,  bool showErrors,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _AccountFormState() when $default != null:
return $default(_that.status,_that.original,_that.hasMovements,_that.accounts,_that.currencies,_that.name,_that.iconKey,_that.color,_that.iconChosen,_that.type,_that.currencyCode,_that.openingText,_that.openingDate,_that.includeInBalance,_that.isMain,_that.parentAccountId,_that.creditLimitText,_that.paymentDay,_that.errors,_that.showErrors,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _AccountFormState extends AccountFormState {
  const _AccountFormState({this.status = AccountFormStatus.loading, this.original, this.hasMovements = false,  List<Account> accounts = const <Account>[],  List<Currency> currencies = const <Currency>[], this.name = '', this.iconKey = '', this.color = 0, this.iconChosen = false, this.type = AccountType.bank, this.currencyCode = '', this.openingText = '', this.openingDate, this.includeInBalance = false, this.isMain = false, this.parentAccountId, this.creditLimitText = '', this.paymentDay,  Set<AccountError> errors = const <AccountError>{}, this.showErrors = false, this.failure}): _accounts = accounts,_currencies = currencies,_errors = errors,super._();
  

@override@JsonKey() final  AccountFormStatus status;
/// The stored account when editing; `null` when creating.
@override final  Account? original;
/// Whether the edited account or one of its pockets has movements: its
/// currency is locked and it cannot be deleted.
@override@JsonKey() final  bool hasMovements;
/// Every account, for the parent picker and the delete rule.
 final  List<Account> _accounts;
/// Every account, for the parent picker and the delete rule.
@override@JsonKey() List<Account> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}

 final  List<Currency> _currencies;
@override@JsonKey() List<Currency> get currencies {
  if (_currencies is EqualUnmodifiableListView) return _currencies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currencies);
}

@override@JsonKey() final  String name;
@override@JsonKey() final  String iconKey;
@override@JsonKey() final  int color;
/// Whether the user picked the icon; until then it follows the type.
@override@JsonKey() final  bool iconChosen;
@override@JsonKey() final  AccountType type;
@override@JsonKey() final  String currencyCode;
/// Opening balance as typed. For credit cards it is the debt, positive.
@override@JsonKey() final  String openingText;
@override final  LocalDate? openingDate;
@override@JsonKey() final  bool includeInBalance;
@override@JsonKey() final  bool isMain;
@override final  int? parentAccountId;
@override@JsonKey() final  String creditLimitText;
@override final  int? paymentDay;
 final  Set<AccountError> _errors;
@override@JsonKey() Set<AccountError> get errors {
  if (_errors is EqualUnmodifiableSetView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_errors);
}

/// Errors appear after the first submit, then update while typing.
@override@JsonKey() final  bool showErrors;
/// Last failure of a save, archive or delete, shown once by the UI.
@override final  Failure? failure;

/// Create a copy of AccountFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountFormStateCopyWith<_AccountFormState> get copyWith => __$AccountFormStateCopyWithImpl<_AccountFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountFormState&&(identical(other.status, status) || other.status == status)&&(identical(other.original, original) || other.original == original)&&(identical(other.hasMovements, hasMovements) || other.hasMovements == hasMovements)&&const DeepCollectionEquality().equals(other.accounts, _accounts)&&const DeepCollectionEquality().equals(other.currencies, _currencies)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.color, color) || other.color == color)&&(identical(other.iconChosen, iconChosen) || other.iconChosen == iconChosen)&&(identical(other.type, type) || other.type == type)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.openingText, openingText) || other.openingText == openingText)&&(identical(other.openingDate, openingDate) || other.openingDate == openingDate)&&(identical(other.includeInBalance, includeInBalance) || other.includeInBalance == includeInBalance)&&(identical(other.isMain, isMain) || other.isMain == isMain)&&(identical(other.parentAccountId, parentAccountId) || other.parentAccountId == parentAccountId)&&(identical(other.creditLimitText, creditLimitText) || other.creditLimitText == creditLimitText)&&(identical(other.paymentDay, paymentDay) || other.paymentDay == paymentDay)&&const DeepCollectionEquality().equals(other.errors, _errors)&&(identical(other.showErrors, showErrors) || other.showErrors == showErrors)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hashAll([runtimeType,status,original,hasMovements,const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_currencies),name,iconKey,color,iconChosen,type,currencyCode,openingText,openingDate,includeInBalance,isMain,parentAccountId,creditLimitText,paymentDay,const DeepCollectionEquality().hash(_errors),showErrors,failure]);
}

@override
String toString() {
    return 'AccountFormState(status: $status, original: $original, hasMovements: $hasMovements, accounts: $accounts, currencies: $currencies, name: $name, iconKey: $iconKey, color: $color, iconChosen: $iconChosen, type: $type, currencyCode: $currencyCode, openingText: $openingText, openingDate: $openingDate, includeInBalance: $includeInBalance, isMain: $isMain, parentAccountId: $parentAccountId, creditLimitText: $creditLimitText, paymentDay: $paymentDay, errors: $errors, showErrors: $showErrors, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$AccountFormStateCopyWith<$Res> implements $AccountFormStateCopyWith<$Res> {
  factory _$AccountFormStateCopyWith(_AccountFormState value, $Res Function(_AccountFormState) _then) = __$AccountFormStateCopyWithImpl;
@override @useResult
$Res call({
 AccountFormStatus status, Account? original, bool hasMovements, List<Account> accounts, List<Currency> currencies, String name, String iconKey, int color, bool iconChosen, AccountType type, String currencyCode, String openingText, LocalDate? openingDate, bool includeInBalance, bool isMain, int? parentAccountId, String creditLimitText, int? paymentDay, Set<AccountError> errors, bool showErrors, Failure? failure
});


@override $AccountCopyWith<$Res>? get original;

}
/// @nodoc
class __$AccountFormStateCopyWithImpl<$Res>
    implements _$AccountFormStateCopyWith<$Res> {
  __$AccountFormStateCopyWithImpl(this._self, this._then);

  final _AccountFormState _self;
  final $Res Function(_AccountFormState) _then;

/// Create a copy of AccountFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? original = freezed,Object? hasMovements = null,Object? accounts = null,Object? currencies = null,Object? name = null,Object? iconKey = null,Object? color = null,Object? iconChosen = null,Object? type = null,Object? currencyCode = null,Object? openingText = null,Object? openingDate = freezed,Object? includeInBalance = null,Object? isMain = null,Object? parentAccountId = freezed,Object? creditLimitText = null,Object? paymentDay = freezed,Object? errors = null,Object? showErrors = null,Object? failure = freezed,}) {
  return _then(_AccountFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AccountFormStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Account?,hasMovements: null == hasMovements ? _self.hasMovements : hasMovements // ignore: cast_nullable_to_non_nullable
as bool,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>,currencies: null == currencies ? _self._currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,iconChosen: null == iconChosen ? _self.iconChosen : iconChosen // ignore: cast_nullable_to_non_nullable
as bool,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,openingText: null == openingText ? _self.openingText : openingText // ignore: cast_nullable_to_non_nullable
as String,openingDate: freezed == openingDate ? _self.openingDate : openingDate // ignore: cast_nullable_to_non_nullable
as LocalDate?,includeInBalance: null == includeInBalance ? _self.includeInBalance : includeInBalance // ignore: cast_nullable_to_non_nullable
as bool,isMain: null == isMain ? _self.isMain : isMain // ignore: cast_nullable_to_non_nullable
as bool,parentAccountId: freezed == parentAccountId ? _self.parentAccountId : parentAccountId // ignore: cast_nullable_to_non_nullable
as int?,creditLimitText: null == creditLimitText ? _self.creditLimitText : creditLimitText // ignore: cast_nullable_to_non_nullable
as String,paymentDay: freezed == paymentDay ? _self.paymentDay : paymentDay // ignore: cast_nullable_to_non_nullable
as int?,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Set<AccountError>,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of AccountFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $AccountCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}

// dart format on
