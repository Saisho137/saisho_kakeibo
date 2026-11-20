// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Movement {

 MovementType get type; LocalDate get date;/// The account that receives an income, pays an expense, sends a
/// transfer or is adjusted.
 int get accountId;/// Positive, except for an adjustment: the signed difference.
 int get amount;/// Database id; `0` for a movement that is not stored yet.
 int get id;/// Account that receives a transfer.
 int? get toAccountId;/// What a transfer adds to [toAccountId]; it differs from [amount] only
/// between currencies.
 int? get toAmount;/// Required for incomes, expenses and transfers.
 int? get categoryId;/// Only incomes and expenses have one.
 int? get payeeId; String? get note;/// Debt the movement creates or pays (phase 8).
 int? get debtId;/// Template a pending movement was created from (phase 7).
 int? get recurringTemplateId;/// Waiting for confirmation. A pending income does not move the balance
/// until confirmed (RF-06).
 bool get isPending;/// A salary that starts a period (RF-05).
 bool get startsPeriod;
/// Create a copy of Movement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovementCopyWith<Movement> get copyWith => _$MovementCopyWithImpl<Movement>(this as Movement, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Movement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Movement&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.toAccountId, _this.toAccountId) || other.toAccountId == _this.toAccountId)&&(identical(other.toAmount, _this.toAmount) || other.toAmount == _this.toAmount)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.payeeId, _this.payeeId) || other.payeeId == _this.payeeId)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.debtId, _this.debtId) || other.debtId == _this.debtId)&&(identical(other.recurringTemplateId, _this.recurringTemplateId) || other.recurringTemplateId == _this.recurringTemplateId)&&(identical(other.isPending, _this.isPending) || other.isPending == _this.isPending)&&(identical(other.startsPeriod, _this.startsPeriod) || other.startsPeriod == _this.startsPeriod));
}


@override
int get hashCode {
  final _this = this as Movement;
  return Object.hash(runtimeType,_this.type,_this.date,_this.accountId,_this.amount,_this.id,_this.toAccountId,_this.toAmount,_this.categoryId,_this.payeeId,_this.note,_this.debtId,_this.recurringTemplateId,_this.isPending,_this.startsPeriod);
}

@override
String toString() {
  final _this = this as Movement;
  return 'Movement(type: ${_this.type}, date: ${_this.date}, accountId: ${_this.accountId}, amount: ${_this.amount}, id: ${_this.id}, toAccountId: ${_this.toAccountId}, toAmount: ${_this.toAmount}, categoryId: ${_this.categoryId}, payeeId: ${_this.payeeId}, note: ${_this.note}, debtId: ${_this.debtId}, recurringTemplateId: ${_this.recurringTemplateId}, isPending: ${_this.isPending}, startsPeriod: ${_this.startsPeriod})';
}


}

/// @nodoc
abstract mixin class $MovementCopyWith<$Res>  {
  factory $MovementCopyWith(Movement value, $Res Function(Movement) _then) = _$MovementCopyWithImpl;
@useResult
$Res call({
 MovementType type, LocalDate date, int accountId, int amount, int id, int? toAccountId, int? toAmount, int? categoryId, int? payeeId, String? note, int? debtId, int? recurringTemplateId, bool isPending, bool startsPeriod
});




}
/// @nodoc
class _$MovementCopyWithImpl<$Res>
    implements $MovementCopyWith<$Res> {
  _$MovementCopyWithImpl(this._self, this._then);

  final Movement _self;
  final $Res Function(Movement) _then;

/// Create a copy of Movement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? date = null,Object? accountId = null,Object? amount = null,Object? id = null,Object? toAccountId = freezed,Object? toAmount = freezed,Object? categoryId = freezed,Object? payeeId = freezed,Object? note = freezed,Object? debtId = freezed,Object? recurringTemplateId = freezed,Object? isPending = null,Object? startsPeriod = null,}) {
  return _then(Movement(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MovementType,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as LocalDate,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as int?,toAmount: freezed == toAmount ? _self.toAmount : toAmount // ignore: cast_nullable_to_non_nullable
as int?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,payeeId: freezed == payeeId ? _self.payeeId : payeeId // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,debtId: freezed == debtId ? _self.debtId : debtId // ignore: cast_nullable_to_non_nullable
as int?,recurringTemplateId: freezed == recurringTemplateId ? _self.recurringTemplateId : recurringTemplateId // ignore: cast_nullable_to_non_nullable
as int?,isPending: null == isPending ? _self.isPending : isPending // ignore: cast_nullable_to_non_nullable
as bool,startsPeriod: null == startsPeriod ? _self.startsPeriod : startsPeriod // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Movement].
extension MovementPatterns on Movement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Movement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Movement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Movement value)  $default,){
final _that = this;
switch (_that) {
case _Movement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Movement value)?  $default,){
final _that = this;
switch (_that) {
case _Movement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MovementType type,  LocalDate date,  int accountId,  int amount,  int id,  int? toAccountId,  int? toAmount,  int? categoryId,  int? payeeId,  String? note,  int? debtId,  int? recurringTemplateId,  bool isPending,  bool startsPeriod)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Movement() when $default != null:
return $default(_that.type,_that.date,_that.accountId,_that.amount,_that.id,_that.toAccountId,_that.toAmount,_that.categoryId,_that.payeeId,_that.note,_that.debtId,_that.recurringTemplateId,_that.isPending,_that.startsPeriod);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MovementType type,  LocalDate date,  int accountId,  int amount,  int id,  int? toAccountId,  int? toAmount,  int? categoryId,  int? payeeId,  String? note,  int? debtId,  int? recurringTemplateId,  bool isPending,  bool startsPeriod)  $default,) {final _that = this;
switch (_that) {
case _Movement():
return $default(_that.type,_that.date,_that.accountId,_that.amount,_that.id,_that.toAccountId,_that.toAmount,_that.categoryId,_that.payeeId,_that.note,_that.debtId,_that.recurringTemplateId,_that.isPending,_that.startsPeriod);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MovementType type,  LocalDate date,  int accountId,  int amount,  int id,  int? toAccountId,  int? toAmount,  int? categoryId,  int? payeeId,  String? note,  int? debtId,  int? recurringTemplateId,  bool isPending,  bool startsPeriod)?  $default,) {final _that = this;
switch (_that) {
case _Movement() when $default != null:
return $default(_that.type,_that.date,_that.accountId,_that.amount,_that.id,_that.toAccountId,_that.toAmount,_that.categoryId,_that.payeeId,_that.note,_that.debtId,_that.recurringTemplateId,_that.isPending,_that.startsPeriod);case _:
  return null;

}
}

}

