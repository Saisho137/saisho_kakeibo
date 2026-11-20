// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Account {

 String get name;/// Key of the icon in the core icon catalog.
 String get iconKey;/// ARGB color of the icon circle.
 int get color; AccountType get type; String get currencyCode;/// Balance in the currency's minor unit when the account was created.
/// Negative for a credit card that already had debt.
 int get openingBalance; LocalDate get openingDate;/// Database id; `0` for an account that is not stored yet.
 int get id;/// Whether the account adds to the main Balance. Pockets copy it from
/// their parent.
 bool get includeInBalance;/// The default bank account. There is always exactly one.
 bool get isMain;/// Parent bank account; only pockets have one.
 int? get parentAccountId;/// Credit card limit in minor units.
 int? get creditLimit;/// Day of the month the credit card is paid, 1–31.
 int? get paymentDay;/// Position inside its group (or among its siblings for pockets).
 int get sortOrder; bool get isArchived;
/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountCopyWith<Account> get copyWith => _$AccountCopyWithImpl<Account>(this as Account, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Account;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Account&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.iconKey, _this.iconKey) || other.iconKey == _this.iconKey)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.currencyCode, _this.currencyCode) || other.currencyCode == _this.currencyCode)&&(identical(other.openingBalance, _this.openingBalance) || other.openingBalance == _this.openingBalance)&&(identical(other.openingDate, _this.openingDate) || other.openingDate == _this.openingDate)&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.includeInBalance, _this.includeInBalance) || other.includeInBalance == _this.includeInBalance)&&(identical(other.isMain, _this.isMain) || other.isMain == _this.isMain)&&(identical(other.parentAccountId, _this.parentAccountId) || other.parentAccountId == _this.parentAccountId)&&(identical(other.creditLimit, _this.creditLimit) || other.creditLimit == _this.creditLimit)&&(identical(other.paymentDay, _this.paymentDay) || other.paymentDay == _this.paymentDay)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder)&&(identical(other.isArchived, _this.isArchived) || other.isArchived == _this.isArchived));
}


@override
int get hashCode {
  final _this = this as Account;
  return Object.hash(runtimeType,_this.name,_this.iconKey,_this.color,_this.type,_this.currencyCode,_this.openingBalance,_this.openingDate,_this.id,_this.includeInBalance,_this.isMain,_this.parentAccountId,_this.creditLimit,_this.paymentDay,_this.sortOrder,_this.isArchived);
}

@override
String toString() {
  final _this = this as Account;
  return 'Account(name: ${_this.name}, iconKey: ${_this.iconKey}, color: ${_this.color}, type: ${_this.type}, currencyCode: ${_this.currencyCode}, openingBalance: ${_this.openingBalance}, openingDate: ${_this.openingDate}, id: ${_this.id}, includeInBalance: ${_this.includeInBalance}, isMain: ${_this.isMain}, parentAccountId: ${_this.parentAccountId}, creditLimit: ${_this.creditLimit}, paymentDay: ${_this.paymentDay}, sortOrder: ${_this.sortOrder}, isArchived: ${_this.isArchived})';
}


}

