// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debt_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DebtFormState {

 DebtFormStatus get status;/// The stored debt when editing; `null` when creating.
 Debt? get original; DebtType get type; String get name; String get iconKey; int get color; String get currencyCode;/// A debt with movements keeps its currency.
 bool get currencyLocked;/// The pending amount when it was registered.
 String get pendingText; int? get pillarId; String get installmentText; int? get dueDay; LocalDate? get dueDate; List<Pillar> get pillars; List<Currency> get currencies; Set<DebtError> get errors; bool get showErrors;/// Last failure of a save, shown once by the UI.
 Failure? get failure;
/// Create a copy of DebtFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebtFormStateCopyWith<DebtFormState> get copyWith => _$DebtFormStateCopyWithImpl<DebtFormState>(this as DebtFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DebtFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebtFormState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.original, _this.original) || other.original == _this.original)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.iconKey, _this.iconKey) || other.iconKey == _this.iconKey)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.currencyCode, _this.currencyCode) || other.currencyCode == _this.currencyCode)&&(identical(other.currencyLocked, _this.currencyLocked) || other.currencyLocked == _this.currencyLocked)&&(identical(other.pendingText, _this.pendingText) || other.pendingText == _this.pendingText)&&(identical(other.pillarId, _this.pillarId) || other.pillarId == _this.pillarId)&&(identical(other.installmentText, _this.installmentText) || other.installmentText == _this.installmentText)&&(identical(other.dueDay, _this.dueDay) || other.dueDay == _this.dueDay)&&(identical(other.dueDate, _this.dueDate) || other.dueDate == _this.dueDate)&&const DeepCollectionEquality().equals(other.pillars, _this.pillars)&&const DeepCollectionEquality().equals(other.currencies, _this.currencies)&&const DeepCollectionEquality().equals(other.errors, _this.errors)&&(identical(other.showErrors, _this.showErrors) || other.showErrors == _this.showErrors)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as DebtFormState;
  return Object.hash(runtimeType,_this.status,_this.original,_this.type,_this.name,_this.iconKey,_this.color,_this.currencyCode,_this.currencyLocked,_this.pendingText,_this.pillarId,_this.installmentText,_this.dueDay,_this.dueDate,const DeepCollectionEquality().hash(_this.pillars),const DeepCollectionEquality().hash(_this.currencies),const DeepCollectionEquality().hash(_this.errors),_this.showErrors,_this.failure);
}

