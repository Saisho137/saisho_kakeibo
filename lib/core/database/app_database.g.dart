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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CurrenciesTable currencies = $CurrenciesTable(this);
  late final $SettingsTableTable settingsTable = $SettingsTableTable(this);
  late final CurrencyDao currencyDao = CurrencyDao(this as AppDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    currencies,
    settingsTable,
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
          PrefetchHooks Function({bool settingsTableRefs})
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
          prefetchHooksCallback: ({settingsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (settingsTableRefs) db.settingsTable,
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
      PrefetchHooks Function({bool settingsTableRefs})
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CurrenciesTableTableManager get currencies =>
      $$CurrenciesTableTableManager(_db, _db.currencies);
  $$SettingsTableTableTableManager get settingsTable =>
      $$SettingsTableTableTableManager(_db, _db.settingsTable);
}
