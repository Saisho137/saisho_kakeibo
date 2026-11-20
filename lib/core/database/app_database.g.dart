// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CurrenciesTable extends Currencies
    with TableInfo<$CurrenciesTable, CurrencyRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CurrenciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 4,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _decimalsMeta = const VerificationMeta(
    'decimals',
  );
  @override
  late final GeneratedColumn<int> decimals = GeneratedColumn<int>(
    'decimals',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thousandsSeparatorMeta =
      const VerificationMeta('thousandsSeparator');
  @override
  late final GeneratedColumn<String> thousandsSeparator =
      GeneratedColumn<String>(
        'thousands_separator',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 1),
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _decimalSeparatorMeta = const VerificationMeta(
    'decimalSeparator',
  );
  @override
  late final GeneratedColumn<String> decimalSeparator = GeneratedColumn<String>(
    'decimal_separator',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 1,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    code,
    symbol,
    decimals,
    thousandsSeparator,
    decimalSeparator,
    isBuiltIn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'currencies';
  @override
  VerificationContext validateIntegrity(
    Insertable<CurrencyRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('decimals')) {
      context.handle(
        _decimalsMeta,
        decimals.isAcceptableOrUnknown(data['decimals']!, _decimalsMeta),
      );
    } else if (isInserting) {
      context.missing(_decimalsMeta);
    }
    if (data.containsKey('thousands_separator')) {
      context.handle(
        _thousandsSeparatorMeta,
        thousandsSeparator.isAcceptableOrUnknown(
          data['thousands_separator']!,
          _thousandsSeparatorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_thousandsSeparatorMeta);
    }
    if (data.containsKey('decimal_separator')) {
      context.handle(
        _decimalSeparatorMeta,
        decimalSeparator.isAcceptableOrUnknown(
          data['decimal_separator']!,
          _decimalSeparatorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_decimalSeparatorMeta);
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  CurrencyRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CurrencyRow(
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      decimals: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}decimals'],
      )!,
      thousandsSeparator: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thousands_separator'],
      )!,
      decimalSeparator: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decimal_separator'],
      )!,
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
    );
  }

  @override
  $CurrenciesTable createAlias(String alias) {
    return $CurrenciesTable(attachedDatabase, alias);
  }
}

class CurrencyRow extends DataClass implements Insertable<CurrencyRow> {
  final String code;
  final String symbol;

