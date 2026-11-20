// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pillar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Pillar {

 int get id; String get name;/// ARGB color of the pillar's border in the donut. Unique per pillar.
 int get color; int get sortOrder;
/// Create a copy of Pillar
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PillarCopyWith<Pillar> get copyWith => _$PillarCopyWithImpl<Pillar>(this as Pillar, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Pillar;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Pillar&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder));
}


@override
int get hashCode {
  final _this = this as Pillar;
  return Object.hash(runtimeType,_this.id,_this.name,_this.color,_this.sortOrder);
}

@override
String toString() {
  final _this = this as Pillar;
  return 'Pillar(id: ${_this.id}, name: ${_this.name}, color: ${_this.color}, sortOrder: ${_this.sortOrder})';
}


}

/// @nodoc
abstract mixin class $PillarCopyWith<$Res>  {
  factory $PillarCopyWith(Pillar value, $Res Function(Pillar) _then) = _$PillarCopyWithImpl;
@useResult
$Res call({
 int id, String name, int color, int sortOrder
});




}
/// @nodoc
class _$PillarCopyWithImpl<$Res>
    implements $PillarCopyWith<$Res> {
  _$PillarCopyWithImpl(this._self, this._then);

  final Pillar _self;
  final $Res Function(Pillar) _then;

/// Create a copy of Pillar
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? color = null,Object? sortOrder = null,}) {
  return _then(Pillar(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Pillar].
extension PillarPatterns on Pillar {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Pillar value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Pillar() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Pillar value)  $default,){
final _that = this;
switch (_that) {
case _Pillar():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Pillar value)?  $default,){
final _that = this;
switch (_that) {
case _Pillar() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int color,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Pillar() when $default != null:
return $default(_that.id,_that.name,_that.color,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int color,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _Pillar():
return $default(_that.id,_that.name,_that.color,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int color,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _Pillar() when $default != null:
return $default(_that.id,_that.name,_that.color,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _Pillar implements Pillar {
  const _Pillar({required this.id, required this.name, required this.color, this.sortOrder = 0});
  

@override final  int id;
@override final  String name;
/// ARGB color of the pillar's border in the donut. Unique per pillar.
@override final  int color;
@override@JsonKey() final  int sortOrder;

/// Create a copy of Pillar
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PillarCopyWith<_Pillar> get copyWith => __$PillarCopyWithImpl<_Pillar>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Pillar&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,color,sortOrder);
}

@override
String toString() {
    return 'Pillar(id: $id, name: $name, color: $color, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$PillarCopyWith<$Res> implements $PillarCopyWith<$Res> {
  factory _$PillarCopyWith(_Pillar value, $Res Function(_Pillar) _then) = __$PillarCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int color, int sortOrder
});




}
/// @nodoc
class __$PillarCopyWithImpl<$Res>
    implements _$PillarCopyWith<$Res> {
  __$PillarCopyWithImpl(this._self, this._then);

  final _Pillar _self;
  final $Res Function(_Pillar) _then;

/// Create a copy of Pillar
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? color = null,Object? sortOrder = null,}) {
  return _then(_Pillar(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