/// @nodoc
abstract mixin class $AccountCopyWith<$Res>  {
  factory $AccountCopyWith(Account value, $Res Function(Account) _then) = _$AccountCopyWithImpl;
@useResult
$Res call({
 String name, String iconKey, int color, AccountType type, String currencyCode, int openingBalance, LocalDate openingDate, int id, bool includeInBalance, bool isMain, int? parentAccountId, int? creditLimit, int? paymentDay, int sortOrder, bool isArchived
});




}
/// @nodoc
class _$AccountCopyWithImpl<$Res>
    implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._self, this._then);

  final Account _self;
  final $Res Function(Account) _then;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? iconKey = null,Object? color = null,Object? type = null,Object? currencyCode = null,Object? openingBalance = null,Object? openingDate = null,Object? id = null,Object? includeInBalance = null,Object? isMain = null,Object? parentAccountId = freezed,Object? creditLimit = freezed,Object? paymentDay = freezed,Object? sortOrder = null,Object? isArchived = null,}) {
  return _then(Account(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as int,openingDate: null == openingDate ? _self.openingDate : openingDate // ignore: cast_nullable_to_non_nullable
as LocalDate,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,includeInBalance: null == includeInBalance ? _self.includeInBalance : includeInBalance // ignore: cast_nullable_to_non_nullable
as bool,isMain: null == isMain ? _self.isMain : isMain // ignore: cast_nullable_to_non_nullable
as bool,parentAccountId: freezed == parentAccountId ? _self.parentAccountId : parentAccountId // ignore: cast_nullable_to_non_nullable
as int?,creditLimit: freezed == creditLimit ? _self.creditLimit : creditLimit // ignore: cast_nullable_to_non_nullable
as int?,paymentDay: freezed == paymentDay ? _self.paymentDay : paymentDay // ignore: cast_nullable_to_non_nullable
as int?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Account].
extension AccountPatterns on Account {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Account value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Account() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Account value)  $default,){
final _that = this;
switch (_that) {
case _Account():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Account value)?  $default,){
final _that = this;
switch (_that) {
case _Account() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String iconKey,  int color,  AccountType type,  String currencyCode,  int openingBalance,  LocalDate openingDate,  int id,  bool includeInBalance,  bool isMain,  int? parentAccountId,  int? creditLimit,  int? paymentDay,  int sortOrder,  bool isArchived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Account() when $default != null:
return $default(_that.name,_that.iconKey,_that.color,_that.type,_that.currencyCode,_that.openingBalance,_that.openingDate,_that.id,_that.includeInBalance,_that.isMain,_that.parentAccountId,_that.creditLimit,_that.paymentDay,_that.sortOrder,_that.isArchived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String iconKey,  int color,  AccountType type,  String currencyCode,  int openingBalance,  LocalDate openingDate,  int id,  bool includeInBalance,  bool isMain,  int? parentAccountId,  int? creditLimit,  int? paymentDay,  int sortOrder,  bool isArchived)  $default,) {final _that = this;
switch (_that) {
case _Account():
return $default(_that.name,_that.iconKey,_that.color,_that.type,_that.currencyCode,_that.openingBalance,_that.openingDate,_that.id,_that.includeInBalance,_that.isMain,_that.parentAccountId,_that.creditLimit,_that.paymentDay,_that.sortOrder,_that.isArchived);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String iconKey,  int color,  AccountType type,  String currencyCode,  int openingBalance,  LocalDate openingDate,  int id,  bool includeInBalance,  bool isMain,  int? parentAccountId,  int? creditLimit,  int? paymentDay,  int sortOrder,  bool isArchived)?  $default,) {final _that = this;
switch (_that) {
case _Account() when $default != null:
return $default(_that.name,_that.iconKey,_that.color,_that.type,_that.currencyCode,_that.openingBalance,_that.openingDate,_that.id,_that.includeInBalance,_that.isMain,_that.parentAccountId,_that.creditLimit,_that.paymentDay,_that.sortOrder,_that.isArchived);case _:
  return null;

}
}

}

/// @nodoc


class _Account extends Account {
  const _Account({required this.name, required this.iconKey, required this.color, required this.type, required this.currencyCode, required this.openingBalance, required this.openingDate, this.id = 0, this.includeInBalance = false, this.isMain = false, this.parentAccountId, this.creditLimit, this.paymentDay, this.sortOrder = 0, this.isArchived = false}): super._();
  

@override final  String name;
/// Key of the icon in the core icon catalog.
@override final  String iconKey;
/// ARGB color of the icon circle.
@override final  int color;
@override final  AccountType type;
@override final  String currencyCode;
/// Balance in the currency's minor unit when the account was created.
/// Negative for a credit card that already had debt.
@override final  int openingBalance;
@override final  LocalDate openingDate;
/// Database id; `0` for an account that is not stored yet.
@override@JsonKey() final  int id;
/// Whether the account adds to the main Balance. Pockets copy it from
/// their parent.
@override@JsonKey() final  bool includeInBalance;
/// The default bank account. There is always exactly one.
@override@JsonKey() final  bool isMain;
/// Parent bank account; only pockets have one.
@override final  int? parentAccountId;
/// Credit card limit in minor units.
@override final  int? creditLimit;
/// Day of the month the credit card is paid, 1–31.
@override final  int? paymentDay;
/// Position inside its group (or among its siblings for pockets).
@override@JsonKey() final  int sortOrder;
@override@JsonKey() final  bool isArchived;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountCopyWith<_Account> get copyWith => __$AccountCopyWithImpl<_Account>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Account&&(identical(other.name, name) || other.name == name)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.color, color) || other.color == color)&&(identical(other.type, type) || other.type == type)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance)&&(identical(other.openingDate, openingDate) || other.openingDate == openingDate)&&(identical(other.id, id) || other.id == id)&&(identical(other.includeInBalance, includeInBalance) || other.includeInBalance == includeInBalance)&&(identical(other.isMain, isMain) || other.isMain == isMain)&&(identical(other.parentAccountId, parentAccountId) || other.parentAccountId == parentAccountId)&&(identical(other.creditLimit, creditLimit) || other.creditLimit == creditLimit)&&(identical(other.paymentDay, paymentDay) || other.paymentDay == paymentDay)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,iconKey,color,type,currencyCode,openingBalance,openingDate,id,includeInBalance,isMain,parentAccountId,creditLimit,paymentDay,sortOrder,isArchived);
}

