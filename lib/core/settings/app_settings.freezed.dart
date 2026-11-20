// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppSettings {

 String get mainCurrencyCode; PeriodType get periodType;/// Start day of monthly periods and fallback of dynamic ones (RF-05).
 int get cutoffDay;/// Days since the last period start before Salary suggests a new one.
 int get minDaysBetweenPeriods; bool get notificationsEnabled;/// Time of every reminder, in minutes after midnight (RT-11).
 int get reminderMinutes; AppThemeMode get themeMode; BalanceFilter get balanceFilter; int get backupsToKeep;
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<AppSettings> get copyWith => _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettings&&(identical(other.mainCurrencyCode, _this.mainCurrencyCode) || other.mainCurrencyCode == _this.mainCurrencyCode)&&(identical(other.periodType, _this.periodType) || other.periodType == _this.periodType)&&(identical(other.cutoffDay, _this.cutoffDay) || other.cutoffDay == _this.cutoffDay)&&(identical(other.minDaysBetweenPeriods, _this.minDaysBetweenPeriods) || other.minDaysBetweenPeriods == _this.minDaysBetweenPeriods)&&(identical(other.notificationsEnabled, _this.notificationsEnabled) || other.notificationsEnabled == _this.notificationsEnabled)&&(identical(other.reminderMinutes, _this.reminderMinutes) || other.reminderMinutes == _this.reminderMinutes)&&(identical(other.themeMode, _this.themeMode) || other.themeMode == _this.themeMode)&&(identical(other.balanceFilter, _this.balanceFilter) || other.balanceFilter == _this.balanceFilter)&&(identical(other.backupsToKeep, _this.backupsToKeep) || other.backupsToKeep == _this.backupsToKeep));
}


@override
int get hashCode {
  final _this = this as AppSettings;
  return Object.hash(runtimeType,_this.mainCurrencyCode,_this.periodType,_this.cutoffDay,_this.minDaysBetweenPeriods,_this.notificationsEnabled,_this.reminderMinutes,_this.themeMode,_this.balanceFilter,_this.backupsToKeep);
}

@override
String toString() {
  final _this = this as AppSettings;
  return 'AppSettings(mainCurrencyCode: ${_this.mainCurrencyCode}, periodType: ${_this.periodType}, cutoffDay: ${_this.cutoffDay}, minDaysBetweenPeriods: ${_this.minDaysBetweenPeriods}, notificationsEnabled: ${_this.notificationsEnabled}, reminderMinutes: ${_this.reminderMinutes}, themeMode: ${_this.themeMode}, balanceFilter: ${_this.balanceFilter}, backupsToKeep: ${_this.backupsToKeep})';
}


}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res>  {
  factory $AppSettingsCopyWith(AppSettings value, $Res Function(AppSettings) _then) = _$AppSettingsCopyWithImpl;
@useResult
$Res call({
 String mainCurrencyCode, PeriodType periodType, int cutoffDay, int minDaysBetweenPeriods, bool notificationsEnabled, int reminderMinutes, AppThemeMode themeMode, BalanceFilter balanceFilter, int backupsToKeep
});




}
/// @nodoc
class _$AppSettingsCopyWithImpl<$Res>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mainCurrencyCode = null,Object? periodType = null,Object? cutoffDay = null,Object? minDaysBetweenPeriods = null,Object? notificationsEnabled = null,Object? reminderMinutes = null,Object? themeMode = null,Object? balanceFilter = null,Object? backupsToKeep = null,}) {
  return _then(AppSettings(
mainCurrencyCode: null == mainCurrencyCode ? _self.mainCurrencyCode : mainCurrencyCode // ignore: cast_nullable_to_non_nullable
as String,periodType: null == periodType ? _self.periodType : periodType // ignore: cast_nullable_to_non_nullable
as PeriodType,cutoffDay: null == cutoffDay ? _self.cutoffDay : cutoffDay // ignore: cast_nullable_to_non_nullable
as int,minDaysBetweenPeriods: null == minDaysBetweenPeriods ? _self.minDaysBetweenPeriods : minDaysBetweenPeriods // ignore: cast_nullable_to_non_nullable
as int,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,reminderMinutes: null == reminderMinutes ? _self.reminderMinutes : reminderMinutes // ignore: cast_nullable_to_non_nullable
as int,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,balanceFilter: null == balanceFilter ? _self.balanceFilter : balanceFilter // ignore: cast_nullable_to_non_nullable
as BalanceFilter,backupsToKeep: null == backupsToKeep ? _self.backupsToKeep : backupsToKeep // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String mainCurrencyCode,  PeriodType periodType,  int cutoffDay,  int minDaysBetweenPeriods,  bool notificationsEnabled,  int reminderMinutes,  AppThemeMode themeMode,  BalanceFilter balanceFilter,  int backupsToKeep)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.mainCurrencyCode,_that.periodType,_that.cutoffDay,_that.minDaysBetweenPeriods,_that.notificationsEnabled,_that.reminderMinutes,_that.themeMode,_that.balanceFilter,_that.backupsToKeep);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String mainCurrencyCode,  PeriodType periodType,  int cutoffDay,  int minDaysBetweenPeriods,  bool notificationsEnabled,  int reminderMinutes,  AppThemeMode themeMode,  BalanceFilter balanceFilter,  int backupsToKeep)  $default,) {final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that.mainCurrencyCode,_that.periodType,_that.cutoffDay,_that.minDaysBetweenPeriods,_that.notificationsEnabled,_that.reminderMinutes,_that.themeMode,_that.balanceFilter,_that.backupsToKeep);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String mainCurrencyCode,  PeriodType periodType,  int cutoffDay,  int minDaysBetweenPeriods,  bool notificationsEnabled,  int reminderMinutes,  AppThemeMode themeMode,  BalanceFilter balanceFilter,  int backupsToKeep)?  $default,) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.mainCurrencyCode,_that.periodType,_that.cutoffDay,_that.minDaysBetweenPeriods,_that.notificationsEnabled,_that.reminderMinutes,_that.themeMode,_that.balanceFilter,_that.backupsToKeep);case _:
  return null;

}
}

}

