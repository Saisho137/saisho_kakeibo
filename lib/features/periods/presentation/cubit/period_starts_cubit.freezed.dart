// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'period_starts_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PeriodStartsState {

/// Newest first.
 List<LocalDate> get manualStarts; PeriodStartNotice? get notice;/// Grows with every notice, so a repeated one is shown again.
 int get notices;/// Last failure, shown once by the UI.
 Failure? get failure;
/// Create a copy of PeriodStartsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodStartsStateCopyWith<PeriodStartsState> get copyWith => _$PeriodStartsStateCopyWithImpl<PeriodStartsState>(this as PeriodStartsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PeriodStartsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodStartsState&&const DeepCollectionEquality().equals(other.manualStarts, _this.manualStarts)&&(identical(other.notice, _this.notice) || other.notice == _this.notice)&&(identical(other.notices, _this.notices) || other.notices == _this.notices)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as PeriodStartsState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.manualStarts),_this.notice,_this.notices,_this.failure);
}

@override
String toString() {
  final _this = this as PeriodStartsState;
  return 'PeriodStartsState(manualStarts: ${_this.manualStarts}, notice: ${_this.notice}, notices: ${_this.notices}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $PeriodStartsStateCopyWith<$Res>  {
  factory $PeriodStartsStateCopyWith(PeriodStartsState value, $Res Function(PeriodStartsState) _then) = _$PeriodStartsStateCopyWithImpl;
@useResult
$Res call({
 List<LocalDate> manualStarts, PeriodStartNotice? notice, int notices, Failure? failure
});




}
/// @nodoc
class _$PeriodStartsStateCopyWithImpl<$Res>
    implements $PeriodStartsStateCopyWith<$Res> {
  _$PeriodStartsStateCopyWithImpl(this._self, this._then);

  final PeriodStartsState _self;
  final $Res Function(PeriodStartsState) _then;

/// Create a copy of PeriodStartsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? manualStarts = null,Object? notice = freezed,Object? notices = null,Object? failure = freezed,}) {
  return _then(PeriodStartsState(
manualStarts: null == manualStarts ? _self.manualStarts : manualStarts // ignore: cast_nullable_to_non_nullable
as List<LocalDate>,notice: freezed == notice ? _self.notice : notice // ignore: cast_nullable_to_non_nullable
as PeriodStartNotice?,notices: null == notices ? _self.notices : notices // ignore: cast_nullable_to_non_nullable
as int,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// Adds pattern-matching-related methods to [PeriodStartsState].
extension PeriodStartsStatePatterns on PeriodStartsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeriodStartsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeriodStartsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeriodStartsState value)  $default,){
final _that = this;
switch (_that) {
case _PeriodStartsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeriodStartsState value)?  $default,){
final _that = this;
switch (_that) {
case _PeriodStartsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LocalDate> manualStarts,  PeriodStartNotice? notice,  int notices,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeriodStartsState() when $default != null:
return $default(_that.manualStarts,_that.notice,_that.notices,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LocalDate> manualStarts,  PeriodStartNotice? notice,  int notices,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _PeriodStartsState():
return $default(_that.manualStarts,_that.notice,_that.notices,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LocalDate> manualStarts,  PeriodStartNotice? notice,  int notices,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _PeriodStartsState() when $default != null:
return $default(_that.manualStarts,_that.notice,_that.notices,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _PeriodStartsState implements PeriodStartsState {
  const _PeriodStartsState({ List<LocalDate> manualStarts = const <LocalDate>[], this.notice, this.notices = 0, this.failure}): _manualStarts = manualStarts;
  

/// Newest first.
 final  List<LocalDate> _manualStarts;
/// Newest first.
@override@JsonKey() List<LocalDate> get manualStarts {
  if (_manualStarts is EqualUnmodifiableListView) return _manualStarts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_manualStarts);
}

@override final  PeriodStartNotice? notice;
/// Grows with every notice, so a repeated one is shown again.
@override@JsonKey() final  int notices;
/// Last failure, shown once by the UI.
@override final  Failure? failure;

/// Create a copy of PeriodStartsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeriodStartsStateCopyWith<_PeriodStartsState> get copyWith => __$PeriodStartsStateCopyWithImpl<_PeriodStartsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeriodStartsState&&const DeepCollectionEquality().equals(other.manualStarts, _manualStarts)&&(identical(other.notice, notice) || other.notice == notice)&&(identical(other.notices, notices) || other.notices == notices)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_manualStarts),notice,notices,failure);
}

@override
String toString() {
    return 'PeriodStartsState(manualStarts: $manualStarts, notice: $notice, notices: $notices, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$PeriodStartsStateCopyWith<$Res> implements $PeriodStartsStateCopyWith<$Res> {
  factory _$PeriodStartsStateCopyWith(_PeriodStartsState value, $Res Function(_PeriodStartsState) _then) = __$PeriodStartsStateCopyWithImpl;
@override @useResult
$Res call({
 List<LocalDate> manualStarts, PeriodStartNotice? notice, int notices, Failure? failure
});




}
/// @nodoc
class __$PeriodStartsStateCopyWithImpl<$Res>
    implements _$PeriodStartsStateCopyWith<$Res> {
  __$PeriodStartsStateCopyWithImpl(this._self, this._then);

  final _PeriodStartsState _self;
  final $Res Function(_PeriodStartsState) _then;

/// Create a copy of PeriodStartsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? manualStarts = null,Object? notice = freezed,Object? notices = null,Object? failure = freezed,}) {
  return _then(_PeriodStartsState(
manualStarts: null == manualStarts ? _self._manualStarts : manualStarts // ignore: cast_nullable_to_non_nullable
as List<LocalDate>,notice: freezed == notice ? _self.notice : notice // ignore: cast_nullable_to_non_nullable
as PeriodStartNotice?,notices: null == notices ? _self.notices : notices // ignore: cast_nullable_to_non_nullable
as int,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
