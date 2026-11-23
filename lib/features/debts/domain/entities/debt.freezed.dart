// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Debt {

 DebtType get type; String get name; String get iconKey;/// ARGB color of its icon circle.
 int get color;/// The creditor or the debtor.
 int get payeeId; String get currencyCode;/// What was pending when the debt was registered, in the minor unit of
/// [currencyCode]: what the bank reports or what was agreed.
 int get initialPending; LocalDate get createdOn; int get id;/// Pillar its payments inherit; only debts I owe have one (RF-02).
 int? get pillarId;/// Prefills the amount of a payment.
 int? get installment;/// Day of the month a debt I owe is due, for its reminder.
 int? get dueDay;/// The single date a debt owed to me is due, for its reminder.
 LocalDate? get dueDate;/// Correction made with "Edit pending", which moves no money.
 int get adjustment;
/// Create a copy of Debt
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebtCopyWith<Debt> get copyWith => _$DebtCopyWithImpl<Debt>(this as Debt, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Debt;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Debt&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.iconKey, _this.iconKey) || other.iconKey == _this.iconKey)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.payeeId, _this.payeeId) || other.payeeId == _this.payeeId)&&(identical(other.currencyCode, _this.currencyCode) || other.currencyCode == _this.currencyCode)&&(identical(other.initialPending, _this.initialPending) || other.initialPending == _this.initialPending)&&(identical(other.createdOn, _this.createdOn) || other.createdOn == _this.createdOn)&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.pillarId, _this.pillarId) || other.pillarId == _this.pillarId)&&(identical(other.installment, _this.installment) || other.installment == _this.installment)&&(identical(other.dueDay, _this.dueDay) || other.dueDay == _this.dueDay)&&(identical(other.dueDate, _this.dueDate) || other.dueDate == _this.dueDate)&&(identical(other.adjustment, _this.adjustment) || other.adjustment == _this.adjustment));
}


@override
int get hashCode {
  final _this = this as Debt;
  return Object.hash(runtimeType,_this.type,_this.name,_this.iconKey,_this.color,_this.payeeId,_this.currencyCode,_this.initialPending,_this.createdOn,_this.id,_this.pillarId,_this.installment,_this.dueDay,_this.dueDate,_this.adjustment);
}

@override
String toString() {
  final _this = this as Debt;
  return 'Debt(type: ${_this.type}, name: ${_this.name}, iconKey: ${_this.iconKey}, color: ${_this.color}, payeeId: ${_this.payeeId}, currencyCode: ${_this.currencyCode}, initialPending: ${_this.initialPending}, createdOn: ${_this.createdOn}, id: ${_this.id}, pillarId: ${_this.pillarId}, installment: ${_this.installment}, dueDay: ${_this.dueDay}, dueDate: ${_this.dueDate}, adjustment: ${_this.adjustment})';
}


}

