// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryFormState {

 CategoryFormStatus get status;/// The stored category when editing; `null` when creating.
 Category? get original;/// Movements of the edited category, shown before deleting it.
 int get movementCount;/// Every category, for unique names, colors and delete targets.
 List<Category> get categories; List<Pillar> get pillars; CategoryType get type; String get name; String get iconKey; int get color; int? get pillarId; Set<CategoryError> get errors;/// Times the form was reset to default, so text fields refill.
 int get resets;/// Errors appear after the first submit, then update while typing.
 bool get showErrors;/// Last failure of a save, archive or delete, shown once by the UI.
 Failure? get failure;
/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryFormStateCopyWith<CategoryFormState> get copyWith => _$CategoryFormStateCopyWithImpl<CategoryFormState>(this as CategoryFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CategoryFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryFormState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.original, _this.original) || other.original == _this.original)&&(identical(other.movementCount, _this.movementCount) || other.movementCount == _this.movementCount)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.pillars, _this.pillars)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.iconKey, _this.iconKey) || other.iconKey == _this.iconKey)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.pillarId, _this.pillarId) || other.pillarId == _this.pillarId)&&const DeepCollectionEquality().equals(other.errors, _this.errors)&&(identical(other.resets, _this.resets) || other.resets == _this.resets)&&(identical(other.showErrors, _this.showErrors) || other.showErrors == _this.showErrors)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as CategoryFormState;
  return Object.hash(runtimeType,_this.status,_this.original,_this.movementCount,const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.pillars),_this.type,_this.name,_this.iconKey,_this.color,_this.pillarId,const DeepCollectionEquality().hash(_this.errors),_this.resets,_this.showErrors,_this.failure);
}

@override
String toString() {
  final _this = this as CategoryFormState;
  return 'CategoryFormState(status: ${_this.status}, original: ${_this.original}, movementCount: ${_this.movementCount}, categories: ${_this.categories}, pillars: ${_this.pillars}, type: ${_this.type}, name: ${_this.name}, iconKey: ${_this.iconKey}, color: ${_this.color}, pillarId: ${_this.pillarId}, errors: ${_this.errors}, resets: ${_this.resets}, showErrors: ${_this.showErrors}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $CategoryFormStateCopyWith<$Res>  {
  factory $CategoryFormStateCopyWith(CategoryFormState value, $Res Function(CategoryFormState) _then) = _$CategoryFormStateCopyWithImpl;
@useResult
$Res call({
 CategoryFormStatus status, Category? original, int movementCount, List<Category> categories, List<Pillar> pillars, CategoryType type, String name, String iconKey, int color, int? pillarId, Set<CategoryError> errors, int resets, bool showErrors, Failure? failure
});


$CategoryCopyWith<$Res>? get original;

}
/// @nodoc
class _$CategoryFormStateCopyWithImpl<$Res>
    implements $CategoryFormStateCopyWith<$Res> {
  _$CategoryFormStateCopyWithImpl(this._self, this._then);

  final CategoryFormState _self;
  final $Res Function(CategoryFormState) _then;

/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? original = freezed,Object? movementCount = null,Object? categories = null,Object? pillars = null,Object? type = null,Object? name = null,Object? iconKey = null,Object? color = null,Object? pillarId = freezed,Object? errors = null,Object? resets = null,Object? showErrors = null,Object? failure = freezed,}) {
  return _then(CategoryFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CategoryFormStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Category?,movementCount: null == movementCount ? _self.movementCount : movementCount // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,pillars: null == pillars ? _self.pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<Pillar>,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CategoryType,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,pillarId: freezed == pillarId ? _self.pillarId : pillarId // ignore: cast_nullable_to_non_nullable
as int?,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as Set<CategoryError>,resets: null == resets ? _self.resets : resets // ignore: cast_nullable_to_non_nullable
as int,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $CategoryCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}


/// Adds pattern-matching-related methods to [CategoryFormState].
extension CategoryFormStatePatterns on CategoryFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryFormState value)  $default,){
final _that = this;
switch (_that) {
case _CategoryFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryFormState value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CategoryFormStatus status,  Category? original,  int movementCount,  List<Category> categories,  List<Pillar> pillars,  CategoryType type,  String name,  String iconKey,  int color,  int? pillarId,  Set<CategoryError> errors,  int resets,  bool showErrors,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryFormState() when $default != null:
return $default(_that.status,_that.original,_that.movementCount,_that.categories,_that.pillars,_that.type,_that.name,_that.iconKey,_that.color,_that.pillarId,_that.errors,_that.resets,_that.showErrors,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CategoryFormStatus status,  Category? original,  int movementCount,  List<Category> categories,  List<Pillar> pillars,  CategoryType type,  String name,  String iconKey,  int color,  int? pillarId,  Set<CategoryError> errors,  int resets,  bool showErrors,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _CategoryFormState():
return $default(_that.status,_that.original,_that.movementCount,_that.categories,_that.pillars,_that.type,_that.name,_that.iconKey,_that.color,_that.pillarId,_that.errors,_that.resets,_that.showErrors,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CategoryFormStatus status,  Category? original,  int movementCount,  List<Category> categories,  List<Pillar> pillars,  CategoryType type,  String name,  String iconKey,  int color,  int? pillarId,  Set<CategoryError> errors,  int resets,  bool showErrors,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _CategoryFormState() when $default != null:
return $default(_that.status,_that.original,_that.movementCount,_that.categories,_that.pillars,_that.type,_that.name,_that.iconKey,_that.color,_that.pillarId,_that.errors,_that.resets,_that.showErrors,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryFormState extends CategoryFormState {
  const _CategoryFormState({this.status = CategoryFormStatus.loading, this.original, this.movementCount = 0,  List<Category> categories = const <Category>[],  List<Pillar> pillars = const <Pillar>[], this.type = CategoryType.expense, this.name = '', this.iconKey = '', this.color = 0, this.pillarId,  Set<CategoryError> errors = const <CategoryError>{}, this.resets = 0, this.showErrors = false, this.failure}): _categories = categories,_pillars = pillars,_errors = errors,super._();
  

@override@JsonKey() final  CategoryFormStatus status;
/// The stored category when editing; `null` when creating.
@override final  Category? original;
/// Movements of the edited category, shown before deleting it.
@override@JsonKey() final  int movementCount;
/// Every category, for unique names, colors and delete targets.
 final  List<Category> _categories;
/// Every category, for unique names, colors and delete targets.
@override@JsonKey() List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<Pillar> _pillars;
@override@JsonKey() List<Pillar> get pillars {
  if (_pillars is EqualUnmodifiableListView) return _pillars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pillars);
}

@override@JsonKey() final  CategoryType type;
@override@JsonKey() final  String name;
@override@JsonKey() final  String iconKey;
@override@JsonKey() final  int color;
@override final  int? pillarId;
 final  Set<CategoryError> _errors;
@override@JsonKey() Set<CategoryError> get errors {
  if (_errors is EqualUnmodifiableSetView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_errors);
}

/// Times the form was reset to default, so text fields refill.
@override@JsonKey() final  int resets;
/// Errors appear after the first submit, then update while typing.
@override@JsonKey() final  bool showErrors;
/// Last failure of a save, archive or delete, shown once by the UI.
@override final  Failure? failure;

/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryFormStateCopyWith<_CategoryFormState> get copyWith => __$CategoryFormStateCopyWithImpl<_CategoryFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryFormState&&(identical(other.status, status) || other.status == status)&&(identical(other.original, original) || other.original == original)&&(identical(other.movementCount, movementCount) || other.movementCount == movementCount)&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.pillars, _pillars)&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.color, color) || other.color == color)&&(identical(other.pillarId, pillarId) || other.pillarId == pillarId)&&const DeepCollectionEquality().equals(other.errors, _errors)&&(identical(other.resets, resets) || other.resets == resets)&&(identical(other.showErrors, showErrors) || other.showErrors == showErrors)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,original,movementCount,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_pillars),type,name,iconKey,color,pillarId,const DeepCollectionEquality().hash(_errors),resets,showErrors,failure);
}

