// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_grid_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryGridState {

 CategoryGridStatus get status; MovementType get type;/// Active categories of the type, in the order of the grid.
 List<Category> get categories;/// Payees used with the type.
 List<Payee> get payees;/// Open debts the type pays (I owe) or collects (owed to me).
 List<Debt> get debts;/// Debt payment or Loan repaid, which a found debt opens.
 Category? get paymentCategory; String get query; Failure? get failure;
/// Create a copy of CategoryGridState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryGridStateCopyWith<CategoryGridState> get copyWith => _$CategoryGridStateCopyWithImpl<CategoryGridState>(this as CategoryGridState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CategoryGridState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryGridState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.type, _this.type) || other.type == _this.type)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.payees, _this.payees)&&const DeepCollectionEquality().equals(other.debts, _this.debts)&&(identical(other.paymentCategory, _this.paymentCategory) || other.paymentCategory == _this.paymentCategory)&&(identical(other.query, _this.query) || other.query == _this.query)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as CategoryGridState;
  return Object.hash(runtimeType,_this.status,_this.type,const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.payees),const DeepCollectionEquality().hash(_this.debts),_this.paymentCategory,_this.query,_this.failure);
}

@override
String toString() {
  final _this = this as CategoryGridState;
  return 'CategoryGridState(status: ${_this.status}, type: ${_this.type}, categories: ${_this.categories}, payees: ${_this.payees}, debts: ${_this.debts}, paymentCategory: ${_this.paymentCategory}, query: ${_this.query}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $CategoryGridStateCopyWith<$Res>  {
  factory $CategoryGridStateCopyWith(CategoryGridState value, $Res Function(CategoryGridState) _then) = _$CategoryGridStateCopyWithImpl;
@useResult
$Res call({
 CategoryGridStatus status, MovementType type, List<Category> categories, List<Payee> payees, List<Debt> debts, Category? paymentCategory, String query, Failure? failure
});


$CategoryCopyWith<$Res>? get paymentCategory;

}
/// @nodoc
class _$CategoryGridStateCopyWithImpl<$Res>
    implements $CategoryGridStateCopyWith<$Res> {
  _$CategoryGridStateCopyWithImpl(this._self, this._then);

  final CategoryGridState _self;
  final $Res Function(CategoryGridState) _then;

/// Create a copy of CategoryGridState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? type = null,Object? categories = null,Object? payees = null,Object? debts = null,Object? paymentCategory = freezed,Object? query = null,Object? failure = freezed,}) {
  return _then(CategoryGridState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CategoryGridStatus,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MovementType,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,payees: null == payees ? _self.payees : payees // ignore: cast_nullable_to_non_nullable
as List<Payee>,debts: null == debts ? _self.debts : debts // ignore: cast_nullable_to_non_nullable
as List<Debt>,paymentCategory: freezed == paymentCategory ? _self.paymentCategory : paymentCategory // ignore: cast_nullable_to_non_nullable
as Category?,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of CategoryGridState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res>? get paymentCategory {
    if (_self.paymentCategory == null) {
    return null;
  }

  return $CategoryCopyWith<$Res>(_self.paymentCategory!, (value) {
    return _then(_self.copyWith(paymentCategory: value));
  });
}
}


/// Adds pattern-matching-related methods to [CategoryGridState].
extension CategoryGridStatePatterns on CategoryGridState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryGridState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryGridState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryGridState value)  $default,){
final _that = this;
switch (_that) {
case _CategoryGridState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryGridState value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryGridState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CategoryGridStatus status,  MovementType type,  List<Category> categories,  List<Payee> payees,  List<Debt> debts,  Category? paymentCategory,  String query,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryGridState() when $default != null:
return $default(_that.status,_that.type,_that.categories,_that.payees,_that.debts,_that.paymentCategory,_that.query,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CategoryGridStatus status,  MovementType type,  List<Category> categories,  List<Payee> payees,  List<Debt> debts,  Category? paymentCategory,  String query,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _CategoryGridState():
return $default(_that.status,_that.type,_that.categories,_that.payees,_that.debts,_that.paymentCategory,_that.query,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CategoryGridStatus status,  MovementType type,  List<Category> categories,  List<Payee> payees,  List<Debt> debts,  Category? paymentCategory,  String query,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _CategoryGridState() when $default != null:
return $default(_that.status,_that.type,_that.categories,_that.payees,_that.debts,_that.paymentCategory,_that.query,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryGridState extends CategoryGridState {
  const _CategoryGridState({this.status = CategoryGridStatus.loading, this.type = MovementType.expense,  List<Category> categories = const <Category>[],  List<Payee> payees = const <Payee>[],  List<Debt> debts = const <Debt>[], this.paymentCategory, this.query = '', this.failure}): _categories = categories,_payees = payees,_debts = debts,super._();
  

@override@JsonKey() final  CategoryGridStatus status;
@override@JsonKey() final  MovementType type;
/// Active categories of the type, in the order of the grid.
 final  List<Category> _categories;
/// Active categories of the type, in the order of the grid.
@override@JsonKey() List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

/// Payees used with the type.
 final  List<Payee> _payees;
/// Payees used with the type.
@override@JsonKey() List<Payee> get payees {
  if (_payees is EqualUnmodifiableListView) return _payees;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payees);
}

/// Open debts the type pays (I owe) or collects (owed to me).
 final  List<Debt> _debts;
/// Open debts the type pays (I owe) or collects (owed to me).
@override@JsonKey() List<Debt> get debts {
  if (_debts is EqualUnmodifiableListView) return _debts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_debts);
}

/// Debt payment or Loan repaid, which a found debt opens.
@override final  Category? paymentCategory;
@override@JsonKey() final  String query;
@override final  Failure? failure;

/// Create a copy of CategoryGridState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryGridStateCopyWith<_CategoryGridState> get copyWith => __$CategoryGridStateCopyWithImpl<_CategoryGridState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryGridState&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.payees, _payees)&&const DeepCollectionEquality().equals(other.debts, _debts)&&(identical(other.paymentCategory, paymentCategory) || other.paymentCategory == paymentCategory)&&(identical(other.query, query) || other.query == query)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,type,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_payees),const DeepCollectionEquality().hash(_debts),paymentCategory,query,failure);
}

@override
String toString() {
    return 'CategoryGridState(status: $status, type: $type, categories: $categories, payees: $payees, debts: $debts, paymentCategory: $paymentCategory, query: $query, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$CategoryGridStateCopyWith<$Res> implements $CategoryGridStateCopyWith<$Res> {
  factory _$CategoryGridStateCopyWith(_CategoryGridState value, $Res Function(_CategoryGridState) _then) = __$CategoryGridStateCopyWithImpl;
@override @useResult
$Res call({
 CategoryGridStatus status, MovementType type, List<Category> categories, List<Payee> payees, List<Debt> debts, Category? paymentCategory, String query, Failure? failure
});


@override $CategoryCopyWith<$Res>? get paymentCategory;

}
/// @nodoc
class __$CategoryGridStateCopyWithImpl<$Res>
    implements _$CategoryGridStateCopyWith<$Res> {
  __$CategoryGridStateCopyWithImpl(this._self, this._then);

  final _CategoryGridState _self;
  final $Res Function(_CategoryGridState) _then;

/// Create a copy of CategoryGridState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? type = null,Object? categories = null,Object? payees = null,Object? debts = null,Object? paymentCategory = freezed,Object? query = null,Object? failure = freezed,}) {
  return _then(_CategoryGridState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CategoryGridStatus,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MovementType,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,payees: null == payees ? _self._payees : payees // ignore: cast_nullable_to_non_nullable
as List<Payee>,debts: null == debts ? _self._debts : debts // ignore: cast_nullable_to_non_nullable
as List<Debt>,paymentCategory: freezed == paymentCategory ? _self.paymentCategory : paymentCategory // ignore: cast_nullable_to_non_nullable
as Category?,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of CategoryGridState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res>? get paymentCategory {
    if (_self.paymentCategory == null) {
    return null;
  }

  return $CategoryCopyWith<$Res>(_self.paymentCategory!, (value) {
    return _then(_self.copyWith(paymentCategory: value));
  });
}
}

// dart format on