  /// Fixed at creation: it defines the minor unit of every stored amount.
  final int decimals;
  final String thousandsSeparator;
  final String decimalSeparator;
  final bool isBuiltIn;
  const CurrencyRow({
    required this.code,
    required this.symbol,
    required this.decimals,
    required this.thousandsSeparator,
    required this.decimalSeparator,
    required this.isBuiltIn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['symbol'] = Variable<String>(symbol);
    map['decimals'] = Variable<int>(decimals);
    map['thousands_separator'] = Variable<String>(thousandsSeparator);
    map['decimal_separator'] = Variable<String>(decimalSeparator);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    return map;
  }

  CurrenciesCompanion toCompanion(bool nullToAbsent) {
    return CurrenciesCompanion(
      code: Value(code),
      symbol: Value(symbol),
      decimals: Value(decimals),
      thousandsSeparator: Value(thousandsSeparator),
      decimalSeparator: Value(decimalSeparator),
      isBuiltIn: Value(isBuiltIn),
    );
  }

  factory CurrencyRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CurrencyRow(
      code: serializer.fromJson<String>(json['code']),
      symbol: serializer.fromJson<String>(json['symbol']),
      decimals: serializer.fromJson<int>(json['decimals']),
      thousandsSeparator: serializer.fromJson<String>(
        json['thousandsSeparator'],
      ),
      decimalSeparator: serializer.fromJson<String>(json['decimalSeparator']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'symbol': serializer.toJson<String>(symbol),
      'decimals': serializer.toJson<int>(decimals),
      'thousandsSeparator': serializer.toJson<String>(thousandsSeparator),
      'decimalSeparator': serializer.toJson<String>(decimalSeparator),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
    };
  }

  CurrencyRow copyWith({
    String? code,
    String? symbol,
    int? decimals,
    String? thousandsSeparator,
    String? decimalSeparator,
    bool? isBuiltIn,
  }) => CurrencyRow(
    code: code ?? this.code,
    symbol: symbol ?? this.symbol,
    decimals: decimals ?? this.decimals,
    thousandsSeparator: thousandsSeparator ?? this.thousandsSeparator,
    decimalSeparator: decimalSeparator ?? this.decimalSeparator,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
  );
  CurrencyRow copyWithCompanion(CurrenciesCompanion data) {
    return CurrencyRow(
      code: data.code.present ? data.code.value : this.code,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      decimals: data.decimals.present ? data.decimals.value : this.decimals,
      thousandsSeparator: data.thousandsSeparator.present
          ? data.thousandsSeparator.value
          : this.thousandsSeparator,
      decimalSeparator: data.decimalSeparator.present
          ? data.decimalSeparator.value
          : this.decimalSeparator,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CurrencyRow(')
          ..write('code: $code, ')
          ..write('symbol: $symbol, ')
          ..write('decimals: $decimals, ')
          ..write('thousandsSeparator: $thousandsSeparator, ')
          ..write('decimalSeparator: $decimalSeparator, ')
          ..write('isBuiltIn: $isBuiltIn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    code,
    symbol,
    decimals,
    thousandsSeparator,
    decimalSeparator,
    isBuiltIn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CurrencyRow &&
          other.code == this.code &&
          other.symbol == this.symbol &&
          other.decimals == this.decimals &&
          other.thousandsSeparator == this.thousandsSeparator &&
          other.decimalSeparator == this.decimalSeparator &&
          other.isBuiltIn == this.isBuiltIn);
}

class CurrenciesCompanion extends UpdateCompanion<CurrencyRow> {
  final Value<String> code;
  final Value<String> symbol;
  final Value<int> decimals;
  final Value<String> thousandsSeparator;
  final Value<String> decimalSeparator;
  final Value<bool> isBuiltIn;
  final Value<int> rowid;
  const CurrenciesCompanion({
    this.code = const Value.absent(),
    this.symbol = const Value.absent(),
    this.decimals = const Value.absent(),
    this.thousandsSeparator = const Value.absent(),
    this.decimalSeparator = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CurrenciesCompanion.insert({
    required String code,
    required String symbol,
    required int decimals,
    required String thousandsSeparator,
    required String decimalSeparator,
    this.isBuiltIn = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       symbol = Value(symbol),
       decimals = Value(decimals),
       thousandsSeparator = Value(thousandsSeparator),
       decimalSeparator = Value(decimalSeparator);
  static Insertable<CurrencyRow> custom({
    Expression<String>? code,
    Expression<String>? symbol,
    Expression<int>? decimals,
    Expression<String>? thousandsSeparator,
    Expression<String>? decimalSeparator,
    Expression<bool>? isBuiltIn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (symbol != null) 'symbol': symbol,
      if (decimals != null) 'decimals': decimals,
      if (thousandsSeparator != null) 'thousands_separator': thousandsSeparator,
      if (decimalSeparator != null) 'decimal_separator': decimalSeparator,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CurrenciesCompanion copyWith({
    Value<String>? code,
    Value<String>? symbol,
    Value<int>? decimals,
    Value<String>? thousandsSeparator,
    Value<String>? decimalSeparator,
    Value<bool>? isBuiltIn,
    Value<int>? rowid,
  }) {
    return CurrenciesCompanion(
      code: code ?? this.code,
      symbol: symbol ?? this.symbol,
      decimals: decimals ?? this.decimals,
      thousandsSeparator: thousandsSeparator ?? this.thousandsSeparator,
      decimalSeparator: decimalSeparator ?? this.decimalSeparator,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (decimals.present) {
      map['decimals'] = Variable<int>(decimals.value);
    }
    if (thousandsSeparator.present) {
      map['thousands_separator'] = Variable<String>(thousandsSeparator.value);
    }
    if (decimalSeparator.present) {
      map['decimal_separator'] = Variable<String>(decimalSeparator.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CurrenciesCompanion(')
          ..write('code: $code, ')
          ..write('symbol: $symbol, ')
          ..write('decimals: $decimals, ')
          ..write('thousandsSeparator: $thousandsSeparator, ')
          ..write('decimalSeparator: $decimalSeparator, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTableTable extends SettingsTable
    with TableInfo<$SettingsTableTable, SettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    check: () => id.equals(1),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mainCurrencyCodeMeta = const VerificationMeta(
    'mainCurrencyCode',
  );
  @override
  late final GeneratedColumn<String> mainCurrencyCode = GeneratedColumn<String>(
    'main_currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES currencies (code)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<PeriodType, String> periodType =
      GeneratedColumn<String>(
        'period_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PeriodType>($SettingsTableTable.$converterperiodType);
  static const VerificationMeta _cutoffDayMeta = const VerificationMeta(
    'cutoffDay',
  );
  @override
  late final GeneratedColumn<int> cutoffDay = GeneratedColumn<int>(
    'cutoff_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minDaysBetweenPeriodsMeta =
      const VerificationMeta('minDaysBetweenPeriods');
  @override
  late final GeneratedColumn<int> minDaysBetweenPeriods = GeneratedColumn<int>(
    'min_days_between_periods',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
    'notifications_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notifications_enabled" IN (0, 1))',
    ),
  );
  static const VerificationMeta _reminderMinutesMeta = const VerificationMeta(
    'reminderMinutes',
  );
  @override
  late final GeneratedColumn<int> reminderMinutes = GeneratedColumn<int>(
    'reminder_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AppThemeMode, String> themeMode =
      GeneratedColumn<String>(
        'theme_mode',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AppThemeMode>($SettingsTableTable.$converterthemeMode);
  @override
  late final GeneratedColumnWithTypeConverter<BalanceFilter, String>
  balanceFilter = GeneratedColumn<String>(
    'balance_filter',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<BalanceFilter>($SettingsTableTable.$converterbalanceFilter);
  static const VerificationMeta _backupsToKeepMeta = const VerificationMeta(
    'backupsToKeep',
  );
  @override
  late final GeneratedColumn<int> backupsToKeep = GeneratedColumn<int>(
    'backups_to_keep',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mainCurrencyCode,
    periodType,
    cutoffDay,
    minDaysBetweenPeriods,
    notificationsEnabled,
    reminderMinutes,
    themeMode,
    balanceFilter,
    backupsToKeep,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('main_currency_code')) {
      context.handle(
        _mainCurrencyCodeMeta,
        mainCurrencyCode.isAcceptableOrUnknown(
          data['main_currency_code']!,
          _mainCurrencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mainCurrencyCodeMeta);
    }
    if (data.containsKey('cutoff_day')) {
      context.handle(
        _cutoffDayMeta,
        cutoffDay.isAcceptableOrUnknown(data['cutoff_day']!, _cutoffDayMeta),
      );
    } else if (isInserting) {
      context.missing(_cutoffDayMeta);
    }
    if (data.containsKey('min_days_between_periods')) {
      context.handle(
        _minDaysBetweenPeriodsMeta,
        minDaysBetweenPeriods.isAcceptableOrUnknown(
          data['min_days_between_periods']!,
          _minDaysBetweenPeriodsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_minDaysBetweenPeriodsMeta);
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
        _notificationsEnabledMeta,
        notificationsEnabled.isAcceptableOrUnknown(
          data['notifications_enabled']!,
          _notificationsEnabledMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_notificationsEnabledMeta);
    }
    if (data.containsKey('reminder_minutes')) {
      context.handle(
        _reminderMinutesMeta,
        reminderMinutes.isAcceptableOrUnknown(
          data['reminder_minutes']!,
          _reminderMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reminderMinutesMeta);
    }
    if (data.containsKey('backups_to_keep')) {
      context.handle(
        _backupsToKeepMeta,
        backupsToKeep.isAcceptableOrUnknown(
          data['backups_to_keep']!,
          _backupsToKeepMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_backupsToKeepMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mainCurrencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}main_currency_code'],
      )!,
      periodType: $SettingsTableTable.$converterperiodType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}period_type'],
        )!,
      ),
      cutoffDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cutoff_day'],
      )!,
      minDaysBetweenPeriods: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_days_between_periods'],
      )!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notifications_enabled'],
      )!,
      reminderMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_minutes'],
      )!,
      themeMode: $SettingsTableTable.$converterthemeMode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}theme_mode'],
        )!,
      ),
      balanceFilter: $SettingsTableTable.$converterbalanceFilter.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}balance_filter'],
        )!,
      ),
      backupsToKeep: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}backups_to_keep'],
      )!,
    );
  }

  @override
  $SettingsTableTable createAlias(String alias) {
    return $SettingsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PeriodType, String, String> $converterperiodType =
      const EnumNameConverter<PeriodType>(PeriodType.values);
  static JsonTypeConverter2<AppThemeMode, String, String> $converterthemeMode =
      const EnumNameConverter<AppThemeMode>(AppThemeMode.values);
  static JsonTypeConverter2<BalanceFilter, String, String>
  $converterbalanceFilter = const EnumNameConverter<BalanceFilter>(
    BalanceFilter.values,
  );
}

class SettingsRow extends DataClass implements Insertable<SettingsRow> {
  /// Always 1: the table holds exactly one row.
  final int id;
  final String mainCurrencyCode;
  final PeriodType periodType;
  final int cutoffDay;
  final int minDaysBetweenPeriods;
  final bool notificationsEnabled;
  final int reminderMinutes;
  final AppThemeMode themeMode;
  final BalanceFilter balanceFilter;
  final int backupsToKeep;
  const SettingsRow({
    required this.id,
    required this.mainCurrencyCode,
    required this.periodType,
    required this.cutoffDay,
    required this.minDaysBetweenPeriods,
    required this.notificationsEnabled,
    required this.reminderMinutes,
    required this.themeMode,
    required this.balanceFilter,
    required this.backupsToKeep,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['main_currency_code'] = Variable<String>(mainCurrencyCode);
    {
      map['period_type'] = Variable<String>(
        $SettingsTableTable.$converterperiodType.toSql(periodType),
      );
    }
    map['cutoff_day'] = Variable<int>(cutoffDay);
    map['min_days_between_periods'] = Variable<int>(minDaysBetweenPeriods);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    map['reminder_minutes'] = Variable<int>(reminderMinutes);
    {
      map['theme_mode'] = Variable<String>(
        $SettingsTableTable.$converterthemeMode.toSql(themeMode),
      );
    }
    {
      map['balance_filter'] = Variable<String>(
        $SettingsTableTable.$converterbalanceFilter.toSql(balanceFilter),
      );
    }
    map['backups_to_keep'] = Variable<int>(backupsToKeep);
    return map;
  }

  SettingsTableCompanion toCompanion(bool nullToAbsent) {
    return SettingsTableCompanion(
      id: Value(id),
      mainCurrencyCode: Value(mainCurrencyCode),
      periodType: Value(periodType),
      cutoffDay: Value(cutoffDay),
      minDaysBetweenPeriods: Value(minDaysBetweenPeriods),
      notificationsEnabled: Value(notificationsEnabled),
      reminderMinutes: Value(reminderMinutes),
      themeMode: Value(themeMode),
      balanceFilter: Value(balanceFilter),
      backupsToKeep: Value(backupsToKeep),
    );
  }

  factory SettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsRow(
      id: serializer.fromJson<int>(json['id']),
      mainCurrencyCode: serializer.fromJson<String>(json['mainCurrencyCode']),
      periodType: $SettingsTableTable.$converterperiodType.fromJson(
        serializer.fromJson<String>(json['periodType']),
      ),
      cutoffDay: serializer.fromJson<int>(json['cutoffDay']),
      minDaysBetweenPeriods: serializer.fromJson<int>(
        json['minDaysBetweenPeriods'],
      ),
      notificationsEnabled: serializer.fromJson<bool>(
        json['notificationsEnabled'],
      ),
      reminderMinutes: serializer.fromJson<int>(json['reminderMinutes']),
      themeMode: $SettingsTableTable.$converterthemeMode.fromJson(
        serializer.fromJson<String>(json['themeMode']),
      ),
      balanceFilter: $SettingsTableTable.$converterbalanceFilter.fromJson(
        serializer.fromJson<String>(json['balanceFilter']),
      ),
      backupsToKeep: serializer.fromJson<int>(json['backupsToKeep']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mainCurrencyCode': serializer.toJson<String>(mainCurrencyCode),
      'periodType': serializer.toJson<String>(
        $SettingsTableTable.$converterperiodType.toJson(periodType),
      ),
      'cutoffDay': serializer.toJson<int>(cutoffDay),
      'minDaysBetweenPeriods': serializer.toJson<int>(minDaysBetweenPeriods),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'reminderMinutes': serializer.toJson<int>(reminderMinutes),
      'themeMode': serializer.toJson<String>(
        $SettingsTableTable.$converterthemeMode.toJson(themeMode),
      ),
      'balanceFilter': serializer.toJson<String>(
        $SettingsTableTable.$converterbalanceFilter.toJson(balanceFilter),
      ),
      'backupsToKeep': serializer.toJson<int>(backupsToKeep),
    };
  }

  SettingsRow copyWith({
    int? id,
    String? mainCurrencyCode,
    PeriodType? periodType,
    int? cutoffDay,
    int? minDaysBetweenPeriods,
    bool? notificationsEnabled,
    int? reminderMinutes,
    AppThemeMode? themeMode,
    BalanceFilter? balanceFilter,
    int? backupsToKeep,
  }) => SettingsRow(
    id: id ?? this.id,
    mainCurrencyCode: mainCurrencyCode ?? this.mainCurrencyCode,
    periodType: periodType ?? this.periodType,
    cutoffDay: cutoffDay ?? this.cutoffDay,
    minDaysBetweenPeriods: minDaysBetweenPeriods ?? this.minDaysBetweenPeriods,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    reminderMinutes: reminderMinutes ?? this.reminderMinutes,
    themeMode: themeMode ?? this.themeMode,
    balanceFilter: balanceFilter ?? this.balanceFilter,
    backupsToKeep: backupsToKeep ?? this.backupsToKeep,
  );
  SettingsRow copyWithCompanion(SettingsTableCompanion data) {
    return SettingsRow(
      id: data.id.present ? data.id.value : this.id,
      mainCurrencyCode: data.mainCurrencyCode.present
          ? data.mainCurrencyCode.value
          : this.mainCurrencyCode,
      periodType: data.periodType.present
          ? data.periodType.value
          : this.periodType,
      cutoffDay: data.cutoffDay.present ? data.cutoffDay.value : this.cutoffDay,
      minDaysBetweenPeriods: data.minDaysBetweenPeriods.present
          ? data.minDaysBetweenPeriods.value
          : this.minDaysBetweenPeriods,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      reminderMinutes: data.reminderMinutes.present
          ? data.reminderMinutes.value
          : this.reminderMinutes,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      balanceFilter: data.balanceFilter.present
          ? data.balanceFilter.value
          : this.balanceFilter,
      backupsToKeep: data.backupsToKeep.present
          ? data.backupsToKeep.value
          : this.backupsToKeep,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsRow(')
          ..write('id: $id, ')
          ..write('mainCurrencyCode: $mainCurrencyCode, ')
          ..write('periodType: $periodType, ')
          ..write('cutoffDay: $cutoffDay, ')
          ..write('minDaysBetweenPeriods: $minDaysBetweenPeriods, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('reminderMinutes: $reminderMinutes, ')
          ..write('themeMode: $themeMode, ')
          ..write('balanceFilter: $balanceFilter, ')
          ..write('backupsToKeep: $backupsToKeep')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mainCurrencyCode,
    periodType,
    cutoffDay,
    minDaysBetweenPeriods,
    notificationsEnabled,
    reminderMinutes,
    themeMode,
    balanceFilter,
    backupsToKeep,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsRow &&
          other.id == this.id &&
          other.mainCurrencyCode == this.mainCurrencyCode &&
          other.periodType == this.periodType &&
          other.cutoffDay == this.cutoffDay &&
          other.minDaysBetweenPeriods == this.minDaysBetweenPeriods &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.reminderMinutes == this.reminderMinutes &&
          other.themeMode == this.themeMode &&
          other.balanceFilter == this.balanceFilter &&
          other.backupsToKeep == this.backupsToKeep);
}

class SettingsTableCompanion extends UpdateCompanion<SettingsRow> {
  final Value<int> id;
  final Value<String> mainCurrencyCode;
  final Value<PeriodType> periodType;
  final Value<int> cutoffDay;
  final Value<int> minDaysBetweenPeriods;
  final Value<bool> notificationsEnabled;
  final Value<int> reminderMinutes;
  final Value<AppThemeMode> themeMode;
  final Value<BalanceFilter> balanceFilter;
  final Value<int> backupsToKeep;
  const SettingsTableCompanion({
    this.id = const Value.absent(),
    this.mainCurrencyCode = const Value.absent(),
    this.periodType = const Value.absent(),
    this.cutoffDay = const Value.absent(),
    this.minDaysBetweenPeriods = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.reminderMinutes = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.balanceFilter = const Value.absent(),
    this.backupsToKeep = const Value.absent(),
  });
  SettingsTableCompanion.insert({
    this.id = const Value.absent(),
    required String mainCurrencyCode,
    required PeriodType periodType,
    required int cutoffDay,
    required int minDaysBetweenPeriods,
    required bool notificationsEnabled,
    required int reminderMinutes,
    required AppThemeMode themeMode,
    required BalanceFilter balanceFilter,
    required int backupsToKeep,
  }) : mainCurrencyCode = Value(mainCurrencyCode),
       periodType = Value(periodType),
       cutoffDay = Value(cutoffDay),
       minDaysBetweenPeriods = Value(minDaysBetweenPeriods),
       notificationsEnabled = Value(notificationsEnabled),
       reminderMinutes = Value(reminderMinutes),
       themeMode = Value(themeMode),
       balanceFilter = Value(balanceFilter),
       backupsToKeep = Value(backupsToKeep);
  static Insertable<SettingsRow> custom({
    Expression<int>? id,
    Expression<String>? mainCurrencyCode,
    Expression<String>? periodType,
    Expression<int>? cutoffDay,
    Expression<int>? minDaysBetweenPeriods,
    Expression<bool>? notificationsEnabled,
    Expression<int>? reminderMinutes,
    Expression<String>? themeMode,
    Expression<String>? balanceFilter,
    Expression<int>? backupsToKeep,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mainCurrencyCode != null) 'main_currency_code': mainCurrencyCode,
      if (periodType != null) 'period_type': periodType,
      if (cutoffDay != null) 'cutoff_day': cutoffDay,
      if (minDaysBetweenPeriods != null)
        'min_days_between_periods': minDaysBetweenPeriods,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (reminderMinutes != null) 'reminder_minutes': reminderMinutes,
      if (themeMode != null) 'theme_mode': themeMode,
      if (balanceFilter != null) 'balance_filter': balanceFilter,
      if (backupsToKeep != null) 'backups_to_keep': backupsToKeep,
    });
  }

  SettingsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? mainCurrencyCode,
    Value<PeriodType>? periodType,
    Value<int>? cutoffDay,
    Value<int>? minDaysBetweenPeriods,
    Value<bool>? notificationsEnabled,
    Value<int>? reminderMinutes,
    Value<AppThemeMode>? themeMode,
    Value<BalanceFilter>? balanceFilter,
    Value<int>? backupsToKeep,
  }) {
    return SettingsTableCompanion(
      id: id ?? this.id,
      mainCurrencyCode: mainCurrencyCode ?? this.mainCurrencyCode,
      periodType: periodType ?? this.periodType,
      cutoffDay: cutoffDay ?? this.cutoffDay,
      minDaysBetweenPeriods:
          minDaysBetweenPeriods ?? this.minDaysBetweenPeriods,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      reminderMinutes: reminderMinutes ?? this.reminderMinutes,
      themeMode: themeMode ?? this.themeMode,
      balanceFilter: balanceFilter ?? this.balanceFilter,
      backupsToKeep: backupsToKeep ?? this.backupsToKeep,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mainCurrencyCode.present) {
      map['main_currency_code'] = Variable<String>(mainCurrencyCode.value);
    }
    if (periodType.present) {
      map['period_type'] = Variable<String>(
        $SettingsTableTable.$converterperiodType.toSql(periodType.value),
      );
    }
    if (cutoffDay.present) {
      map['cutoff_day'] = Variable<int>(cutoffDay.value);
    }
    if (minDaysBetweenPeriods.present) {
      map['min_days_between_periods'] = Variable<int>(
        minDaysBetweenPeriods.value,
      );
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (reminderMinutes.present) {
      map['reminder_minutes'] = Variable<int>(reminderMinutes.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(
        $SettingsTableTable.$converterthemeMode.toSql(themeMode.value),
      );
    }
    if (balanceFilter.present) {
      map['balance_filter'] = Variable<String>(
        $SettingsTableTable.$converterbalanceFilter.toSql(balanceFilter.value),
      );
    }
    if (backupsToKeep.present) {
      map['backups_to_keep'] = Variable<int>(backupsToKeep.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('mainCurrencyCode: $mainCurrencyCode, ')
          ..write('periodType: $periodType, ')
          ..write('cutoffDay: $cutoffDay, ')
          ..write('minDaysBetweenPeriods: $minDaysBetweenPeriods, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('reminderMinutes: $reminderMinutes, ')
          ..write('themeMode: $themeMode, ')
          ..write('balanceFilter: $balanceFilter, ')
          ..write('backupsToKeep: $backupsToKeep')
          ..write(')'))
        .toString();
  }
}

class $AccountsTable extends Accounts
    with TableInfo<$AccountsTable, AccountRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AccountType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AccountType>($AccountsTable.$convertertype);
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES currencies (code)',
    ),
  );
  static const VerificationMeta _openingBalanceMeta = const VerificationMeta(
    'openingBalance',
  );
  @override
  late final GeneratedColumn<int> openingBalance = GeneratedColumn<int>(
    'opening_balance',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LocalDate, String> openingDate =
      GeneratedColumn<String>(
        'opening_date',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LocalDate>($AccountsTable.$converteropeningDate);
  static const VerificationMeta _includeInBalanceMeta = const VerificationMeta(
    'includeInBalance',
  );
  @override
  late final GeneratedColumn<bool> includeInBalance = GeneratedColumn<bool>(
    'include_in_balance',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("include_in_balance" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isMainMeta = const VerificationMeta('isMain');
  @override
  late final GeneratedColumn<bool> isMain = GeneratedColumn<bool>(
    'is_main',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_main" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _parentAccountIdMeta = const VerificationMeta(
    'parentAccountId',
  );
  @override
  late final GeneratedColumn<int> parentAccountId = GeneratedColumn<int>(
    'parent_account_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _creditLimitMeta = const VerificationMeta(
    'creditLimit',
  );
  @override
  late final GeneratedColumn<int> creditLimit = GeneratedColumn<int>(
    'credit_limit',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentDayMeta = const VerificationMeta(
    'paymentDay',
  );
  @override
  late final GeneratedColumn<int> paymentDay = GeneratedColumn<int>(
    'payment_day',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    iconKey,
    color,
    type,
    currencyCode,
    openingBalance,
    openingDate,
    includeInBalance,
    isMain,
    parentAccountId,
    creditLimit,
    paymentDay,
    sortOrder,
    isArchived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_iconKeyMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('opening_balance')) {
      context.handle(
        _openingBalanceMeta,
        openingBalance.isAcceptableOrUnknown(
          data['opening_balance']!,
          _openingBalanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_openingBalanceMeta);
    }
    if (data.containsKey('include_in_balance')) {
      context.handle(
        _includeInBalanceMeta,
        includeInBalance.isAcceptableOrUnknown(
          data['include_in_balance']!,
          _includeInBalanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_includeInBalanceMeta);
    }
    if (data.containsKey('is_main')) {
      context.handle(
        _isMainMeta,
        isMain.isAcceptableOrUnknown(data['is_main']!, _isMainMeta),
      );
    }
    if (data.containsKey('parent_account_id')) {
      context.handle(
        _parentAccountIdMeta,
        parentAccountId.isAcceptableOrUnknown(
          data['parent_account_id']!,
          _parentAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('credit_limit')) {
      context.handle(
        _creditLimitMeta,
        creditLimit.isAcceptableOrUnknown(
          data['credit_limit']!,
          _creditLimitMeta,
        ),
      );
    }
    if (data.containsKey('payment_day')) {
      context.handle(
        _paymentDayMeta,
        paymentDay.isAcceptableOrUnknown(data['payment_day']!, _paymentDayMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      type: $AccountsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      openingBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}opening_balance'],
      )!,
      openingDate: $AccountsTable.$converteropeningDate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}opening_date'],
        )!,
      ),
      includeInBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}include_in_balance'],
      )!,
      isMain: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_main'],
      )!,
      parentAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parent_account_id'],
      ),
      creditLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}credit_limit'],
      ),
      paymentDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payment_day'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AccountType, String, String> $convertertype =
      const EnumNameConverter<AccountType>(AccountType.values);
  static TypeConverter<LocalDate, String> $converteropeningDate =
      const LocalDateConverter();
}

class AccountRow extends DataClass implements Insertable<AccountRow> {
  final int id;
  final String name;
  final String iconKey;
  final int color;
  final AccountType type;
  final String currencyCode;
  final int openingBalance;
  final LocalDate openingDate;
  final bool includeInBalance;
  final bool isMain;
  final int? parentAccountId;
  final int? creditLimit;
  final int? paymentDay;
  final int sortOrder;
  final bool isArchived;
  const AccountRow({
    required this.id,
    required this.name,
    required this.iconKey,
    required this.color,
    required this.type,
    required this.currencyCode,
    required this.openingBalance,
    required this.openingDate,
    required this.includeInBalance,
    required this.isMain,
    this.parentAccountId,
    this.creditLimit,
    this.paymentDay,
    required this.sortOrder,
    required this.isArchived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon_key'] = Variable<String>(iconKey);
    map['color'] = Variable<int>(color);
    {
      map['type'] = Variable<String>($AccountsTable.$convertertype.toSql(type));
    }
    map['currency_code'] = Variable<String>(currencyCode);
    map['opening_balance'] = Variable<int>(openingBalance);
    {
      map['opening_date'] = Variable<String>(
        $AccountsTable.$converteropeningDate.toSql(openingDate),
      );
    }
    map['include_in_balance'] = Variable<bool>(includeInBalance);
    map['is_main'] = Variable<bool>(isMain);
    if (!nullToAbsent || parentAccountId != null) {
      map['parent_account_id'] = Variable<int>(parentAccountId);
    }
    if (!nullToAbsent || creditLimit != null) {
      map['credit_limit'] = Variable<int>(creditLimit);
    }
    if (!nullToAbsent || paymentDay != null) {
      map['payment_day'] = Variable<int>(paymentDay);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_archived'] = Variable<bool>(isArchived);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      name: Value(name),
      iconKey: Value(iconKey),
      color: Value(color),
      type: Value(type),
      currencyCode: Value(currencyCode),
      openingBalance: Value(openingBalance),
      openingDate: Value(openingDate),
      includeInBalance: Value(includeInBalance),
      isMain: Value(isMain),
      parentAccountId: parentAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentAccountId),
      creditLimit: creditLimit == null && nullToAbsent
          ? const Value.absent()
          : Value(creditLimit),
      paymentDay: paymentDay == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentDay),
      sortOrder: Value(sortOrder),
      isArchived: Value(isArchived),
    );
  }

  factory AccountRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      iconKey: serializer.fromJson<String>(json['iconKey']),
      color: serializer.fromJson<int>(json['color']),
      type: $AccountsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      openingBalance: serializer.fromJson<int>(json['openingBalance']),
      openingDate: serializer.fromJson<LocalDate>(json['openingDate']),
      includeInBalance: serializer.fromJson<bool>(json['includeInBalance']),
      isMain: serializer.fromJson<bool>(json['isMain']),
      parentAccountId: serializer.fromJson<int?>(json['parentAccountId']),
      creditLimit: serializer.fromJson<int?>(json['creditLimit']),
      paymentDay: serializer.fromJson<int?>(json['paymentDay']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'iconKey': serializer.toJson<String>(iconKey),
      'color': serializer.toJson<int>(color),
      'type': serializer.toJson<String>(
        $AccountsTable.$convertertype.toJson(type),
      ),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'openingBalance': serializer.toJson<int>(openingBalance),
      'openingDate': serializer.toJson<LocalDate>(openingDate),
      'includeInBalance': serializer.toJson<bool>(includeInBalance),
      'isMain': serializer.toJson<bool>(isMain),
      'parentAccountId': serializer.toJson<int?>(parentAccountId),
      'creditLimit': serializer.toJson<int?>(creditLimit),
      'paymentDay': serializer.toJson<int?>(paymentDay),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isArchived': serializer.toJson<bool>(isArchived),
    };
  }

  AccountRow copyWith({
    int? id,
    String? name,
    String? iconKey,
    int? color,
    AccountType? type,
    String? currencyCode,
    int? openingBalance,
    LocalDate? openingDate,
    bool? includeInBalance,
    bool? isMain,
    Value<int?> parentAccountId = const Value.absent(),
    Value<int?> creditLimit = const Value.absent(),
    Value<int?> paymentDay = const Value.absent(),
    int? sortOrder,
    bool? isArchived,
  }) => AccountRow(
    id: id ?? this.id,
    name: name ?? this.name,
    iconKey: iconKey ?? this.iconKey,
    color: color ?? this.color,
    type: type ?? this.type,
    currencyCode: currencyCode ?? this.currencyCode,
    openingBalance: openingBalance ?? this.openingBalance,
    openingDate: openingDate ?? this.openingDate,
    includeInBalance: includeInBalance ?? this.includeInBalance,
    isMain: isMain ?? this.isMain,
    parentAccountId: parentAccountId.present
        ? parentAccountId.value
        : this.parentAccountId,
    creditLimit: creditLimit.present ? creditLimit.value : this.creditLimit,
    paymentDay: paymentDay.present ? paymentDay.value : this.paymentDay,
    sortOrder: sortOrder ?? this.sortOrder,
    isArchived: isArchived ?? this.isArchived,
  );
  AccountRow copyWithCompanion(AccountsCompanion data) {
    return AccountRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      color: data.color.present ? data.color.value : this.color,
      type: data.type.present ? data.type.value : this.type,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      openingBalance: data.openingBalance.present
          ? data.openingBalance.value
          : this.openingBalance,
      openingDate: data.openingDate.present
          ? data.openingDate.value
          : this.openingDate,
      includeInBalance: data.includeInBalance.present
          ? data.includeInBalance.value
          : this.includeInBalance,
      isMain: data.isMain.present ? data.isMain.value : this.isMain,
      parentAccountId: data.parentAccountId.present
          ? data.parentAccountId.value
          : this.parentAccountId,
      creditLimit: data.creditLimit.present
          ? data.creditLimit.value
          : this.creditLimit,
      paymentDay: data.paymentDay.present
          ? data.paymentDay.value
          : this.paymentDay,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconKey: $iconKey, ')
          ..write('color: $color, ')
          ..write('type: $type, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('openingBalance: $openingBalance, ')
          ..write('openingDate: $openingDate, ')
          ..write('includeInBalance: $includeInBalance, ')
          ..write('isMain: $isMain, ')
          ..write('parentAccountId: $parentAccountId, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('paymentDay: $paymentDay, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    iconKey,
    color,
    type,
    currencyCode,
    openingBalance,
    openingDate,
    includeInBalance,
    isMain,
    parentAccountId,
    creditLimit,
    paymentDay,
    sortOrder,
    isArchived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.iconKey == this.iconKey &&
          other.color == this.color &&
          other.type == this.type &&
          other.currencyCode == this.currencyCode &&
          other.openingBalance == this.openingBalance &&
          other.openingDate == this.openingDate &&
          other.includeInBalance == this.includeInBalance &&
          other.isMain == this.isMain &&
          other.parentAccountId == this.parentAccountId &&
          other.creditLimit == this.creditLimit &&
          other.paymentDay == this.paymentDay &&
          other.sortOrder == this.sortOrder &&
          other.isArchived == this.isArchived);
}

class AccountsCompanion extends UpdateCompanion<AccountRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> iconKey;
  final Value<int> color;
  final Value<AccountType> type;
  final Value<String> currencyCode;
  final Value<int> openingBalance;
  final Value<LocalDate> openingDate;
  final Value<bool> includeInBalance;
  final Value<bool> isMain;
  final Value<int?> parentAccountId;
  final Value<int?> creditLimit;
  final Value<int?> paymentDay;
  final Value<int> sortOrder;
  final Value<bool> isArchived;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.color = const Value.absent(),
    this.type = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.openingBalance = const Value.absent(),
    this.openingDate = const Value.absent(),
    this.includeInBalance = const Value.absent(),
    this.isMain = const Value.absent(),
    this.parentAccountId = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.paymentDay = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isArchived = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String iconKey,
    required int color,
    required AccountType type,
    required String currencyCode,
    required int openingBalance,
    required LocalDate openingDate,
    required bool includeInBalance,
    this.isMain = const Value.absent(),
    this.parentAccountId = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.paymentDay = const Value.absent(),
    required int sortOrder,
    this.isArchived = const Value.absent(),
  }) : name = Value(name),
       iconKey = Value(iconKey),
       color = Value(color),
       type = Value(type),
       currencyCode = Value(currencyCode),
       openingBalance = Value(openingBalance),
       openingDate = Value(openingDate),
       includeInBalance = Value(includeInBalance),
       sortOrder = Value(sortOrder);
  static Insertable<AccountRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? iconKey,
    Expression<int>? color,
    Expression<String>? type,
    Expression<String>? currencyCode,
    Expression<int>? openingBalance,
    Expression<String>? openingDate,
    Expression<bool>? includeInBalance,
    Expression<bool>? isMain,
    Expression<int>? parentAccountId,
    Expression<int>? creditLimit,
    Expression<int>? paymentDay,
    Expression<int>? sortOrder,
    Expression<bool>? isArchived,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (iconKey != null) 'icon_key': iconKey,
      if (color != null) 'color': color,
      if (type != null) 'type': type,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (openingBalance != null) 'opening_balance': openingBalance,
      if (openingDate != null) 'opening_date': openingDate,
      if (includeInBalance != null) 'include_in_balance': includeInBalance,
      if (isMain != null) 'is_main': isMain,
      if (parentAccountId != null) 'parent_account_id': parentAccountId,
      if (creditLimit != null) 'credit_limit': creditLimit,
      if (paymentDay != null) 'payment_day': paymentDay,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isArchived != null) 'is_archived': isArchived,
    });
  }

  AccountsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? iconKey,
    Value<int>? color,
    Value<AccountType>? type,
    Value<String>? currencyCode,
    Value<int>? openingBalance,
    Value<LocalDate>? openingDate,
    Value<bool>? includeInBalance,
    Value<bool>? isMain,
    Value<int?>? parentAccountId,
    Value<int?>? creditLimit,
    Value<int?>? paymentDay,
    Value<int>? sortOrder,
    Value<bool>? isArchived,
  }) {
    return AccountsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      iconKey: iconKey ?? this.iconKey,
      color: color ?? this.color,
      type: type ?? this.type,
      currencyCode: currencyCode ?? this.currencyCode,
      openingBalance: openingBalance ?? this.openingBalance,
      openingDate: openingDate ?? this.openingDate,
      includeInBalance: includeInBalance ?? this.includeInBalance,
      isMain: isMain ?? this.isMain,
      parentAccountId: parentAccountId ?? this.parentAccountId,
      creditLimit: creditLimit ?? this.creditLimit,
      paymentDay: paymentDay ?? this.paymentDay,
      sortOrder: sortOrder ?? this.sortOrder,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $AccountsTable.$convertertype.toSql(type.value),
      );
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (openingBalance.present) {
      map['opening_balance'] = Variable<int>(openingBalance.value);
    }
    if (openingDate.present) {
      map['opening_date'] = Variable<String>(
        $AccountsTable.$converteropeningDate.toSql(openingDate.value),
      );
    }
    if (includeInBalance.present) {
      map['include_in_balance'] = Variable<bool>(includeInBalance.value);
    }
    if (isMain.present) {
      map['is_main'] = Variable<bool>(isMain.value);
    }
    if (parentAccountId.present) {
      map['parent_account_id'] = Variable<int>(parentAccountId.value);
    }
    if (creditLimit.present) {
      map['credit_limit'] = Variable<int>(creditLimit.value);
    }
    if (paymentDay.present) {
      map['payment_day'] = Variable<int>(paymentDay.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconKey: $iconKey, ')
          ..write('color: $color, ')
          ..write('type: $type, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('openingBalance: $openingBalance, ')
          ..write('openingDate: $openingDate, ')
          ..write('includeInBalance: $includeInBalance, ')
          ..write('isMain: $isMain, ')
          ..write('parentAccountId: $parentAccountId, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('paymentDay: $paymentDay, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CurrenciesTable currencies = $CurrenciesTable(this);
  late final $SettingsTableTable settingsTable = $SettingsTableTable(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final CurrencyDao currencyDao = CurrencyDao(this as AppDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  late final AccountDao accountDao = AccountDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    currencies,
    settingsTable,
    accounts,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$CurrenciesTableCreateCompanionBuilder = CurrenciesCompanion Function({
  required String code,
  required String symbol,
  required int decimals,
  required String thousandsSeparator,
  required String decimalSeparator,
  Value<bool> isBuiltIn,
  Value<int> rowid,
});
typedef $$CurrenciesTableUpdateCompanionBuilder = CurrenciesCompanion Function({
  Value<String> code,
  Value<String> symbol,
  Value<int> decimals,
  Value<String> thousandsSeparator,
  Value<String> decimalSeparator,
  Value<bool> isBuiltIn,
  Value<int> rowid,
});

final class $$CurrenciesTableReferences
    extends BaseReferences<_$AppDatabase, $CurrenciesTable, CurrencyRow> {
  $$CurrenciesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SettingsTableTable, List<SettingsRow>>
  _settingsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.settingsTable,
    aliasName: 'currencies__code__settings__main_currency_code',
  );

  $$SettingsTableTableProcessedTableManager get settingsTableRefs {
    final manager = $$SettingsTableTableTableManager($_db, $_db.settingsTable)
        .filter(
          (f) =>
              f.mainCurrencyCode.code.sqlEquals($_itemColumn<String>('code')!),
        );

    final cache = $_typedResult.readTableOrNull(_settingsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AccountsTable, List<AccountRow>>
  _accountsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.accounts,
    aliasName: 'currencies__code__accounts__currency_code',
  );

  $$AccountsTableProcessedTableManager get accountsRefs {
    final manager = $$AccountsTableTableManager($_db, $_db.accounts).filter(
      (f) => f.currencyCode.code.sqlEquals($_itemColumn<String>('code')!),
    );

    final cache = $_typedResult.readTableOrNull(_accountsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CurrenciesTableFilterComposer
    extends Composer<_$AppDatabase, $CurrenciesTable> {
  $$CurrenciesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get decimals => $composableBuilder(
    column: $table.decimals,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thousandsSeparator => $composableBuilder(
    column: $table.thousandsSeparator,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get decimalSeparator => $composableBuilder(
    column: $table.decimalSeparator,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> settingsTableRefs(
    Expression<bool> Function($$SettingsTableTableFilterComposer f) f,
  ) {
    final $$SettingsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.settingsTable,
      getReferencedColumn: (t) => t.mainCurrencyCode,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SettingsTableTableFilterComposer(
            $db: $db,
            $table: $db.settingsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> accountsRefs(
    Expression<bool> Function($$AccountsTableFilterComposer f) f,
  ) {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.currencyCode,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CurrenciesTableOrderingComposer
    extends Composer<_$AppDatabase, $CurrenciesTable> {
  $$CurrenciesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get decimals => $composableBuilder(
    column: $table.decimals,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thousandsSeparator => $composableBuilder(
    column: $table.thousandsSeparator,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decimalSeparator => $composableBuilder(
    column: $table.decimalSeparator,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CurrenciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CurrenciesTable> {
  $$CurrenciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<int> get decimals =>
      $composableBuilder(column: $table.decimals, builder: (column) => column);

  GeneratedColumn<String> get thousandsSeparator => $composableBuilder(
    column: $table.thousandsSeparator,
    builder: (column) => column,
  );

  GeneratedColumn<String> get decimalSeparator => $composableBuilder(
    column: $table.decimalSeparator,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  Expression<T> settingsTableRefs<T extends Object>(
    Expression<T> Function($$SettingsTableTableAnnotationComposer a) f,
  ) {
    final $$SettingsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.settingsTable,
      getReferencedColumn: (t) => t.mainCurrencyCode,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SettingsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.settingsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> accountsRefs<T extends Object>(
    Expression<T> Function($$AccountsTableAnnotationComposer a) f,
  ) {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.currencyCode,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CurrenciesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CurrenciesTable,
          CurrencyRow,
          $$CurrenciesTableFilterComposer,
          $$CurrenciesTableOrderingComposer,
          $$CurrenciesTableAnnotationComposer,
          $$CurrenciesTableCreateCompanionBuilder,
          $$CurrenciesTableUpdateCompanionBuilder,
          (CurrencyRow, $$CurrenciesTableReferences),
          CurrencyRow,
          PrefetchHooks Function({bool settingsTableRefs, bool accountsRefs})
        > {
  $$CurrenciesTableTableManager(_$AppDatabase db, $CurrenciesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CurrenciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CurrenciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CurrenciesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> code = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<int> decimals = const Value.absent(),
                Value<String> thousandsSeparator = const Value.absent(),
                Value<String> decimalSeparator = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CurrenciesCompanion(
                code: code,
                symbol: symbol,
                decimals: decimals,
                thousandsSeparator: thousandsSeparator,
                decimalSeparator: decimalSeparator,
                isBuiltIn: isBuiltIn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String code,
                required String symbol,
                required int decimals,
                required String thousandsSeparator,
                required String decimalSeparator,
                Value<bool> isBuiltIn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CurrenciesCompanion.insert(
                code: code,
                symbol: symbol,
                decimals: decimals,
                thousandsSeparator: thousandsSeparator,
                decimalSeparator: decimalSeparator,
                isBuiltIn: isBuiltIn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CurrenciesTable, CurrencyRow>(table),
                  $$CurrenciesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({settingsTableRefs = false, accountsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (settingsTableRefs) db.settingsTable,
                    if (accountsRefs) db.accounts,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (settingsTableRefs)
                        await $_getPrefetchedDataByColumns<
                          CurrencyRow,
                          $CurrenciesTable,
                          SettingsRow,
                          $SettingsTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$CurrenciesTableReferences
                              ._settingsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CurrenciesTableReferences(
                                db,
                                table,
                                p0,
                              ).settingsTableRefs,
                          currentColumn: 'code',
                          referencedColumn: 'main_currency_code',
                          typedResults: items,
                        ),
                      if (accountsRefs)
                        await $_getPrefetchedDataByColumns<
                          CurrencyRow,
                          $CurrenciesTable,
                          AccountRow,
                          $AccountsTable
                        >(
                          currentTable: table,
                          referencedTable: $$CurrenciesTableReferences
                              ._accountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CurrenciesTableReferences(
                                db,
                                table,
                                p0,
                              ).accountsRefs,
                          currentColumn: 'code',
                          referencedColumn: 'currency_code',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CurrenciesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CurrenciesTable,
      CurrencyRow,
      $$CurrenciesTableFilterComposer,
      $$CurrenciesTableOrderingComposer,
      $$CurrenciesTableAnnotationComposer,
      $$CurrenciesTableCreateCompanionBuilder,
      $$CurrenciesTableUpdateCompanionBuilder,
      (CurrencyRow, $$CurrenciesTableReferences),
      CurrencyRow,
      PrefetchHooks Function({bool settingsTableRefs, bool accountsRefs})
    >;
typedef $$SettingsTableTableCreateCompanionBuilder =
    SettingsTableCompanion Function({
      Value<int> id,
      required String mainCurrencyCode,
      required PeriodType periodType,
      required int cutoffDay,
      required int minDaysBetweenPeriods,
      required bool notificationsEnabled,
      required int reminderMinutes,
      required AppThemeMode themeMode,
      required BalanceFilter balanceFilter,
      required int backupsToKeep,
    });
typedef $$SettingsTableTableUpdateCompanionBuilder =
    SettingsTableCompanion Function({
      Value<int> id,
      Value<String> mainCurrencyCode,
      Value<PeriodType> periodType,
      Value<int> cutoffDay,
      Value<int> minDaysBetweenPeriods,
      Value<bool> notificationsEnabled,
      Value<int> reminderMinutes,
      Value<AppThemeMode> themeMode,
      Value<BalanceFilter> balanceFilter,
      Value<int> backupsToKeep,
    });

final class $$SettingsTableTableReferences
    extends BaseReferences<_$AppDatabase, $SettingsTableTable, SettingsRow> {
  $$SettingsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CurrenciesTable _mainCurrencyCodeTable(_$AppDatabase db) => db
      .currencies
      .createAlias('settings__main_currency_code__currencies__code');

  $$CurrenciesTableProcessedTableManager get mainCurrencyCode {
    final $_column = $_itemColumn<String>('main_currency_code')!;

    final manager = $$CurrenciesTableTableManager(
      $_db,
      $_db.currencies,
    ).filter((f) => f.code.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mainCurrencyCodeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PeriodType, PeriodType, String>
  get periodType => $composableBuilder(
    column: $table.periodType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get cutoffDay => $composableBuilder(
    column: $table.cutoffDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minDaysBetweenPeriods => $composableBuilder(
    column: $table.minDaysBetweenPeriods,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AppThemeMode, AppThemeMode, String>
  get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<BalanceFilter, BalanceFilter, String>
  get balanceFilter => $composableBuilder(
    column: $table.balanceFilter,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get backupsToKeep => $composableBuilder(
    column: $table.backupsToKeep,
    builder: (column) => ColumnFilters(column),
  );

  $$CurrenciesTableFilterComposer get mainCurrencyCode {
    final $$CurrenciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainCurrencyCode,
      referencedTable: $db.currencies,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableFilterComposer(
            $db: $db,
            $table: $db.currencies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get periodType => $composableBuilder(
    column: $table.periodType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cutoffDay => $composableBuilder(
    column: $table.cutoffDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minDaysBetweenPeriods => $composableBuilder(
    column: $table.minDaysBetweenPeriods,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get balanceFilter => $composableBuilder(
    column: $table.balanceFilter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get backupsToKeep => $composableBuilder(
    column: $table.backupsToKeep,
    builder: (column) => ColumnOrderings(column),
  );

  $$CurrenciesTableOrderingComposer get mainCurrencyCode {
    final $$CurrenciesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainCurrencyCode,
      referencedTable: $db.currencies,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableOrderingComposer(
            $db: $db,
            $table: $db.currencies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PeriodType, String> get periodType =>
      $composableBuilder(
        column: $table.periodType,
        builder: (column) => column,
      );

  GeneratedColumn<int> get cutoffDay =>
      $composableBuilder(column: $table.cutoffDay, builder: (column) => column);

  GeneratedColumn<int> get minDaysBetweenPeriods => $composableBuilder(
    column: $table.minDaysBetweenPeriods,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<AppThemeMode, String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BalanceFilter, String> get balanceFilter =>
      $composableBuilder(
        column: $table.balanceFilter,
        builder: (column) => column,
      );

  GeneratedColumn<int> get backupsToKeep => $composableBuilder(
    column: $table.backupsToKeep,
    builder: (column) => column,
  );

  $$CurrenciesTableAnnotationComposer get mainCurrencyCode {
    final $$CurrenciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainCurrencyCode,
      referencedTable: $db.currencies,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableAnnotationComposer(
            $db: $db,
            $table: $db.currencies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTableTable,
          SettingsRow,
          $$SettingsTableTableFilterComposer,
          $$SettingsTableTableOrderingComposer,
          $$SettingsTableTableAnnotationComposer,
          $$SettingsTableTableCreateCompanionBuilder,
          $$SettingsTableTableUpdateCompanionBuilder,
          (SettingsRow, $$SettingsTableTableReferences),
          SettingsRow,
          PrefetchHooks Function({bool mainCurrencyCode})
        > {
  $$SettingsTableTableTableManager(_$AppDatabase db, $SettingsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> mainCurrencyCode = const Value.absent(),
                Value<PeriodType> periodType = const Value.absent(),
                Value<int> cutoffDay = const Value.absent(),
                Value<int> minDaysBetweenPeriods = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<int> reminderMinutes = const Value.absent(),
                Value<AppThemeMode> themeMode = const Value.absent(),
                Value<BalanceFilter> balanceFilter = const Value.absent(),
                Value<int> backupsToKeep = const Value.absent(),
              }) => SettingsTableCompanion(
                id: id,
                mainCurrencyCode: mainCurrencyCode,
                periodType: periodType,
                cutoffDay: cutoffDay,
                minDaysBetweenPeriods: minDaysBetweenPeriods,
                notificationsEnabled: notificationsEnabled,
                reminderMinutes: reminderMinutes,
                themeMode: themeMode,
                balanceFilter: balanceFilter,
                backupsToKeep: backupsToKeep,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String mainCurrencyCode,
                required PeriodType periodType,
                required int cutoffDay,
                required int minDaysBetweenPeriods,
                required bool notificationsEnabled,
                required int reminderMinutes,
                required AppThemeMode themeMode,
                required BalanceFilter balanceFilter,
                required int backupsToKeep,
              }) => SettingsTableCompanion.insert(
                id: id,
                mainCurrencyCode: mainCurrencyCode,
                periodType: periodType,
                cutoffDay: cutoffDay,
                minDaysBetweenPeriods: minDaysBetweenPeriods,
                notificationsEnabled: notificationsEnabled,
                reminderMinutes: reminderMinutes,
                themeMode: themeMode,
                balanceFilter: balanceFilter,
                backupsToKeep: backupsToKeep,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingsTableTable, SettingsRow>(table),
                  $$SettingsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mainCurrencyCode = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mainCurrencyCode) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mainCurrencyCode,
                        referencedTable: $$SettingsTableTableReferences
                            ._mainCurrencyCodeTable(db),
                        referencedColumn: $$SettingsTableTableReferences
                            ._mainCurrencyCodeTable(db)
                            .code,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTableTable,
      SettingsRow,
      $$SettingsTableTableFilterComposer,
      $$SettingsTableTableOrderingComposer,
      $$SettingsTableTableAnnotationComposer,
      $$SettingsTableTableCreateCompanionBuilder,
      $$SettingsTableTableUpdateCompanionBuilder,
      (SettingsRow, $$SettingsTableTableReferences),
      SettingsRow,
      PrefetchHooks Function({bool mainCurrencyCode})
    >;
typedef $$AccountsTableCreateCompanionBuilder = AccountsCompanion Function({
  Value<int> id,
  required String name,
  required String iconKey,
  required int color,
  required AccountType type,
  required String currencyCode,
  required int openingBalance,
  required LocalDate openingDate,
  required bool includeInBalance,
  Value<bool> isMain,
  Value<int?> parentAccountId,
  Value<int?> creditLimit,
  Value<int?> paymentDay,
  required int sortOrder,
  Value<bool> isArchived,
});
typedef $$AccountsTableUpdateCompanionBuilder = AccountsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> iconKey,
  Value<int> color,
  Value<AccountType> type,
  Value<String> currencyCode,
  Value<int> openingBalance,
  Value<LocalDate> openingDate,
  Value<bool> includeInBalance,
  Value<bool> isMain,
  Value<int?> parentAccountId,
  Value<int?> creditLimit,
  Value<int?> paymentDay,
  Value<int> sortOrder,
  Value<bool> isArchived,
});

final class $$AccountsTableReferences
    extends BaseReferences<_$AppDatabase, $AccountsTable, AccountRow> {
  $$AccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CurrenciesTable _currencyCodeTable(_$AppDatabase db) =>
      db.currencies.createAlias('accounts__currency_code__currencies__code');

  $$CurrenciesTableProcessedTableManager get currencyCode {
    final $_column = $_itemColumn<String>('currency_code')!;

    final manager = $$CurrenciesTableTableManager(
      $_db,
      $_db.currencies,
    ).filter((f) => f.code.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_currencyCodeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _parentAccountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('accounts__parent_account_id__accounts__id');

  $$AccountsTableProcessedTableManager? get parentAccountId {
    final $_column = $_itemColumn<int>('parent_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AccountType, AccountType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get openingBalance => $composableBuilder(
    column: $table.openingBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LocalDate, LocalDate, String>
  get openingDate => $composableBuilder(
    column: $table.openingDate,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get includeInBalance => $composableBuilder(
    column: $table.includeInBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMain => $composableBuilder(
    column: $table.isMain,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paymentDay => $composableBuilder(
    column: $table.paymentDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  $$CurrenciesTableFilterComposer get currencyCode {
    final $$CurrenciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currencies,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableFilterComposer(
            $db: $db,
            $table: $db.currencies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get parentAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get openingBalance => $composableBuilder(
    column: $table.openingBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get openingDate => $composableBuilder(
    column: $table.openingDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get includeInBalance => $composableBuilder(
    column: $table.includeInBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMain => $composableBuilder(
    column: $table.isMain,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paymentDay => $composableBuilder(
    column: $table.paymentDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  $$CurrenciesTableOrderingComposer get currencyCode {
    final $$CurrenciesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currencies,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableOrderingComposer(
            $db: $db,
            $table: $db.currencies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get parentAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AccountType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get openingBalance => $composableBuilder(
    column: $table.openingBalance,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<LocalDate, String> get openingDate =>
      $composableBuilder(
        column: $table.openingDate,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get includeInBalance => $composableBuilder(
    column: $table.includeInBalance,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isMain =>
      $composableBuilder(column: $table.isMain, builder: (column) => column);

  GeneratedColumn<int> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => column,
  );

  GeneratedColumn<int> get paymentDay => $composableBuilder(
    column: $table.paymentDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  $$CurrenciesTableAnnotationComposer get currencyCode {
    final $$CurrenciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currencies,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableAnnotationComposer(
            $db: $db,
            $table: $db.currencies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get parentAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountsTable,
          AccountRow,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (AccountRow, $$AccountsTableReferences),
          AccountRow,
          PrefetchHooks Function({bool currencyCode, bool parentAccountId})
        > {
  $$AccountsTableTableManager(_$AppDatabase db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> iconKey = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<AccountType> type = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<int> openingBalance = const Value.absent(),
                Value<LocalDate> openingDate = const Value.absent(),
                Value<bool> includeInBalance = const Value.absent(),
                Value<bool> isMain = const Value.absent(),
                Value<int?> parentAccountId = const Value.absent(),
                Value<int?> creditLimit = const Value.absent(),
                Value<int?> paymentDay = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
              }) => AccountsCompanion(
                id: id,
                name: name,
                iconKey: iconKey,
                color: color,
                type: type,
                currencyCode: currencyCode,
                openingBalance: openingBalance,
                openingDate: openingDate,
                includeInBalance: includeInBalance,
                isMain: isMain,
                parentAccountId: parentAccountId,
                creditLimit: creditLimit,
                paymentDay: paymentDay,
                sortOrder: sortOrder,
                isArchived: isArchived,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String iconKey,
                required int color,
                required AccountType type,
                required String currencyCode,
                required int openingBalance,
                required LocalDate openingDate,
                required bool includeInBalance,
                Value<bool> isMain = const Value.absent(),
                Value<int?> parentAccountId = const Value.absent(),
                Value<int?> creditLimit = const Value.absent(),
                Value<int?> paymentDay = const Value.absent(),
                required int sortOrder,
                Value<bool> isArchived = const Value.absent(),
              }) => AccountsCompanion.insert(
                id: id,
                name: name,
                iconKey: iconKey,
                color: color,
                type: type,
                currencyCode: currencyCode,
                openingBalance: openingBalance,
                openingDate: openingDate,
                includeInBalance: includeInBalance,
                isMain: isMain,
                parentAccountId: parentAccountId,
                creditLimit: creditLimit,
                paymentDay: paymentDay,
                sortOrder: sortOrder,
                isArchived: isArchived,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AccountsTable, AccountRow>(table),
                  $$AccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({currencyCode = false, parentAccountId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (currencyCode) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.currencyCode,
                            referencedTable: $$AccountsTableReferences
                                ._currencyCodeTable(db),
                            referencedColumn: $$AccountsTableReferences
                                ._currencyCodeTable(db)
                                .code,
                          ) as T;
                        }
                        if (parentAccountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.parentAccountId,
                            referencedTable: $$AccountsTableReferences
                                ._parentAccountIdTable(db),
                            referencedColumn: $$AccountsTableReferences
                                ._parentAccountIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountsTable,
      AccountRow,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (AccountRow, $$AccountsTableReferences),
      AccountRow,
      PrefetchHooks Function({bool currencyCode, bool parentAccountId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CurrenciesTableTableManager get currencies =>
      $$CurrenciesTableTableManager(_db, _db.currencies);
  $$SettingsTableTableTableManager get settingsTable =>
      $$SettingsTableTableTableManager(_db, _db.settingsTable);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
}