@override
String toString() {
    return 'CategoryFormState(status: $status, original: $original, movementCount: $movementCount, categories: $categories, pillars: $pillars, type: $type, name: $name, iconKey: $iconKey, color: $color, pillarId: $pillarId, errors: $errors, resets: $resets, showErrors: $showErrors, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$CategoryFormStateCopyWith<$Res> implements $CategoryFormStateCopyWith<$Res> {
  factory _$CategoryFormStateCopyWith(_CategoryFormState value, $Res Function(_CategoryFormState) _then) = __$CategoryFormStateCopyWithImpl;
@override @useResult
$Res call({
 CategoryFormStatus status, Category? original, int movementCount, List<Category> categories, List<Pillar> pillars, CategoryType type, String name, String iconKey, int color, int? pillarId, Set<CategoryError> errors, int resets, bool showErrors, Failure? failure
});


@override $CategoryCopyWith<$Res>? get original;

}
/// @nodoc
class __$CategoryFormStateCopyWithImpl<$Res>
    implements _$CategoryFormStateCopyWith<$Res> {
  __$CategoryFormStateCopyWithImpl(this._self, this._then);

  final _CategoryFormState _self;
  final $Res Function(_CategoryFormState) _then;

/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? original = freezed,Object? movementCount = null,Object? categories = null,Object? pillars = null,Object? type = null,Object? name = null,Object? iconKey = null,Object? color = null,Object? pillarId = freezed,Object? errors = null,Object? resets = null,Object? showErrors = null,Object? failure = freezed,}) {
  return _then(_CategoryFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CategoryFormStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Category?,movementCount: null == movementCount ? _self.movementCount : movementCount // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,pillars: null == pillars ? _self._pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<Pillar>,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CategoryType,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,pillarId: freezed == pillarId ? _self.pillarId : pillarId // ignore: cast_nullable_to_non_nullable
as int?,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Set<CategoryError>,resets: null == resets ? _self.resets : resets // ignore: cast_nullable_to_non_nullable
as int,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $CategoryCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}

// dart format on