/// @nodoc


class _Movement extends Movement {
  const _Movement({required this.type, required this.date, required this.accountId, required this.amount, this.id = 0, this.toAccountId, this.toAmount, this.categoryId, this.payeeId, this.note, this.debtId, this.recurringTemplateId, this.isPending = false, this.startsPeriod = false}): super._();
  

@override final  MovementType type;
@override final  LocalDate date;
/// The account that receives an income, pays an expense, sends a
/// transfer or is adjusted.
@override final  int accountId;
/// Positive, except for an adjustment: the signed difference.
@override final  int amount;
/// Database id; `0` for a movement that is not stored yet.
@override@JsonKey() final  int id;
/// Account that receives a transfer.
@override final  int? toAccountId;
/// What a transfer adds to [toAccountId]; it differs from [amount] only
/// between currencies.
@override final  int? toAmount;
/// Required for incomes, expenses and transfers.
@override final  int? categoryId;
/// Only incomes and expenses have one.
@override final  int? payeeId;
@override final  String? note;
/// Debt the movement creates or pays (phase 8).
@override final  int? debtId;
/// Template a pending movement was created from (phase 7).
@override final  int? recurringTemplateId;
/// Waiting for confirmation. A pending income does not move the balance
/// until confirmed (RF-06).
@override@JsonKey() final  bool isPending;
/// A salary that starts a period (RF-05).
@override@JsonKey() final  bool startsPeriod;

/// Create a copy of Movement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovementCopyWith<_Movement> get copyWith => __$MovementCopyWithImpl<_Movement>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Movement&&(identical(other.type, type) || other.type == type)&&(identical(other.date, date) || other.date == date)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.id, id) || other.id == id)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.toAmount, toAmount) || other.toAmount == toAmount)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.payeeId, payeeId) || other.payeeId == payeeId)&&(identical(other.note, note) || other.note == note)&&(identical(other.debtId, debtId) || other.debtId == debtId)&&(identical(other.recurringTemplateId, recurringTemplateId) || other.recurringTemplateId == recurringTemplateId)&&(identical(other.isPending, isPending) || other.isPending == isPending)&&(identical(other.startsPeriod, startsPeriod) || other.startsPeriod == startsPeriod));
}


@override
int get hashCode {
    return Object.hash(runtimeType,type,date,accountId,amount,id,toAccountId,toAmount,categoryId,payeeId,note,debtId,recurringTemplateId,isPending,startsPeriod);
}

@override
String toString() {
    return 'Movement(type: $type, date: $date, accountId: $accountId, amount: $amount, id: $id, toAccountId: $toAccountId, toAmount: $toAmount, categoryId: $categoryId, payeeId: $payeeId, note: $note, debtId: $debtId, recurringTemplateId: $recurringTemplateId, isPending: $isPending, startsPeriod: $startsPeriod)';
}


}

/// @nodoc
abstract mixin class _$MovementCopyWith<$Res> implements $MovementCopyWith<$Res> {
  factory _$MovementCopyWith(_Movement value, $Res Function(_Movement) _then) = __$MovementCopyWithImpl;
@override @useResult
$Res call({
 MovementType type, LocalDate date, int accountId, int amount, int id, int? toAccountId, int? toAmount, int? categoryId, int? payeeId, String? note, int? debtId, int? recurringTemplateId, bool isPending, bool startsPeriod
});




}
/// @nodoc
class __$MovementCopyWithImpl<$Res>
    implements _$MovementCopyWith<$Res> {
  __$MovementCopyWithImpl(this._self, this._then);

  final _Movement _self;
  final $Res Function(_Movement) _then;

/// Create a copy of Movement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? date = null,Object? accountId = null,Object? amount = null,Object? id = null,Object? toAccountId = freezed,Object? toAmount = freezed,Object? categoryId = freezed,Object? payeeId = freezed,Object? note = freezed,Object? debtId = freezed,Object? recurringTemplateId = freezed,Object? isPending = null,Object? startsPeriod = null,}) {
  return _then(_Movement(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MovementType,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as LocalDate,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as int?,toAmount: freezed == toAmount ? _self.toAmount : toAmount // ignore: cast_nullable_to_non_nullable
as int?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,payeeId: freezed == payeeId ? _self.payeeId : payeeId // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,debtId: freezed == debtId ? _self.debtId : debtId // ignore: cast_nullable_to_non_nullable
as int?,recurringTemplateId: freezed == recurringTemplateId ? _self.recurringTemplateId : recurringTemplateId // ignore: cast_nullable_to_non_nullable
as int?,isPending: null == isPending ? _self.isPending : isPending // ignore: cast_nullable_to_non_nullable
as bool,startsPeriod: null == startsPeriod ? _self.startsPeriod : startsPeriod // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
