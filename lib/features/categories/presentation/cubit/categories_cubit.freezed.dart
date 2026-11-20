// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categories_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoriesState {

 CategoriesStatus get status;/// Every category, archived included; `null` until loaded.
 List<Category>? get categories;/// `null` until loaded.
 List<Pillar>? get pillars;/// Last failure of an action, shown once by the UI.
 Failure? get failure;
/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoriesStateCopyWith<CategoriesState> get copyWith => _$CategoriesStateCopyWithImpl<CategoriesState>(this as CategoriesState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CategoriesState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoriesState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.pillars, _this.pillars)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as CategoriesState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.pillars),_this.failure);
}

@override
String toString() {
  final _this = this as CategoriesState;
  return 'CategoriesState(status: ${_this.status}, categories: ${_this.categories}, pillars: ${_this.pillars}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $CategoriesStateCopyWith<$Res>  {
  factory $CategoriesStateCopyWith(CategoriesState value, $Res Function(CategoriesState) _then) = _$CategoriesStateCopyWithImpl;
@useResult
$Res call({
 CategoriesStatus status, List<Category>? categories, List<Pillar>? pillars, Failure? failure
});




}
/// @nodoc
class _$CategoriesStateCopyWithImpl<$Res>
    implements $CategoriesStateCopyWith<$Res> {
  _$CategoriesStateCopyWithImpl(this._self, this._then);

  final CategoriesState _self;
  final $Res Function(CategoriesState) _then;

/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? categories = freezed,Object? pillars = freezed,Object? failure = freezed,}) {
  return _then(CategoriesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CategoriesStatus,categories: freezed == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>?,pillars: freezed == pillars ? _self.pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<Pillar>?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoriesState].
extension CategoriesStatePatterns on CategoriesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoriesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoriesState value)  $default,){
final _that = this;
switch (_that) {
case _CategoriesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoriesState value)?  $default,){
final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CategoriesStatus status,  List<Category>? categories,  List<Pillar>? pillars,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
return $default(_that.status,_that.categories,_that.pillars,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CategoriesStatus status,  List<Category>? categories,  List<Pillar>? pillars,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _CategoriesState():
return $default(_that.status,_that.categories,_that.pillars,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CategoriesStatus status,  List<Category>? categories,  List<Pillar>? pillars,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
return $default(_that.status,_that.categories,_that.pillars,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _CategoriesState extends CategoriesState {
  const _CategoriesState({this.status = CategoriesStatus.loading,  List<Category>? categories,  List<Pillar>? pillars, this.failure}): _categories = categories,_pillars = pillars,super._();
  

@override@JsonKey() final  CategoriesStatus status;
/// Every category, archived included; `null` until loaded.
 final  List<Category>? _categories;
/// Every category, archived included; `null` until loaded.
@override List<Category>? get categories {
  final value = _categories;
  if (value == null) return null;
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// `null` until loaded.
 final  List<Pillar>? _pillars;
/// `null` until loaded.
@override List<Pillar>? get pillars {
  final value = _pillars;
  if (value == null) return null;
  if (_pillars is EqualUnmodifiableListView) return _pillars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Last failure of an action, shown once by the UI.
@override final  Failure? failure;

/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoriesStateCopyWith<_CategoriesState> get copyWith => __$CategoriesStateCopyWithImpl<_CategoriesState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoriesState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.pillars, _pillars)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_pillars),failure);
}

@override
String toString() {
    return 'CategoriesState(status: $status, categories: $categories, pillars: $pillars, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$CategoriesStateCopyWith<$Res> implements $CategoriesStateCopyWith<$Res> {
  factory _$CategoriesStateCopyWith(_CategoriesState value, $Res Function(_CategoriesState) _then) = __$CategoriesStateCopyWithImpl;
@override @useResult
$Res call({
 CategoriesStatus status, List<Category>? categories, List<Pillar>? pillars, Failure? failure
});




}
/// @nodoc
class __$CategoriesStateCopyWithImpl<$Res>
    implements _$CategoriesStateCopyWith<$Res> {
  __$CategoriesStateCopyWithImpl(this._self, this._then);

  final _CategoriesState _self;
  final $Res Function(_CategoriesState) _then;

/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? categories = freezed,Object? pillars = freezed,Object? failure = freezed,}) {
  return _then(_CategoriesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CategoriesStatus,categories: freezed == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>?,pillars: freezed == pillars ? _self._pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<Pillar>?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