/// @nodoc
abstract mixin class $DebtCopyWith<$Res>  {
  factory $DebtCopyWith(Debt value, $Res Function(Debt) _then) = _$DebtCopyWithImpl;
@useResult
$Res call({
 DebtType type, String name, String iconKey, int color, int payeeId, String currencyCode, int initialPending, LocalDate createdOn, int id, int? pillarId, int? installment, int? dueDay, LocalDate? dueDate, int adjustment
});




}
/// @nodoc
class _$DebtCopyWithImpl<$Res>
    implements $DebtCopyWith<$Res> {
  _$DebtCopyWithImpl(this._self, this._then);

  final Debt _self;
  final $Res Function(Debt) _then;

/// Create a copy of Debt
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? name = null,Object? iconKey = null,Object? color = null,Object? payeeId = null,Object? currencyCode = null,Object? initialPending = null,Object? createdOn = null,Object? id = null,Object? pillarId = freezed,Object? installment = freezed,Object? dueDay = freezed,Object? dueDate = freezed,Object? adjustment = null,}) {
  return _then(Debt(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DebtType,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,payeeId: null == payeeId ? _self.payeeId : payeeId // ignore: cast_nullable_to_non_nullable
as int,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,initialPending: null == initialPending ? _self.initialPending : initialPending // ignore: cast_nullable_to_non_nullable
as int,createdOn: null == createdOn ? _self.createdOn : createdOn // ignore: cast_nullable_to_non_nullable
as LocalDate,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,pillarId: freezed == pillarId ? _self.pillarId : pillarId // ignore: cast_nullable_to_non_nullable
as int?,installment: freezed == installment ? _self.installment : installment // ignore: cast_nullable_to_non_nullable
as int?,dueDay: freezed == dueDay ? _self.dueDay : dueDay // ignore: cast_nullable_to_non_nullable
as int?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as LocalDate?,adjustment: null == adjustment ? _self.adjustment : adjustment // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Debt].
extension DebtPatterns on Debt {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Debt value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Debt() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Debt value)  $default,){
final _that = this;
switch (_that) {
case _Debt():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Debt value)?  $default,){
final _that = this;
switch (_that) {
case _Debt() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DebtType type,  String name,  String iconKey,  int color,  int payeeId,  String currencyCode,  int initialPending,  LocalDate createdOn,  int id,  int? pillarId,  int? installment,  int? dueDay,  LocalDate? dueDate,  int adjustment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Debt() when $default != null:
return $default(_that.type,_that.name,_that.iconKey,_that.color,_that.payeeId,_that.currencyCode,_that.initialPending,_that.createdOn,_that.id,_that.pillarId,_that.installment,_that.dueDay,_that.dueDate,_that.adjustment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DebtType type,  String name,  String iconKey,  int color,  int payeeId,  String currencyCode,  int initialPending,  LocalDate createdOn,  int id,  int? pillarId,  int? installment,  int? dueDay,  LocalDate? dueDate,  int adjustment)  $default,) {final _that = this;
switch (_that) {
case _Debt():
return $default(_that.type,_that.name,_that.iconKey,_that.color,_that.payeeId,_that.currencyCode,_that.initialPending,_that.createdOn,_that.id,_that.pillarId,_that.installment,_that.dueDay,_that.dueDate,_that.adjustment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DebtType type,  String name,  String iconKey,  int color,  int payeeId,  String currencyCode,  int initialPending,  LocalDate createdOn,  int id,  int? pillarId,  int? installment,  int? dueDay,  LocalDate? dueDate,  int adjustment)?  $default,) {final _that = this;
switch (_that) {
case _Debt() when $default != null:
return $default(_that.type,_that.name,_that.iconKey,_that.color,_that.payeeId,_that.currencyCode,_that.initialPending,_that.createdOn,_that.id,_that.pillarId,_that.installment,_that.dueDay,_that.dueDate,_that.adjustment);case _:
  return null;

}
}

}

/// @nodoc


class _Debt extends Debt {
  const _Debt({required this.type, required this.name, required this.iconKey, required this.color, required this.payeeId, required this.currencyCode, required this.initialPending, required this.createdOn, this.id = 0, this.pillarId, this.installment, this.dueDay, this.dueDate, this.adjustment = 0}): super._();
  

@override final  DebtType type;
@override final  String name;
@override final  String iconKey;
/// ARGB color of its icon circle.
@override final  int color;
/// The creditor or the debtor.
@override final  int payeeId;
@override final  String currencyCode;
/// What was pending when the debt was registered, in the minor unit of
/// [currencyCode]: what the bank reports or what was agreed.
@override final  int initialPending;
@override final  LocalDate createdOn;
@override@JsonKey() final  int id;
/// Pillar its payments inherit; only debts I owe have one (RF-02).
@override final  int? pillarId;
/// Prefills the amount of a payment.
@override final  int? installment;
/// Day of the month a debt I owe is due, for its reminder.
@override final  int? dueDay;
/// The single date a debt owed to me is due, for its reminder.
@override final  LocalDate? dueDate;
/// Correction made with "Edit pending", which moves no money.
@override@JsonKey() final  int adjustment;

/// Create a copy of Debt
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebtCopyWith<_Debt> get copyWith => __$DebtCopyWithImpl<_Debt>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Debt&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.color, color) || other.color == color)&&(identical(other.payeeId, payeeId) || other.payeeId == payeeId)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.initialPending, initialPending) || other.initialPending == initialPending)&&(identical(other.createdOn, createdOn) || other.createdOn == createdOn)&&(identical(other.id, id) || other.id == id)&&(identical(other.pillarId, pillarId) || other.pillarId == pillarId)&&(identical(other.installment, installment) || other.installment == installment)&&(identical(other.dueDay, dueDay) || other.dueDay == dueDay)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.adjustment, adjustment) || other.adjustment == adjustment));
}


@override
int get hashCode {
    return Object.hash(runtimeType,type,name,iconKey,color,payeeId,currencyCode,initialPending,createdOn,id,pillarId,installment,dueDay,dueDate,adjustment);
}

@override
String toString() {
    return 'Debt(type: $type, name: $name, iconKey: $iconKey, color: $color, payeeId: $payeeId, currencyCode: $currencyCode, initialPending: $initialPending, createdOn: $createdOn, id: $id, pillarId: $pillarId, installment: $installment, dueDay: $dueDay, dueDate: $dueDate, adjustment: $adjustment)';
}


}

/// @nodoc
abstract mixin class _$DebtCopyWith<$Res> implements $DebtCopyWith<$Res> {
  factory _$DebtCopyWith(_Debt value, $Res Function(_Debt) _then) = __$DebtCopyWithImpl;
@override @useResult
$Res call({
 DebtType type, String name, String iconKey, int color, int payeeId, String currencyCode, int initialPending, LocalDate createdOn, int id, int? pillarId, int? installment, int? dueDay, LocalDate? dueDate, int adjustment
});




}
/// @nodoc
class __$DebtCopyWithImpl<$Res>
    implements _$DebtCopyWith<$Res> {
  __$DebtCopyWithImpl(this._self, this._then);

  final _Debt _self;
  final $Res Function(_Debt) _then;

/// Create a copy of Debt
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? name = null,Object? iconKey = null,Object? color = null,Object? payeeId = null,Object? currencyCode = null,Object? initialPending = null,Object? createdOn = null,Object? id = null,Object? pillarId = freezed,Object? installment = freezed,Object? dueDay = freezed,Object? dueDate = freezed,Object? adjustment = null,}) {
  return _then(_Debt(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DebtType,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,payeeId: null == payeeId ? _self.payeeId : payeeId // ignore: cast_nullable_to_non_nullable
as int,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,initialPending: null == initialPending ? _self.initialPending : initialPending // ignore: cast_nullable_to_non_nullable
as int,createdOn: null == createdOn ? _self.createdOn : createdOn // ignore: cast_nullable_to_non_nullable
as LocalDate,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,pillarId: freezed == pillarId ? _self.pillarId : pillarId // ignore: cast_nullable_to_non_nullable
as int?,installment: freezed == installment ? _self.installment : installment // ignore: cast_nullable_to_non_nullable
as int?,dueDay: freezed == dueDay ? _self.dueDay : dueDay // ignore: cast_nullable_to_non_nullable
as int?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as LocalDate?,adjustment: null == adjustment ? _self.adjustment : adjustment // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
