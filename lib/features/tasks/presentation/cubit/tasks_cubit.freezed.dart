// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TasksState {

 TasksStatus get status; List<Task> get tasks;/// Last failure of a user action, shown once by the UI.
 Failure? get failure;
/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TasksStateCopyWith<TasksState> get copyWith => _$TasksStateCopyWithImpl<TasksState>(this as TasksState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TasksState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TasksState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.tasks, _this.tasks)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as TasksState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.tasks),_this.failure);
}

@override
String toString() {
  final _this = this as TasksState;
  return 'TasksState(status: ${_this.status}, tasks: ${_this.tasks}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $TasksStateCopyWith<$Res>  {
  factory $TasksStateCopyWith(TasksState value, $Res Function(TasksState) _then) = _$TasksStateCopyWithImpl;
@useResult
$Res call({
 TasksStatus status, List<Task> tasks, Failure? failure
});




}
/// @nodoc
class _$TasksStateCopyWithImpl<$Res>
    implements $TasksStateCopyWith<$Res> {
  _$TasksStateCopyWithImpl(this._self, this._then);

  final TasksState _self;
  final $Res Function(TasksState) _then;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? tasks = null,Object? failure = freezed,}) {
  return _then(TasksState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TasksStatus,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// Adds pattern-matching-related methods to [TasksState].
extension TasksStatePatterns on TasksState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TasksState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TasksState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TasksState value)  $default,){
final _that = this;
switch (_that) {
case _TasksState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TasksState value)?  $default,){
final _that = this;
switch (_that) {
case _TasksState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TasksStatus status,  List<Task> tasks,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TasksState() when $default != null:
return $default(_that.status,_that.tasks,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TasksStatus status,  List<Task> tasks,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _TasksState():
return $default(_that.status,_that.tasks,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TasksStatus status,  List<Task> tasks,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _TasksState() when $default != null:
return $default(_that.status,_that.tasks,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _TasksState implements TasksState {
  const _TasksState({this.status = TasksStatus.loading,  List<Task> tasks = const <Task>[], this.failure}): _tasks = tasks;
  

@override@JsonKey() final  TasksStatus status;
 final  List<Task> _tasks;
@override@JsonKey() List<Task> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}

/// Last failure of a user action, shown once by the UI.
@override final  Failure? failure;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TasksStateCopyWith<_TasksState> get copyWith => __$TasksStateCopyWithImpl<_TasksState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TasksState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.tasks, _tasks)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_tasks),failure);
}

@override
String toString() {
    return 'TasksState(status: $status, tasks: $tasks, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$TasksStateCopyWith<$Res> implements $TasksStateCopyWith<$Res> {
  factory _$TasksStateCopyWith(_TasksState value, $Res Function(_TasksState) _then) = __$TasksStateCopyWithImpl;
@override @useResult
$Res call({
 TasksStatus status, List<Task> tasks, Failure? failure
});




}
/// @nodoc
class __$TasksStateCopyWithImpl<$Res>
    implements _$TasksStateCopyWith<$Res> {
  __$TasksStateCopyWithImpl(this._self, this._then);

  final _TasksState _self;
  final $Res Function(_TasksState) _then;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? tasks = null,Object? failure = freezed,}) {
  return _then(_TasksState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TasksStatus,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
