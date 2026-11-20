// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Payee {

 int get id;/// Display text: trimmed, inner spaces collapsed, first letter upper.
 String get name;/// Comparison key: no spaces, lowercase, no accents. Unique (RT-08).
 String get key;
/// Create a copy of Payee
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayeeCopyWith<Payee> get copyWith => _$PayeeCopyWithImpl<Payee>(this as Payee, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Payee;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payee&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.key, _this.key) || other.key == _this.key));
}


@override
int get hashCode {
  final _this = this as Payee;
  return Object.hash(runtimeType,_this.id,_this.name,_this.key);
}

@override
String toString() {
  final _this = this as Payee;
  return 'Payee(id: ${_this.id}, name: ${_this.name}, key: ${_this.key})';
}


}

/// @nodoc
abstract mixin class $PayeeCopyWith<$Res>  {
  factory $PayeeCopyWith(Payee value, $Res Function(Payee) _then) = _$PayeeCopyWithImpl;
@useResult
$Res call({
 int id, String name, String key
});




}
/// @nodoc
class _$PayeeCopyWithImpl<$Res>
    implements $PayeeCopyWith<$Res> {
  _$PayeeCopyWithImpl(this._self, this._then);

  final Payee _self;
  final $Res Function(Payee) _then;

/// Create a copy of Payee
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? key = null,}) {
  return _then(Payee(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Payee].
extension PayeePatterns on Payee {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payee value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payee() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payee value)  $default,){
final _that = this;
switch (_that) {
case _Payee():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payee value)?  $default,){
final _that = this;
switch (_that) {
case _Payee() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String key)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payee() when $default != null:
return $default(_that.id,_that.name,_that.key);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String key)  $default,) {final _that = this;
switch (_that) {
case _Payee():
return $default(_that.id,_that.name,_that.key);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String key)?  $default,) {final _that = this;
switch (_that) {
case _Payee() when $default != null:
return $default(_that.id,_that.name,_that.key);case _:
  return null;

}
}

}

/// @nodoc


class _Payee implements Payee {
  const _Payee({required this.id, required this.name, required this.key});
  

@override final  int id;
/// Display text: trimmed, inner spaces collapsed, first letter upper.
@override final  String name;
/// Comparison key: no spaces, lowercase, no accents. Unique (RT-08).
@override final  String key;

/// Create a copy of Payee
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayeeCopyWith<_Payee> get copyWith => __$PayeeCopyWithImpl<_Payee>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payee&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.key, key) || other.key == key));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,key);
}

@override
String toString() {
    return 'Payee(id: $id, name: $name, key: $key)';
}


}

/// @nodoc
abstract mixin class _$PayeeCopyWith<$Res> implements $PayeeCopyWith<$Res> {
  factory _$PayeeCopyWith(_Payee value, $Res Function(_Payee) _then) = __$PayeeCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String key
});




}
/// @nodoc
class __$PayeeCopyWithImpl<$Res>
    implements _$PayeeCopyWith<$Res> {
  __$PayeeCopyWithImpl(this._self, this._then);

  final _Payee _self;
  final $Res Function(_Payee) _then;

/// Create a copy of Payee
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? key = null,}) {
  return _then(_Payee(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