@override
String toString() {
    return 'Account(name: $name, iconKey: $iconKey, color: $color, type: $type, currencyCode: $currencyCode, openingBalance: $openingBalance, openingDate: $openingDate, id: $id, includeInBalance: $includeInBalance, isMain: $isMain, parentAccountId: $parentAccountId, creditLimit: $creditLimit, paymentDay: $paymentDay, sortOrder: $sortOrder, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class _$AccountCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$AccountCopyWith(_Account value, $Res Function(_Account) _then) = __$AccountCopyWithImpl;
@override @useResult
$Res call({
 String name, String iconKey, int color, AccountType type, String currencyCode, int openingBalance, LocalDate openingDate, int id, bool includeInBalance, bool isMain, int? parentAccountId, int? creditLimit, int? paymentDay, int sortOrder, bool isArchived
});




}
/// @nodoc
class __$AccountCopyWithImpl<$Res>
    implements _$AccountCopyWith<$Res> {
  __$AccountCopyWithImpl(this._self, this._then);

  final _Account _self;
  final $Res Function(_Account) _then;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? iconKey = null,Object? color = null,Object? type = null,Object? currencyCode = null,Object? openingBalance = null,Object? openingDate = null,Object? id = null,Object? includeInBalance = null,Object? isMain = null,Object? parentAccountId = freezed,Object? creditLimit = freezed,Object? paymentDay = freezed,Object? sortOrder = null,Object? isArchived = null,}) {
  return _then(_Account(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as int,openingDate: null == openingDate ? _self.openingDate : openingDate // ignore: cast_nullable_to_non_nullable
as LocalDate,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,includeInBalance: null == includeInBalance ? _self.includeInBalance : includeInBalance // ignore: cast_nullable_to_non_nullable
as bool,isMain: null == isMain ? _self.isMain : isMain // ignore: cast_nullable_to_non_nullable
as bool,parentAccountId: freezed == parentAccountId ? _self.parentAccountId : parentAccountId // ignore: cast_nullable_to_non_nullable
as int?,creditLimit: freezed == creditLimit ? _self.creditLimit : creditLimit // ignore: cast_nullable_to_non_nullable
as int?,paymentDay: freezed == paymentDay ? _self.paymentDay : paymentDay // ignore: cast_nullable_to_non_nullable
as int?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
