// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_occurrence.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecurringOccurrence {

 int get id; int get templateId; LocalDate get periodStart;/// `null` once the movement was deleted (a cancelled pending one).
 int? get movementId;/// Whether that movement still waits for its confirmation.
 bool get isPending;
/// Create a copy of RecurringOccurrence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringOccurrenceCopyWith<RecurringOccurrence> get copyWith => _$RecurringOccurrenceCopyWithImpl<RecurringOccurrence>(this as RecurringOccurrence, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RecurringOccurrence;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringOccurrence&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.templateId, _this.templateId) || other.templateId == _this.templateId)&&(identical(other.periodStart, _this.periodStart) || other.periodStart == _this.periodStart)&&(identical(other.movementId, _this.movementId) || other.movementId == _this.movementId)&&(identical(other.isPending, _this.isPending) || other.isPending == _this.isPending));
}


@override
int get hashCode {
  final _this = this as RecurringOccurrence;
  return Object.hash(runtimeType,_this.id,_this.templateId,_this.periodStart,_this.movementId,_this.isPending);
}

@override
String toString() {
  final _this = this as RecurringOccurrence;
  return 'RecurringOccurrence(id: ${_this.id}, templateId: ${_this.templateId}, periodStart: ${_this.periodStart}, movementId: ${_this.movementId}, isPending: ${_this.isPending})';
}


}

/// @nodoc
abstract mixin class $RecurringOccurrenceCopyWith<$Res>  {
  factory $RecurringOccurrenceCopyWith(RecurringOccurrence value, $Res Function(RecurringOccurrence) _then) = _$RecurringOccurrenceCopyWithImpl;
@useResult
$Res call({
 int id, int templateId, LocalDate periodStart, int? movementId, bool isPending
});




}
/// @nodoc
class _$RecurringOccurrenceCopyWithImpl<$Res>
    implements $RecurringOccurrenceCopyWith<$Res> {
  _$RecurringOccurrenceCopyWithImpl(this._self, this._then);

  final RecurringOccurrence _self;
  final $Res Function(RecurringOccurrence) _then;

/// Create a copy of RecurringOccurrence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? templateId = null,Object? periodStart = null,Object? movementId = freezed,Object? isPending = null,}) {
  return _then(RecurringOccurrence(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,templateId: null == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as int,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as LocalDate,movementId: freezed == movementId ? _self.movementId : movementId // ignore: cast_nullable_to_non_nullable
as int?,isPending: null == isPending ? _self.isPending : isPending // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RecurringOccurrence].
extension RecurringOccurrencePatterns on RecurringOccurrence {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurringOccurrence value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurringOccurrence() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurringOccurrence value)  $default,){
final _that = this;
switch (_that) {
case _RecurringOccurrence():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurringOccurrence value)?  $default,){
final _that = this;
switch (_that) {
case _RecurringOccurrence() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int templateId,  LocalDate periodStart,  int? movementId,  bool isPending)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurringOccurrence() when $default != null:
return $default(_that.id,_that.templateId,_that.periodStart,_that.movementId,_that.isPending);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int templateId,  LocalDate periodStart,  int? movementId,  bool isPending)  $default,) {final _that = this;
switch (_that) {
case _RecurringOccurrence():
return $default(_that.id,_that.templateId,_that.periodStart,_that.movementId,_that.isPending);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int templateId,  LocalDate periodStart,  int? movementId,  bool isPending)?  $default,) {final _that = this;
switch (_that) {
case _RecurringOccurrence() when $default != null:
return $default(_that.id,_that.templateId,_that.periodStart,_that.movementId,_that.isPending);case _:
  return null;

}
}

}

/// @nodoc


class _RecurringOccurrence implements RecurringOccurrence {
  const _RecurringOccurrence({required this.id, required this.templateId, required this.periodStart, this.movementId, this.isPending = false});
  

@override final  int id;
@override final  int templateId;
@override final  LocalDate periodStart;
/// `null` once the movement was deleted (a cancelled pending one).
@override final  int? movementId;
/// Whether that movement still waits for its confirmation.
@override@JsonKey() final  bool isPending;

/// Create a copy of RecurringOccurrence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurringOccurrenceCopyWith<_RecurringOccurrence> get copyWith => __$RecurringOccurrenceCopyWithImpl<_RecurringOccurrence>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurringOccurrence&&(identical(other.id, id) || other.id == id)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.movementId, movementId) || other.movementId == movementId)&&(identical(other.isPending, isPending) || other.isPending == isPending));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,templateId,periodStart,movementId,isPending);
}

@override
String toString() {
    return 'RecurringOccurrence(id: $id, templateId: $templateId, periodStart: $periodStart, movementId: $movementId, isPending: $isPending)';
}


}

/// @nodoc
abstract mixin class _$RecurringOccurrenceCopyWith<$Res> implements $RecurringOccurrenceCopyWith<$Res> {
  factory _$RecurringOccurrenceCopyWith(_RecurringOccurrence value, $Res Function(_RecurringOccurrence) _then) = __$RecurringOccurrenceCopyWithImpl;
@override @useResult
$Res call({
 int id, int templateId, LocalDate periodStart, int? movementId, bool isPending
});




}
/// @nodoc
class __$RecurringOccurrenceCopyWithImpl<$Res>
    implements _$RecurringOccurrenceCopyWith<$Res> {
  __$RecurringOccurrenceCopyWithImpl(this._self, this._then);

  final _RecurringOccurrence _self;
  final $Res Function(_RecurringOccurrence) _then;

/// Create a copy of RecurringOccurrence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? templateId = null,Object? periodStart = null,Object? movementId = freezed,Object? isPending = null,}) {
  return _then(_RecurringOccurrence(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,templateId: null == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as int,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as LocalDate,movementId: freezed == movementId ? _self.movementId : movementId // ignore: cast_nullable_to_non_nullable
as int?,isPending: null == isPending ? _self.isPending : isPending // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