@override
String toString() {
  final _this = this as DebtFormState;
  return 'DebtFormState(status: ${_this.status}, original: ${_this.original}, type: ${_this.type}, name: ${_this.name}, iconKey: ${_this.iconKey}, color: ${_this.color}, currencyCode: ${_this.currencyCode}, currencyLocked: ${_this.currencyLocked}, pendingText: ${_this.pendingText}, pillarId: ${_this.pillarId}, installmentText: ${_this.installmentText}, dueDay: ${_this.dueDay}, dueDate: ${_this.dueDate}, pillars: ${_this.pillars}, currencies: ${_this.currencies}, errors: ${_this.errors}, showErrors: ${_this.showErrors}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $DebtFormStateCopyWith<$Res>  {
  factory $DebtFormStateCopyWith(DebtFormState value, $Res Function(DebtFormState) _then) = _$DebtFormStateCopyWithImpl;
@useResult
$Res call({
 DebtFormStatus status, Debt? original, DebtType type, String name, String iconKey, int color, String currencyCode, bool currencyLocked, String pendingText, int? pillarId, String installmentText, int? dueDay, LocalDate? dueDate, List<Pillar> pillars, List<Currency> currencies, Set<DebtError> errors, bool showErrors, Failure? failure
});


$DebtCopyWith<$Res>? get original;

}
/// @nodoc
class _$DebtFormStateCopyWithImpl<$Res>
    implements $DebtFormStateCopyWith<$Res> {
  _$DebtFormStateCopyWithImpl(this._self, this._then);

  final DebtFormState _self;
  final $Res Function(DebtFormState) _then;

/// Create a copy of DebtFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? original = freezed,Object? type = null,Object? name = null,Object? iconKey = null,Object? color = null,Object? currencyCode = null,Object? currencyLocked = null,Object? pendingText = null,Object? pillarId = freezed,Object? installmentText = null,Object? dueDay = freezed,Object? dueDate = freezed,Object? pillars = null,Object? currencies = null,Object? errors = null,Object? showErrors = null,Object? failure = freezed,}) {
  return _then(DebtFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DebtFormStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Debt?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DebtType,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,currencyLocked: null == currencyLocked ? _self.currencyLocked : currencyLocked // ignore: cast_nullable_to_non_nullable
as bool,pendingText: null == pendingText ? _self.pendingText : pendingText // ignore: cast_nullable_to_non_nullable
as String,pillarId: freezed == pillarId ? _self.pillarId : pillarId // ignore: cast_nullable_to_non_nullable
as int?,installmentText: null == installmentText ? _self.installmentText : installmentText // ignore: cast_nullable_to_non_nullable
as String,dueDay: freezed == dueDay ? _self.dueDay : dueDay // ignore: cast_nullable_to_non_nullable
as int?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as LocalDate?,pillars: null == pillars ? _self.pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<Pillar>,currencies: null == currencies ? _self.currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as Set<DebtError>,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of DebtFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DebtCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $DebtCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}


/// Adds pattern-matching-related methods to [DebtFormState].
extension DebtFormStatePatterns on DebtFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebtFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebtFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebtFormState value)  $default,){
final _that = this;
switch (_that) {
case _DebtFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebtFormState value)?  $default,){
final _that = this;
switch (_that) {
case _DebtFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DebtFormStatus status,  Debt? original,  DebtType type,  String name,  String iconKey,  int color,  String currencyCode,  bool currencyLocked,  String pendingText,  int? pillarId,  String installmentText,  int? dueDay,  LocalDate? dueDate,  List<Pillar> pillars,  List<Currency> currencies,  Set<DebtError> errors,  bool showErrors,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebtFormState() when $default != null:
return $default(_that.status,_that.original,_that.type,_that.name,_that.iconKey,_that.color,_that.currencyCode,_that.currencyLocked,_that.pendingText,_that.pillarId,_that.installmentText,_that.dueDay,_that.dueDate,_that.pillars,_that.currencies,_that.errors,_that.showErrors,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DebtFormStatus status,  Debt? original,  DebtType type,  String name,  String iconKey,  int color,  String currencyCode,  bool currencyLocked,  String pendingText,  int? pillarId,  String installmentText,  int? dueDay,  LocalDate? dueDate,  List<Pillar> pillars,  List<Currency> currencies,  Set<DebtError> errors,  bool showErrors,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _DebtFormState():
return $default(_that.status,_that.original,_that.type,_that.name,_that.iconKey,_that.color,_that.currencyCode,_that.currencyLocked,_that.pendingText,_that.pillarId,_that.installmentText,_that.dueDay,_that.dueDate,_that.pillars,_that.currencies,_that.errors,_that.showErrors,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DebtFormStatus status,  Debt? original,  DebtType type,  String name,  String iconKey,  int color,  String currencyCode,  bool currencyLocked,  String pendingText,  int? pillarId,  String installmentText,  int? dueDay,  LocalDate? dueDate,  List<Pillar> pillars,  List<Currency> currencies,  Set<DebtError> errors,  bool showErrors,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _DebtFormState() when $default != null:
return $default(_that.status,_that.original,_that.type,_that.name,_that.iconKey,_that.color,_that.currencyCode,_that.currencyLocked,_that.pendingText,_that.pillarId,_that.installmentText,_that.dueDay,_that.dueDate,_that.pillars,_that.currencies,_that.errors,_that.showErrors,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _DebtFormState extends DebtFormState {
  const _DebtFormState({this.status = DebtFormStatus.loading, this.original, this.type = DebtType.iOwe, this.name = '', this.iconKey = '', this.color = 0, this.currencyCode = '', this.currencyLocked = false, this.pendingText = '', this.pillarId, this.installmentText = '', this.dueDay, this.dueDate,  List<Pillar> pillars = const <Pillar>[],  List<Currency> currencies = const <Currency>[],  Set<DebtError> errors = const <DebtError>{}, this.showErrors = false, this.failure}): _pillars = pillars,_currencies = currencies,_errors = errors,super._();
  

@override@JsonKey() final  DebtFormStatus status;
/// The stored debt when editing; `null` when creating.
@override final  Debt? original;
@override@JsonKey() final  DebtType type;
@override@JsonKey() final  String name;
@override@JsonKey() final  String iconKey;
@override@JsonKey() final  int color;
@override@JsonKey() final  String currencyCode;
/// A debt with movements keeps its currency.
@override@JsonKey() final  bool currencyLocked;
/// The pending amount when it was registered.
@override@JsonKey() final  String pendingText;
@override final  int? pillarId;
@override@JsonKey() final  String installmentText;
@override final  int? dueDay;
@override final  LocalDate? dueDate;
 final  List<Pillar> _pillars;
@override@JsonKey() List<Pillar> get pillars {
  if (_pillars is EqualUnmodifiableListView) return _pillars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pillars);
}

 final  List<Currency> _currencies;
@override@JsonKey() List<Currency> get currencies {
  if (_currencies is EqualUnmodifiableListView) return _currencies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currencies);
}

 final  Set<DebtError> _errors;
@override@JsonKey() Set<DebtError> get errors {
  if (_errors is EqualUnmodifiableSetView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_errors);
}

@override@JsonKey() final  bool showErrors;
/// Last failure of a save, shown once by the UI.
@override final  Failure? failure;

/// Create a copy of DebtFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebtFormStateCopyWith<_DebtFormState> get copyWith => __$DebtFormStateCopyWithImpl<_DebtFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebtFormState&&(identical(other.status, status) || other.status == status)&&(identical(other.original, original) || other.original == original)&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.color, color) || other.color == color)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.currencyLocked, currencyLocked) || other.currencyLocked == currencyLocked)&&(identical(other.pendingText, pendingText) || other.pendingText == pendingText)&&(identical(other.pillarId, pillarId) || other.pillarId == pillarId)&&(identical(other.installmentText, installmentText) || other.installmentText == installmentText)&&(identical(other.dueDay, dueDay) || other.dueDay == dueDay)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&const DeepCollectionEquality().equals(other.pillars, _pillars)&&const DeepCollectionEquality().equals(other.currencies, _currencies)&&const DeepCollectionEquality().equals(other.errors, _errors)&&(identical(other.showErrors, showErrors) || other.showErrors == showErrors)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,original,type,name,iconKey,color,currencyCode,currencyLocked,pendingText,pillarId,installmentText,dueDay,dueDate,const DeepCollectionEquality().hash(_pillars),const DeepCollectionEquality().hash(_currencies),const DeepCollectionEquality().hash(_errors),showErrors,failure);
}

@override
String toString() {
    return 'DebtFormState(status: $status, original: $original, type: $type, name: $name, iconKey: $iconKey, color: $color, currencyCode: $currencyCode, currencyLocked: $currencyLocked, pendingText: $pendingText, pillarId: $pillarId, installmentText: $installmentText, dueDay: $dueDay, dueDate: $dueDate, pillars: $pillars, currencies: $currencies, errors: $errors, showErrors: $showErrors, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$DebtFormStateCopyWith<$Res> implements $DebtFormStateCopyWith<$Res> {
  factory _$DebtFormStateCopyWith(_DebtFormState value, $Res Function(_DebtFormState) _then) = __$DebtFormStateCopyWithImpl;
@override @useResult
$Res call({
 DebtFormStatus status, Debt? original, DebtType type, String name, String iconKey, int color, String currencyCode, bool currencyLocked, String pendingText, int? pillarId, String installmentText, int? dueDay, LocalDate? dueDate, List<Pillar> pillars, List<Currency> currencies, Set<DebtError> errors, bool showErrors, Failure? failure
});


@override $DebtCopyWith<$Res>? get original;

}
/// @nodoc
class __$DebtFormStateCopyWithImpl<$Res>
    implements _$DebtFormStateCopyWith<$Res> {
  __$DebtFormStateCopyWithImpl(this._self, this._then);

  final _DebtFormState _self;
  final $Res Function(_DebtFormState) _then;

/// Create a copy of DebtFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? original = freezed,Object? type = null,Object? name = null,Object? iconKey = null,Object? color = null,Object? currencyCode = null,Object? currencyLocked = null,Object? pendingText = null,Object? pillarId = freezed,Object? installmentText = null,Object? dueDay = freezed,Object? dueDate = freezed,Object? pillars = null,Object? currencies = null,Object? errors = null,Object? showErrors = null,Object? failure = freezed,}) {
  return _then(_DebtFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DebtFormStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Debt?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DebtType,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,currencyLocked: null == currencyLocked ? _self.currencyLocked : currencyLocked // ignore: cast_nullable_to_non_nullable
as bool,pendingText: null == pendingText ? _self.pendingText : pendingText // ignore: cast_nullable_to_non_nullable
as String,pillarId: freezed == pillarId ? _self.pillarId : pillarId // ignore: cast_nullable_to_non_nullable
as int?,installmentText: null == installmentText ? _self.installmentText : installmentText // ignore: cast_nullable_to_non_nullable
as String,dueDay: freezed == dueDay ? _self.dueDay : dueDay // ignore: cast_nullable_to_non_nullable
as int?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as LocalDate?,pillars: null == pillars ? _self._pillars : pillars // ignore: cast_nullable_to_non_nullable
as List<Pillar>,currencies: null == currencies ? _self._currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Set<DebtError>,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of DebtFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DebtCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $DebtCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}

// dart format on
