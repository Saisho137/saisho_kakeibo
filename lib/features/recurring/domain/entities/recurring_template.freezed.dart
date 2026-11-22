// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecurringTemplate {

 MovementType get type; int get categoryId; int get accountId;/// In the minor unit of [accountId]'s currency. Confirming one of its
/// movements copies that amount here (RF-06).
 int get amount;/// The day the template was saved; its first movement comes at the
/// next period start, never in the period it was created (RF-06).
 LocalDate get createdOn; int get id; RecurringCadence get cadence;/// Receiving account of a transfer.
 int? get toAccountId;/// What a transfer adds to [toAccountId]; it differs from [amount] only
/// between currencies.
 int? get toAmount;/// Only incomes and expenses have one.
 int? get payeeId; String? get note;/// Day of the month it is due: the reminder day of expenses and
/// transfers, and the date of incomes.
 int? get dueDay;/// Notify on [dueDay]; only possible with one.
 bool get remind;/// A paused template creates nothing.
 bool get isActive;
/// Create a copy of RecurringTemplate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringTemplateCopyWith<RecurringTemplate> get copyWith => _$RecurringTemplateCopyWithImpl<RecurringTemplate>(this as RecurringTemplate, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RecurringTemplate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringTemplate&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.createdOn, _this.createdOn) || other.createdOn == _this.createdOn)&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.cadence, _this.cadence) || other.cadence == _this.cadence)&&(identical(other.toAccountId, _this.toAccountId) || other.toAccountId == _this.toAccountId)&&(identical(other.toAmount, _this.toAmount) || other.toAmount == _this.toAmount)&&(identical(other.payeeId, _this.payeeId) || other.payeeId == _this.payeeId)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.dueDay, _this.dueDay) || other.dueDay == _this.dueDay)&&(identical(other.remind, _this.remind) || other.remind == _this.remind)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive));
}


@override
int get hashCode {
  final _this = this as RecurringTemplate;
  return Object.hash(runtimeType,_this.type,_this.categoryId,_this.accountId,_this.amount,_this.createdOn,_this.id,_this.cadence,_this.toAccountId,_this.toAmount,_this.payeeId,_this.note,_this.dueDay,_this.remind,_this.isActive);
}

@override
String toString() {
  final _this = this as RecurringTemplate;
  return 'RecurringTemplate(type: ${_this.type}, categoryId: ${_this.categoryId}, accountId: ${_this.accountId}, amount: ${_this.amount}, createdOn: ${_this.createdOn}, id: ${_this.id}, cadence: ${_this.cadence}, toAccountId: ${_this.toAccountId}, toAmount: ${_this.toAmount}, payeeId: ${_this.payeeId}, note: ${_this.note}, dueDay: ${_this.dueDay}, remind: ${_this.remind}, isActive: ${_this.isActive})';
}


}