/// @nodoc


class _AppSettings implements AppSettings {
  const _AppSettings({this.mainCurrencyCode = 'COP', this.periodType = PeriodType.dynamic, this.cutoffDay = 27, this.minDaysBetweenPeriods = 21, this.notificationsEnabled = true, this.reminderMinutes = 8 * 60, this.themeMode = AppThemeMode.system, this.balanceFilter = BalanceFilter.both, this.backupsToKeep = 3});
  

@override@JsonKey() final  String mainCurrencyCode;
@override@JsonKey() final  PeriodType periodType;
/// Start day of monthly periods and fallback of dynamic ones (RF-05).
@override@JsonKey() final  int cutoffDay;
/// Days since the last period start before Salary suggests a new one.
@override@JsonKey() final  int minDaysBetweenPeriods;
@override@JsonKey() final  bool notificationsEnabled;
/// Time of every reminder, in minutes after midnight (RT-11).
@override@JsonKey() final  int reminderMinutes;
@override@JsonKey() final  AppThemeMode themeMode;
@override@JsonKey() final  BalanceFilter balanceFilter;
@override@JsonKey() final  int backupsToKeep;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsCopyWith<_AppSettings> get copyWith => __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettings&&(identical(other.mainCurrencyCode, mainCurrencyCode) || other.mainCurrencyCode == mainCurrencyCode)&&(identical(other.periodType, periodType) || other.periodType == periodType)&&(identical(other.cutoffDay, cutoffDay) || other.cutoffDay == cutoffDay)&&(identical(other.minDaysBetweenPeriods, minDaysBetweenPeriods) || other.minDaysBetweenPeriods == minDaysBetweenPeriods)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.reminderMinutes, reminderMinutes) || other.reminderMinutes == reminderMinutes)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.balanceFilter, balanceFilter) || other.balanceFilter == balanceFilter)&&(identical(other.backupsToKeep, backupsToKeep) || other.backupsToKeep == backupsToKeep));
}


@override
int get hashCode {
    return Object.hash(runtimeType,mainCurrencyCode,periodType,cutoffDay,minDaysBetweenPeriods,notificationsEnabled,reminderMinutes,themeMode,balanceFilter,backupsToKeep);
}

@override
String toString() {
    return 'AppSettings(mainCurrencyCode: $mainCurrencyCode, periodType: $periodType, cutoffDay: $cutoffDay, minDaysBetweenPeriods: $minDaysBetweenPeriods, notificationsEnabled: $notificationsEnabled, reminderMinutes: $reminderMinutes, themeMode: $themeMode, balanceFilter: $balanceFilter, backupsToKeep: $backupsToKeep)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res> implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(_AppSettings value, $Res Function(_AppSettings) _then) = __$AppSettingsCopyWithImpl;
@override @useResult
$Res call({
 String mainCurrencyCode, PeriodType periodType, int cutoffDay, int minDaysBetweenPeriods, bool notificationsEnabled, int reminderMinutes, AppThemeMode themeMode, BalanceFilter balanceFilter, int backupsToKeep
});




}
/// @nodoc
class __$AppSettingsCopyWithImpl<$Res>
    implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mainCurrencyCode = null,Object? periodType = null,Object? cutoffDay = null,Object? minDaysBetweenPeriods = null,Object? notificationsEnabled = null,Object? reminderMinutes = null,Object? themeMode = null,Object? balanceFilter = null,Object? backupsToKeep = null,}) {
  return _then(_AppSettings(
mainCurrencyCode: null == mainCurrencyCode ? _self.mainCurrencyCode : mainCurrencyCode // ignore: cast_nullable_to_non_nullable
as String,periodType: null == periodType ? _self.periodType : periodType // ignore: cast_nullable_to_non_nullable
as PeriodType,cutoffDay: null == cutoffDay ? _self.cutoffDay : cutoffDay // ignore: cast_nullable_to_non_nullable
as int,minDaysBetweenPeriods: null == minDaysBetweenPeriods ? _self.minDaysBetweenPeriods : minDaysBetweenPeriods // ignore: cast_nullable_to_non_nullable
as int,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,reminderMinutes: null == reminderMinutes ? _self.reminderMinutes : reminderMinutes // ignore: cast_nullable_to_non_nullable
as int,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,balanceFilter: null == balanceFilter ? _self.balanceFilter : balanceFilter // ignore: cast_nullable_to_non_nullable
as BalanceFilter,backupsToKeep: null == backupsToKeep ? _self.backupsToKeep : backupsToKeep // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