/// @nodoc
abstract mixin class $RecurringTemplateCopyWith<$Res>  {
  factory $RecurringTemplateCopyWith(RecurringTemplate value, $Res Function(RecurringTemplate) _then) = _$RecurringTemplateCopyWithImpl;
@useResult
$Res call({
 MovementType type, int categoryId, int accountId, int amount, LocalDate createdOn, int id, RecurringCadence cadence, int? toAccountId, int? toAmount, int? payeeId, String? note, int? dueDay, bool remind, bool isActive
});




}
/// @nodoc
class _$RecurringTemplateCopyWithImpl<$Res>
    implements $RecurringTemplateCopyWith<$Res> {
  _$RecurringTemplateCopyWithImpl(this._self, this._then);

  final RecurringTemplate _self;
  final $Res Function(RecurringTemplate) _then;

/// Create a copy of RecurringTemplate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? categoryId = null,Object? accountId = null,Object? amount = null,Object? createdOn = null,Object? id = null,Object? cadence = null,Object? toAccountId = freezed,Object? toAmount = freezed,Object? payeeId = freezed,Object? note = freezed,Object? dueDay = freezed,Object? remind = null,Object? isActive = null,}) {
  return _then(RecurringTemplate(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MovementType,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,createdOn: null == createdOn ? _self.createdOn : createdOn // ignore: cast_nullable_to_non_nullable
as LocalDate,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,cadence: null == cadence ? _self.cadence : cadence // ignore: cast_nullable_to_non_nullable
as RecurringCadence,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as int?,toAmount: freezed == toAmount ? _self.toAmount : toAmount // ignore: cast_nullable_to_non_nullable
as int?,payeeId: freezed == payeeId ? _self.payeeId : payeeId // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,dueDay: freezed == dueDay ? _self.dueDay : dueDay // ignore: cast_nullable_to_non_nullable
as int?,remind: null == remind ? _self.remind : remind // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RecurringTemplate].
extension RecurringTemplatePatterns on RecurringTemplate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurringTemplate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurringTemplate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurringTemplate value)  $default,){
final _that = this;
switch (_that) {
case _RecurringTemplate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurringTemplate value)?  $default,){
final _that = this;
switch (_that) {
case _RecurringTemplate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MovementType type,  int categoryId,  int accountId,  int amount,  LocalDate createdOn,  int id,  RecurringCadence cadence,  int? toAccountId,  int? toAmount,  int? payeeId,  String? note,  int? dueDay,  bool remind,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurringTemplate() when $default != null:
return $default(_that.type,_that.categoryId,_that.accountId,_that.amount,_that.createdOn,_that.id,_that.cadence,_that.toAccountId,_that.toAmount,_that.payeeId,_that.note,_that.dueDay,_that.remind,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MovementType type,  int categoryId,  int accountId,  int amount,  LocalDate createdOn,  int id,  RecurringCadence cadence,  int? toAccountId,  int? toAmount,  int? payeeId,  String? note,  int? dueDay,  bool remind,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _RecurringTemplate():
return $default(_that.type,_that.categoryId,_that.accountId,_that.amount,_that.createdOn,_that.id,_that.cadence,_that.toAccountId,_that.toAmount,_that.payeeId,_that.note,_that.dueDay,_that.remind,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MovementType type,  int categoryId,  int accountId,  int amount,  LocalDate createdOn,  int id,  RecurringCadence cadence,  int? toAccountId,  int? toAmount,  int? payeeId,  String? note,  int? dueDay,  bool remind,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _RecurringTemplate() when $default != null:
return $default(_that.type,_that.categoryId,_that.accountId,_that.amount,_that.createdOn,_that.id,_that.cadence,_that.toAccountId,_that.toAmount,_that.payeeId,_that.note,_that.dueDay,_that.remind,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc


class _RecurringTemplate extends RecurringTemplate {
  const _RecurringTemplate({required this.type, required this.categoryId, required this.accountId, required this.amount, required this.createdOn, this.id = 0, this.cadence = RecurringCadence.period, this.toAccountId, this.toAmount, this.payeeId, this.note, this.dueDay, this.remind = false, this.isActive = true}): super._();
  

@override final  MovementType type;
@override final  int categoryId;
@override final  int accountId;
/// In the minor unit of [accountId]'s currency. Confirming one of its
/// movements copies that amount here (RF-06).
@override final  int amount;
/// The day the template was saved; its first movement comes at the
/// next period start, never in the period it was created (RF-06).
@override final  LocalDate createdOn;
@override@JsonKey() final  int id;
@override@JsonKey() final  RecurringCadence cadence;
/// Receiving account of a transfer.
@override final  int? toAccountId;
/// What a transfer adds to [toAccountId]; it differs from [amount] only
/// between currencies.
@override final  int? toAmount;
/// Only incomes and expenses have one.
@override final  int? payeeId;
@override final  String? note;
/// Day of the month it is due: the reminder day of expenses and
/// transfers, and the date of incomes.
@override final  int? dueDay;
/// Notify on [dueDay]; only possible with one.
@override@JsonKey() final  bool remind;
/// A paused template creates nothing.
@override@JsonKey() final  bool isActive;

/// Create a copy of RecurringTemplate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurringTemplateCopyWith<_RecurringTemplate> get copyWith => __$RecurringTemplateCopyWithImpl<_RecurringTemplate>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurringTemplate&&(identical(other.type, type) || other.type == type)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.createdOn, createdOn) || other.createdOn == createdOn)&&(identical(other.id, id) || other.id == id)&&(identical(other.cadence, cadence) || other.cadence == cadence)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.toAmount, toAmount) || other.toAmount == toAmount)&&(identical(other.payeeId, payeeId) || other.payeeId == payeeId)&&(identical(other.note, note) || other.note == note)&&(identical(other.dueDay, dueDay) || other.dueDay == dueDay)&&(identical(other.remind, remind) || other.remind == remind)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode {
    return Object.hash(runtimeType,type,categoryId,accountId,amount,createdOn,id,cadence,toAccountId,toAmount,payeeId,note,dueDay,remind,isActive);
}

@override
String toString() {
    return 'RecurringTemplate(type: $type, categoryId: $categoryId, accountId: $accountId, amount: $amount, createdOn: $createdOn, id: $id, cadence: $cadence, toAccountId: $toAccountId, toAmount: $toAmount, payeeId: $payeeId, note: $note, dueDay: $dueDay, remind: $remind, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$RecurringTemplateCopyWith<$Res> implements $RecurringTemplateCopyWith<$Res> {
  factory _$RecurringTemplateCopyWith(_RecurringTemplate value, $Res Function(_RecurringTemplate) _then) = __$RecurringTemplateCopyWithImpl;
@override @useResult
$Res call({
 MovementType type, int categoryId, int accountId, int amount, LocalDate createdOn, int id, RecurringCadence cadence, int? toAccountId, int? toAmount, int? payeeId, String? note, int? dueDay, bool remind, bool isActive
});




}
/// @nodoc
class __$RecurringTemplateCopyWithImpl<$Res>
    implements _$RecurringTemplateCopyWith<$Res> {
  __$RecurringTemplateCopyWithImpl(this._self, this._then);

  final _RecurringTemplate _self;
  final $Res Function(_RecurringTemplate) _then;

/// Create a copy of RecurringTemplate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? categoryId = null,Object? accountId = null,Object? amount = null,Object? createdOn = null,Object? id = null,Object? cadence = null,Object? toAccountId = freezed,Object? toAmount = freezed,Object? payeeId = freezed,Object? note = freezed,Object? dueDay = freezed,Object? remind = null,Object? isActive = null,}) {
  return _then(_RecurringTemplate(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MovementType,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,createdOn: null == createdOn ? _self.createdOn : createdOn // ignore: cast_nullable_to_non_nullable
as LocalDate,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,cadence: null == cadence ? _self.cadence : cadence // ignore: cast_nullable_to_non_nullable
as RecurringCadence,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as int?,toAmount: freezed == toAmount ? _self.toAmount : toAmount // ignore: cast_nullable_to_non_nullable
as int?,payeeId: freezed == payeeId ? _self.payeeId : payeeId // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,dueDay: freezed == dueDay ? _self.dueDay : dueDay // ignore: cast_nullable_to_non_nullable
as int?,remind: null == remind ? _self.remind : remind // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
