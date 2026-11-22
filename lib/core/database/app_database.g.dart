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

class $PillarsTable extends Pillars with TableInfo<$PillarsTable, PillarRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PillarsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [id, name, color, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pillars';
  @override
  VerificationContext validateIntegrity(
    Insertable<PillarRow> instance, {
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
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PillarRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PillarRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $PillarsTable createAlias(String alias) {
    return $PillarsTable(attachedDatabase, alias);
  }
}

class PillarRow extends DataClass implements Insertable<PillarRow> {
  final int id;
  final String name;
  final int color;
  final int sortOrder;
  const PillarRow({
    required this.id,
    required this.name,
    required this.color,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['color'] = Variable<int>(color);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  PillarsCompanion toCompanion(bool nullToAbsent) {
    return PillarsCompanion(
      id: Value(id),
      name: Value(name),
      color: Value(color),
      sortOrder: Value(sortOrder),
    );
  }

  factory PillarRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PillarRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<int>(json['color']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<int>(color),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  PillarRow copyWith({int? id, String? name, int? color, int? sortOrder}) =>
      PillarRow(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  PillarRow copyWithCompanion(PillarsCompanion data) {
    return PillarRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PillarRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, color, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PillarRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.sortOrder == this.sortOrder);
}

class PillarsCompanion extends UpdateCompanion<PillarRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> color;
  final Value<int> sortOrder;
  const PillarsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  PillarsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int color,
    required int sortOrder,
  }) : name = Value(name),
       color = Value(color),
       sortOrder = Value(sortOrder);
  static Insertable<PillarRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? color,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  PillarsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? color,
    Value<int>? sortOrder,
  }) {
    return PillarsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      sortOrder: sortOrder ?? this.sortOrder,
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
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PillarsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, CategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
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
  @override
  late final GeneratedColumnWithTypeConverter<CategoryType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CategoryType>($CategoriesTable.$convertertype);
  @override
  late final GeneratedColumnWithTypeConverter<CategoryRole, String> role =
      GeneratedColumn<String>(
        'role',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CategoryRole>($CategoriesTable.$converterrole);
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
  static const VerificationMeta _pillarIdMeta = const VerificationMeta(
    'pillarId',
  );
  @override
  late final GeneratedColumn<int> pillarId = GeneratedColumn<int>(
    'pillar_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pillars (id)',
    ),
  );
  static const VerificationMeta _defaultNameMeta = const VerificationMeta(
    'defaultName',
  );
  @override
  late final GeneratedColumn<String> defaultName = GeneratedColumn<String>(
    'default_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultIconKeyMeta = const VerificationMeta(
    'defaultIconKey',
  );
  @override
  late final GeneratedColumn<String> defaultIconKey = GeneratedColumn<String>(
    'default_icon_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
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
    type,
    role,
    name,
    iconKey,
    color,
    pillarId,
    defaultName,
    defaultIconKey,
    sortOrder,
    isArchived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryRow> instance, {
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
    if (data.containsKey('pillar_id')) {
      context.handle(
        _pillarIdMeta,
        pillarId.isAcceptableOrUnknown(data['pillar_id']!, _pillarIdMeta),
      );
    }
    if (data.containsKey('default_name')) {
      context.handle(
        _defaultNameMeta,
        defaultName.isAcceptableOrUnknown(
          data['default_name']!,
          _defaultNameMeta,
        ),
      );
    }
    if (data.containsKey('default_icon_key')) {
      context.handle(
        _defaultIconKeyMeta,
        defaultIconKey.isAcceptableOrUnknown(
          data['default_icon_key']!,
          _defaultIconKeyMeta,
        ),
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
  CategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: $CategoriesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      role: $CategoriesTable.$converterrole.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}role'],
        )!,
      ),
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
      pillarId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pillar_id'],
      ),
      defaultName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_name'],
      ),
      defaultIconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_icon_key'],
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
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CategoryType, String, String> $convertertype =
      const EnumNameConverter<CategoryType>(CategoryType.values);
  static JsonTypeConverter2<CategoryRole, String, String> $converterrole =
      const EnumNameConverter<CategoryRole>(CategoryRole.values);
}

class CategoryRow extends DataClass implements Insertable<CategoryRow> {
  final int id;
  final CategoryType type;
  final CategoryRole role;
  final String name;
  final String iconKey;
  final int color;
  final int? pillarId;
  final String? defaultName;
  final String? defaultIconKey;
  final int sortOrder;
  final bool isArchived;
  const CategoryRow({
    required this.id,
    required this.type,
    required this.role,
    required this.name,
    required this.iconKey,
    required this.color,
    this.pillarId,
    this.defaultName,
    this.defaultIconKey,
    required this.sortOrder,
    required this.isArchived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['type'] = Variable<String>(
        $CategoriesTable.$convertertype.toSql(type),
      );
    }
    {
      map['role'] = Variable<String>(
        $CategoriesTable.$converterrole.toSql(role),
      );
    }
    map['name'] = Variable<String>(name);
    map['icon_key'] = Variable<String>(iconKey);
    map['color'] = Variable<int>(color);
    if (!nullToAbsent || pillarId != null) {
      map['pillar_id'] = Variable<int>(pillarId);
    }
    if (!nullToAbsent || defaultName != null) {
      map['default_name'] = Variable<String>(defaultName);
    }
    if (!nullToAbsent || defaultIconKey != null) {
      map['default_icon_key'] = Variable<String>(defaultIconKey);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_archived'] = Variable<bool>(isArchived);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      type: Value(type),
      role: Value(role),
      name: Value(name),
      iconKey: Value(iconKey),
      color: Value(color),
      pillarId: pillarId == null && nullToAbsent
          ? const Value.absent()
          : Value(pillarId),
      defaultName: defaultName == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultName),
      defaultIconKey: defaultIconKey == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultIconKey),
      sortOrder: Value(sortOrder),
      isArchived: Value(isArchived),
    );
  }

  factory CategoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryRow(
      id: serializer.fromJson<int>(json['id']),
      type: $CategoriesTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      role: $CategoriesTable.$converterrole.fromJson(
        serializer.fromJson<String>(json['role']),
      ),
      name: serializer.fromJson<String>(json['name']),
      iconKey: serializer.fromJson<String>(json['iconKey']),
      color: serializer.fromJson<int>(json['color']),
      pillarId: serializer.fromJson<int?>(json['pillarId']),
      defaultName: serializer.fromJson<String?>(json['defaultName']),
      defaultIconKey: serializer.fromJson<String?>(json['defaultIconKey']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(
        $CategoriesTable.$convertertype.toJson(type),
      ),
      'role': serializer.toJson<String>(
        $CategoriesTable.$converterrole.toJson(role),
      ),
      'name': serializer.toJson<String>(name),
      'iconKey': serializer.toJson<String>(iconKey),
      'color': serializer.toJson<int>(color),
      'pillarId': serializer.toJson<int?>(pillarId),
      'defaultName': serializer.toJson<String?>(defaultName),
      'defaultIconKey': serializer.toJson<String?>(defaultIconKey),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isArchived': serializer.toJson<bool>(isArchived),
    };
  }

  CategoryRow copyWith({
    int? id,
    CategoryType? type,
    CategoryRole? role,
    String? name,
    String? iconKey,
    int? color,
    Value<int?> pillarId = const Value.absent(),
    Value<String?> defaultName = const Value.absent(),
    Value<String?> defaultIconKey = const Value.absent(),
    int? sortOrder,
    bool? isArchived,
  }) => CategoryRow(
    id: id ?? this.id,
    type: type ?? this.type,
    role: role ?? this.role,
    name: name ?? this.name,
    iconKey: iconKey ?? this.iconKey,
    color: color ?? this.color,
    pillarId: pillarId.present ? pillarId.value : this.pillarId,
    defaultName: defaultName.present ? defaultName.value : this.defaultName,
    defaultIconKey: defaultIconKey.present
        ? defaultIconKey.value
        : this.defaultIconKey,
    sortOrder: sortOrder ?? this.sortOrder,
    isArchived: isArchived ?? this.isArchived,
  );
  CategoryRow copyWithCompanion(CategoriesCompanion data) {
    return CategoryRow(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      role: data.role.present ? data.role.value : this.role,
      name: data.name.present ? data.name.value : this.name,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      color: data.color.present ? data.color.value : this.color,
      pillarId: data.pillarId.present ? data.pillarId.value : this.pillarId,
      defaultName: data.defaultName.present
          ? data.defaultName.value
          : this.defaultName,
      defaultIconKey: data.defaultIconKey.present
          ? data.defaultIconKey.value
          : this.defaultIconKey,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryRow(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('role: $role, ')
          ..write('name: $name, ')
          ..write('iconKey: $iconKey, ')
          ..write('color: $color, ')
          ..write('pillarId: $pillarId, ')
          ..write('defaultName: $defaultName, ')
          ..write('defaultIconKey: $defaultIconKey, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    role,
    name,
    iconKey,
    color,
    pillarId,
    defaultName,
    defaultIconKey,
    sortOrder,
    isArchived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryRow &&
          other.id == this.id &&
          other.type == this.type &&
          other.role == this.role &&
          other.name == this.name &&
          other.iconKey == this.iconKey &&
          other.color == this.color &&
          other.pillarId == this.pillarId &&
          other.defaultName == this.defaultName &&
          other.defaultIconKey == this.defaultIconKey &&
          other.sortOrder == this.sortOrder &&
          other.isArchived == this.isArchived);
}

class CategoriesCompanion extends UpdateCompanion<CategoryRow> {
  final Value<int> id;
  final Value<CategoryType> type;
  final Value<CategoryRole> role;
  final Value<String> name;
  final Value<String> iconKey;
  final Value<int> color;
  final Value<int?> pillarId;
  final Value<String?> defaultName;
  final Value<String?> defaultIconKey;
  final Value<int> sortOrder;
  final Value<bool> isArchived;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.role = const Value.absent(),
    this.name = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.color = const Value.absent(),
    this.pillarId = const Value.absent(),
    this.defaultName = const Value.absent(),
    this.defaultIconKey = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isArchived = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required CategoryType type,
    required CategoryRole role,
    required String name,
    required String iconKey,
    required int color,
    this.pillarId = const Value.absent(),
    this.defaultName = const Value.absent(),
    this.defaultIconKey = const Value.absent(),
    required int sortOrder,
    this.isArchived = const Value.absent(),
  }) : type = Value(type),
       role = Value(role),
       name = Value(name),
       iconKey = Value(iconKey),
       color = Value(color),
       sortOrder = Value(sortOrder);
  static Insertable<CategoryRow> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? role,
    Expression<String>? name,
    Expression<String>? iconKey,
    Expression<int>? color,
    Expression<int>? pillarId,
    Expression<String>? defaultName,
    Expression<String>? defaultIconKey,
    Expression<int>? sortOrder,
    Expression<bool>? isArchived,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (role != null) 'role': role,
      if (name != null) 'name': name,
      if (iconKey != null) 'icon_key': iconKey,
      if (color != null) 'color': color,
      if (pillarId != null) 'pillar_id': pillarId,
      if (defaultName != null) 'default_name': defaultName,
      if (defaultIconKey != null) 'default_icon_key': defaultIconKey,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isArchived != null) 'is_archived': isArchived,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? id,
    Value<CategoryType>? type,
    Value<CategoryRole>? role,
    Value<String>? name,
    Value<String>? iconKey,
    Value<int>? color,
    Value<int?>? pillarId,
    Value<String?>? defaultName,
    Value<String?>? defaultIconKey,
    Value<int>? sortOrder,
    Value<bool>? isArchived,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      role: role ?? this.role,
      name: name ?? this.name,
      iconKey: iconKey ?? this.iconKey,
      color: color ?? this.color,
      pillarId: pillarId ?? this.pillarId,
      defaultName: defaultName ?? this.defaultName,
      defaultIconKey: defaultIconKey ?? this.defaultIconKey,
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
    if (type.present) {
      map['type'] = Variable<String>(
        $CategoriesTable.$convertertype.toSql(type.value),
      );
    }
    if (role.present) {
      map['role'] = Variable<String>(
        $CategoriesTable.$converterrole.toSql(role.value),
      );
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
    if (pillarId.present) {
      map['pillar_id'] = Variable<int>(pillarId.value);
    }
    if (defaultName.present) {
      map['default_name'] = Variable<String>(defaultName.value);
    }
    if (defaultIconKey.present) {
      map['default_icon_key'] = Variable<String>(defaultIconKey.value);
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
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('role: $role, ')
          ..write('name: $name, ')
          ..write('iconKey: $iconKey, ')
          ..write('color: $color, ')
          ..write('pillarId: $pillarId, ')
          ..write('defaultName: $defaultName, ')
          ..write('defaultIconKey: $defaultIconKey, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }
}

class $PayeesTable extends Payees with TableInfo<$PayeesTable, PayeeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PayeesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, key];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payees';
  @override
  VerificationContext validateIntegrity(
    Insertable<PayeeRow> instance, {
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
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PayeeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PayeeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
    );
  }

  @override
  $PayeesTable createAlias(String alias) {
    return $PayeesTable(attachedDatabase, alias);
  }
}

class PayeeRow extends DataClass implements Insertable<PayeeRow> {
  final int id;
  final String name;
  final String key;
  const PayeeRow({required this.id, required this.name, required this.key});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['key'] = Variable<String>(key);
    return map;
  }

  PayeesCompanion toCompanion(bool nullToAbsent) {
    return PayeesCompanion(id: Value(id), name: Value(name), key: Value(key));
  }

  factory PayeeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PayeeRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      key: serializer.fromJson<String>(json['key']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'key': serializer.toJson<String>(key),
    };
  }

  PayeeRow copyWith({int? id, String? name, String? key}) => PayeeRow(
    id: id ?? this.id,
    name: name ?? this.name,
    key: key ?? this.key,
  );
  PayeeRow copyWithCompanion(PayeesCompanion data) {
    return PayeeRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      key: data.key.present ? data.key.value : this.key,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PayeeRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('key: $key')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, key);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PayeeRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.key == this.key);
}

class PayeesCompanion extends UpdateCompanion<PayeeRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> key;
  const PayeesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.key = const Value.absent(),
  });
  PayeesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String key,
  }) : name = Value(name),
       key = Value(key);
  static Insertable<PayeeRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? key,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (key != null) 'key': key,
    });
  }

  PayeesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? key,
  }) {
    return PayeesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      key: key ?? this.key,
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
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PayeesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('key: $key')
          ..write(')'))
        .toString();
  }
}

class $RecurringTemplatesTable extends RecurringTemplates
    with TableInfo<$RecurringTemplatesTable, RecurringTemplateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringTemplatesTable(this.attachedDatabase, [this._alias]);
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
  @override
  late final GeneratedColumnWithTypeConverter<MovementType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<MovementType>($RecurringTemplatesTable.$convertertype);
  @override
  late final GeneratedColumnWithTypeConverter<RecurringCadence, String>
  cadence = GeneratedColumn<String>(
    'cadence',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<RecurringCadence>($RecurringTemplatesTable.$convertercadence);
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _toAccountIdMeta = const VerificationMeta(
    'toAccountId',
  );
  @override
  late final GeneratedColumn<int> toAccountId = GeneratedColumn<int>(
    'to_account_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toAmountMeta = const VerificationMeta(
    'toAmount',
  );
  @override
  late final GeneratedColumn<int> toAmount = GeneratedColumn<int>(
    'to_amount',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payeeIdMeta = const VerificationMeta(
    'payeeId',
  );
  @override
  late final GeneratedColumn<int> payeeId = GeneratedColumn<int>(
    'payee_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES payees (id)',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueDayMeta = const VerificationMeta('dueDay');
  @override
  late final GeneratedColumn<int> dueDay = GeneratedColumn<int>(
    'due_day',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remindMeta = const VerificationMeta('remind');
  @override
  late final GeneratedColumn<bool> remind = GeneratedColumn<bool>(
    'remind',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("remind" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  late final GeneratedColumnWithTypeConverter<LocalDate, String> createdOn =
      GeneratedColumn<String>(
        'created_on',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LocalDate>($RecurringTemplatesTable.$convertercreatedOn);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    cadence,
    categoryId,
    accountId,
    toAccountId,
    amount,
    toAmount,
    payeeId,
    note,
    dueDay,
    remind,
    isActive,
    createdOn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecurringTemplateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('to_account_id')) {
      context.handle(
        _toAccountIdMeta,
        toAccountId.isAcceptableOrUnknown(
          data['to_account_id']!,
          _toAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('to_amount')) {
      context.handle(
        _toAmountMeta,
        toAmount.isAcceptableOrUnknown(data['to_amount']!, _toAmountMeta),
      );
    }
    if (data.containsKey('payee_id')) {
      context.handle(
        _payeeIdMeta,
        payeeId.isAcceptableOrUnknown(data['payee_id']!, _payeeIdMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('due_day')) {
      context.handle(
        _dueDayMeta,
        dueDay.isAcceptableOrUnknown(data['due_day']!, _dueDayMeta),
      );
    }
    if (data.containsKey('remind')) {
      context.handle(
        _remindMeta,
        remind.isAcceptableOrUnknown(data['remind']!, _remindMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurringTemplateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringTemplateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: $RecurringTemplatesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      cadence: $RecurringTemplatesTable.$convertercadence.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}cadence'],
        )!,
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      toAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}to_account_id'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      toAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}to_amount'],
      ),
      payeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payee_id'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      dueDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_day'],
      ),
      remind: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}remind'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdOn: $RecurringTemplatesTable.$convertercreatedOn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}created_on'],
        )!,
      ),
    );
  }

  @override
  $RecurringTemplatesTable createAlias(String alias) {
    return $RecurringTemplatesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MovementType, String, String> $convertertype =
      const EnumNameConverter<MovementType>(MovementType.values);
  static JsonTypeConverter2<RecurringCadence, String, String>
  $convertercadence = const EnumNameConverter<RecurringCadence>(
    RecurringCadence.values,
  );
  static TypeConverter<LocalDate, String> $convertercreatedOn =
      const LocalDateConverter();
}

class RecurringTemplateRow extends DataClass
    implements Insertable<RecurringTemplateRow> {
  final int id;
  final MovementType type;
  final RecurringCadence cadence;
  final int categoryId;
  final int accountId;
  final int? toAccountId;
  final int amount;
  final int? toAmount;
  final int? payeeId;
  final String? note;
  final int? dueDay;
  final bool remind;
  final bool isActive;
  final LocalDate createdOn;
  const RecurringTemplateRow({
    required this.id,
    required this.type,
    required this.cadence,
    required this.categoryId,
    required this.accountId,
    this.toAccountId,
    required this.amount,
    this.toAmount,
    this.payeeId,
    this.note,
    this.dueDay,
    required this.remind,
    required this.isActive,
    required this.createdOn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['type'] = Variable<String>(
        $RecurringTemplatesTable.$convertertype.toSql(type),
      );
    }
    {
      map['cadence'] = Variable<String>(
        $RecurringTemplatesTable.$convertercadence.toSql(cadence),
      );
    }
    map['category_id'] = Variable<int>(categoryId);
    map['account_id'] = Variable<int>(accountId);
    if (!nullToAbsent || toAccountId != null) {
      map['to_account_id'] = Variable<int>(toAccountId);
    }
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || toAmount != null) {
      map['to_amount'] = Variable<int>(toAmount);
    }
    if (!nullToAbsent || payeeId != null) {
      map['payee_id'] = Variable<int>(payeeId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || dueDay != null) {
      map['due_day'] = Variable<int>(dueDay);
    }
    map['remind'] = Variable<bool>(remind);
    map['is_active'] = Variable<bool>(isActive);
    {
      map['created_on'] = Variable<String>(
        $RecurringTemplatesTable.$convertercreatedOn.toSql(createdOn),
      );
    }
    return map;
  }

  RecurringTemplatesCompanion toCompanion(bool nullToAbsent) {
    return RecurringTemplatesCompanion(
      id: Value(id),
      type: Value(type),
      cadence: Value(cadence),
      categoryId: Value(categoryId),
      accountId: Value(accountId),
      toAccountId: toAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(toAccountId),
      amount: Value(amount),
      toAmount: toAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(toAmount),
      payeeId: payeeId == null && nullToAbsent
          ? const Value.absent()
          : Value(payeeId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      dueDay: dueDay == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDay),
      remind: Value(remind),
      isActive: Value(isActive),
      createdOn: Value(createdOn),
    );
  }

  factory RecurringTemplateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringTemplateRow(
      id: serializer.fromJson<int>(json['id']),
      type: $RecurringTemplatesTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      cadence: $RecurringTemplatesTable.$convertercadence.fromJson(
        serializer.fromJson<String>(json['cadence']),
      ),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      accountId: serializer.fromJson<int>(json['accountId']),
      toAccountId: serializer.fromJson<int?>(json['toAccountId']),
      amount: serializer.fromJson<int>(json['amount']),
      toAmount: serializer.fromJson<int?>(json['toAmount']),
      payeeId: serializer.fromJson<int?>(json['payeeId']),
      note: serializer.fromJson<String?>(json['note']),
      dueDay: serializer.fromJson<int?>(json['dueDay']),
      remind: serializer.fromJson<bool>(json['remind']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdOn: serializer.fromJson<LocalDate>(json['createdOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(
        $RecurringTemplatesTable.$convertertype.toJson(type),
      ),
      'cadence': serializer.toJson<String>(
        $RecurringTemplatesTable.$convertercadence.toJson(cadence),
      ),
      'categoryId': serializer.toJson<int>(categoryId),
      'accountId': serializer.toJson<int>(accountId),
      'toAccountId': serializer.toJson<int?>(toAccountId),
      'amount': serializer.toJson<int>(amount),
      'toAmount': serializer.toJson<int?>(toAmount),
      'payeeId': serializer.toJson<int?>(payeeId),
      'note': serializer.toJson<String?>(note),
      'dueDay': serializer.toJson<int?>(dueDay),
      'remind': serializer.toJson<bool>(remind),
      'isActive': serializer.toJson<bool>(isActive),
      'createdOn': serializer.toJson<LocalDate>(createdOn),
    };
  }

  RecurringTemplateRow copyWith({
    int? id,
    MovementType? type,
    RecurringCadence? cadence,
    int? categoryId,
    int? accountId,
    Value<int?> toAccountId = const Value.absent(),
    int? amount,
    Value<int?> toAmount = const Value.absent(),
    Value<int?> payeeId = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<int?> dueDay = const Value.absent(),
    bool? remind,
    bool? isActive,
    LocalDate? createdOn,
  }) => RecurringTemplateRow(
    id: id ?? this.id,
    type: type ?? this.type,
    cadence: cadence ?? this.cadence,
    categoryId: categoryId ?? this.categoryId,
    accountId: accountId ?? this.accountId,
    toAccountId: toAccountId.present ? toAccountId.value : this.toAccountId,
    amount: amount ?? this.amount,
    toAmount: toAmount.present ? toAmount.value : this.toAmount,
    payeeId: payeeId.present ? payeeId.value : this.payeeId,
    note: note.present ? note.value : this.note,
    dueDay: dueDay.present ? dueDay.value : this.dueDay,
    remind: remind ?? this.remind,
    isActive: isActive ?? this.isActive,
    createdOn: createdOn ?? this.createdOn,
  );
  RecurringTemplateRow copyWithCompanion(RecurringTemplatesCompanion data) {
    return RecurringTemplateRow(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      cadence: data.cadence.present ? data.cadence.value : this.cadence,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      toAccountId: data.toAccountId.present
          ? data.toAccountId.value
          : this.toAccountId,
      amount: data.amount.present ? data.amount.value : this.amount,
      toAmount: data.toAmount.present ? data.toAmount.value : this.toAmount,
      payeeId: data.payeeId.present ? data.payeeId.value : this.payeeId,
      note: data.note.present ? data.note.value : this.note,
      dueDay: data.dueDay.present ? data.dueDay.value : this.dueDay,
      remind: data.remind.present ? data.remind.value : this.remind,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdOn: data.createdOn.present ? data.createdOn.value : this.createdOn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringTemplateRow(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('cadence: $cadence, ')
          ..write('categoryId: $categoryId, ')
          ..write('accountId: $accountId, ')
          ..write('toAccountId: $toAccountId, ')
          ..write('amount: $amount, ')
          ..write('toAmount: $toAmount, ')
          ..write('payeeId: $payeeId, ')
          ..write('note: $note, ')
          ..write('dueDay: $dueDay, ')
          ..write('remind: $remind, ')
          ..write('isActive: $isActive, ')
          ..write('createdOn: $createdOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    cadence,
    categoryId,
    accountId,
    toAccountId,
    amount,
    toAmount,
    payeeId,
    note,
    dueDay,
    remind,
    isActive,
    createdOn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringTemplateRow &&
          other.id == this.id &&
          other.type == this.type &&
          other.cadence == this.cadence &&
          other.categoryId == this.categoryId &&
          other.accountId == this.accountId &&
          other.toAccountId == this.toAccountId &&
          other.amount == this.amount &&
          other.toAmount == this.toAmount &&
          other.payeeId == this.payeeId &&
          other.note == this.note &&
          other.dueDay == this.dueDay &&
          other.remind == this.remind &&
          other.isActive == this.isActive &&
          other.createdOn == this.createdOn);
}

class RecurringTemplatesCompanion
    extends UpdateCompanion<RecurringTemplateRow> {
  final Value<int> id;
  final Value<MovementType> type;
  final Value<RecurringCadence> cadence;
  final Value<int> categoryId;
  final Value<int> accountId;
  final Value<int?> toAccountId;
  final Value<int> amount;
  final Value<int?> toAmount;
  final Value<int?> payeeId;
  final Value<String?> note;
  final Value<int?> dueDay;
  final Value<bool> remind;
  final Value<bool> isActive;
  final Value<LocalDate> createdOn;
  const RecurringTemplatesCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.cadence = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.toAccountId = const Value.absent(),
    this.amount = const Value.absent(),
    this.toAmount = const Value.absent(),
    this.payeeId = const Value.absent(),
    this.note = const Value.absent(),
    this.dueDay = const Value.absent(),
    this.remind = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdOn = const Value.absent(),
  });
  RecurringTemplatesCompanion.insert({
    this.id = const Value.absent(),
    required MovementType type,
    required RecurringCadence cadence,
    required int categoryId,
    required int accountId,
    this.toAccountId = const Value.absent(),
    required int amount,
    this.toAmount = const Value.absent(),
    this.payeeId = const Value.absent(),
    this.note = const Value.absent(),
    this.dueDay = const Value.absent(),
    this.remind = const Value.absent(),
    this.isActive = const Value.absent(),
    required LocalDate createdOn,
  }) : type = Value(type),
       cadence = Value(cadence),
       categoryId = Value(categoryId),
       accountId = Value(accountId),
       amount = Value(amount),
       createdOn = Value(createdOn);
  static Insertable<RecurringTemplateRow> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? cadence,
    Expression<int>? categoryId,
    Expression<int>? accountId,
    Expression<int>? toAccountId,
    Expression<int>? amount,
    Expression<int>? toAmount,
    Expression<int>? payeeId,
    Expression<String>? note,
    Expression<int>? dueDay,
    Expression<bool>? remind,
    Expression<bool>? isActive,
    Expression<String>? createdOn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (cadence != null) 'cadence': cadence,
      if (categoryId != null) 'category_id': categoryId,
      if (accountId != null) 'account_id': accountId,
      if (toAccountId != null) 'to_account_id': toAccountId,
      if (amount != null) 'amount': amount,
      if (toAmount != null) 'to_amount': toAmount,
      if (payeeId != null) 'payee_id': payeeId,
      if (note != null) 'note': note,
      if (dueDay != null) 'due_day': dueDay,
      if (remind != null) 'remind': remind,
      if (isActive != null) 'is_active': isActive,
      if (createdOn != null) 'created_on': createdOn,
    });
  }

  RecurringTemplatesCompanion copyWith({
    Value<int>? id,
    Value<MovementType>? type,
    Value<RecurringCadence>? cadence,
    Value<int>? categoryId,
    Value<int>? accountId,
    Value<int?>? toAccountId,
    Value<int>? amount,
    Value<int?>? toAmount,
    Value<int?>? payeeId,
    Value<String?>? note,
    Value<int?>? dueDay,
    Value<bool>? remind,
    Value<bool>? isActive,
    Value<LocalDate>? createdOn,
  }) {
    return RecurringTemplatesCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      cadence: cadence ?? this.cadence,
      categoryId: categoryId ?? this.categoryId,
      accountId: accountId ?? this.accountId,
      toAccountId: toAccountId ?? this.toAccountId,
      amount: amount ?? this.amount,
      toAmount: toAmount ?? this.toAmount,
      payeeId: payeeId ?? this.payeeId,
      note: note ?? this.note,
      dueDay: dueDay ?? this.dueDay,
      remind: remind ?? this.remind,
      isActive: isActive ?? this.isActive,
      createdOn: createdOn ?? this.createdOn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $RecurringTemplatesTable.$convertertype.toSql(type.value),
      );
    }
    if (cadence.present) {
      map['cadence'] = Variable<String>(
        $RecurringTemplatesTable.$convertercadence.toSql(cadence.value),
      );
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (toAccountId.present) {
      map['to_account_id'] = Variable<int>(toAccountId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (toAmount.present) {
      map['to_amount'] = Variable<int>(toAmount.value);
    }
    if (payeeId.present) {
      map['payee_id'] = Variable<int>(payeeId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (dueDay.present) {
      map['due_day'] = Variable<int>(dueDay.value);
    }
    if (remind.present) {
      map['remind'] = Variable<bool>(remind.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdOn.present) {
      map['created_on'] = Variable<String>(
        $RecurringTemplatesTable.$convertercreatedOn.toSql(createdOn.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurringTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('cadence: $cadence, ')
          ..write('categoryId: $categoryId, ')
          ..write('accountId: $accountId, ')
          ..write('toAccountId: $toAccountId, ')
          ..write('amount: $amount, ')
          ..write('toAmount: $toAmount, ')
          ..write('payeeId: $payeeId, ')
          ..write('note: $note, ')
          ..write('dueDay: $dueDay, ')
          ..write('remind: $remind, ')
          ..write('isActive: $isActive, ')
          ..write('createdOn: $createdOn')
          ..write(')'))
        .toString();
  }
}

class $MovementsTable extends Movements
    with TableInfo<$MovementsTable, MovementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovementsTable(this.attachedDatabase, [this._alias]);
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
  @override
  late final GeneratedColumnWithTypeConverter<MovementType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<MovementType>($MovementsTable.$convertertype);
  @override
  late final GeneratedColumnWithTypeConverter<LocalDate, String> date =
      GeneratedColumn<String>(
        'date',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LocalDate>($MovementsTable.$converterdate);
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toAccountIdMeta = const VerificationMeta(
    'toAccountId',
  );
  @override
  late final GeneratedColumn<int> toAccountId = GeneratedColumn<int>(
    'to_account_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _toAmountMeta = const VerificationMeta(
    'toAmount',
  );
  @override
  late final GeneratedColumn<int> toAmount = GeneratedColumn<int>(
    'to_amount',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _payeeIdMeta = const VerificationMeta(
    'payeeId',
  );
  @override
  late final GeneratedColumn<int> payeeId = GeneratedColumn<int>(
    'payee_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES payees (id)',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _debtIdMeta = const VerificationMeta('debtId');
  @override
  late final GeneratedColumn<int> debtId = GeneratedColumn<int>(
    'debt_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recurringTemplateIdMeta =
      const VerificationMeta('recurringTemplateId');
  @override
  late final GeneratedColumn<int> recurringTemplateId = GeneratedColumn<int>(
    'recurring_template_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recurring_templates (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _isPendingMeta = const VerificationMeta(
    'isPending',
  );
  @override
  late final GeneratedColumn<bool> isPending = GeneratedColumn<bool>(
    'is_pending',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_pending" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _startsPeriodMeta = const VerificationMeta(
    'startsPeriod',
  );
  @override
  late final GeneratedColumn<bool> startsPeriod = GeneratedColumn<bool>(
    'starts_period',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("starts_period" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    date,
    accountId,
    amount,
    toAccountId,
    toAmount,
    categoryId,
    payeeId,
    note,
    debtId,
    recurringTemplateId,
    isPending,
    startsPeriod,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movements';
  @override
  VerificationContext validateIntegrity(
    Insertable<MovementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('to_account_id')) {
      context.handle(
        _toAccountIdMeta,
        toAccountId.isAcceptableOrUnknown(
          data['to_account_id']!,
          _toAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('to_amount')) {
      context.handle(
        _toAmountMeta,
        toAmount.isAcceptableOrUnknown(data['to_amount']!, _toAmountMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('payee_id')) {
      context.handle(
        _payeeIdMeta,
        payeeId.isAcceptableOrUnknown(data['payee_id']!, _payeeIdMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('debt_id')) {
      context.handle(
        _debtIdMeta,
        debtId.isAcceptableOrUnknown(data['debt_id']!, _debtIdMeta),
      );
    }
    if (data.containsKey('recurring_template_id')) {
      context.handle(
        _recurringTemplateIdMeta,
        recurringTemplateId.isAcceptableOrUnknown(
          data['recurring_template_id']!,
          _recurringTemplateIdMeta,
        ),
      );
    }
    if (data.containsKey('is_pending')) {
      context.handle(
        _isPendingMeta,
        isPending.isAcceptableOrUnknown(data['is_pending']!, _isPendingMeta),
      );
    }
    if (data.containsKey('starts_period')) {
      context.handle(
        _startsPeriodMeta,
        startsPeriod.isAcceptableOrUnknown(
          data['starts_period']!,
          _startsPeriodMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovementRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: $MovementsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      date: $MovementsTable.$converterdate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}date'],
        )!,
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      toAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}to_account_id'],
      ),
      toAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}to_amount'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      payeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payee_id'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      debtId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}debt_id'],
      ),
      recurringTemplateId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recurring_template_id'],
      ),
      isPending: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_pending'],
      )!,
      startsPeriod: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}starts_period'],
      )!,
    );
  }

  @override
  $MovementsTable createAlias(String alias) {
    return $MovementsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MovementType, String, String> $convertertype =
      const EnumNameConverter<MovementType>(MovementType.values);
  static TypeConverter<LocalDate, String> $converterdate =
      const LocalDateConverter();
}

class MovementRow extends DataClass implements Insertable<MovementRow> {
  final int id;
  final MovementType type;
  final LocalDate date;
  final int accountId;
  final int amount;
  final int? toAccountId;
  final int? toAmount;
  final int? categoryId;
  final int? payeeId;
  final String? note;
  final int? debtId;

  /// Template that created it; deleting the template keeps the movement.
  final int? recurringTemplateId;
  final bool isPending;
  final bool startsPeriod;
  const MovementRow({
    required this.id,
    required this.type,
    required this.date,
    required this.accountId,
    required this.amount,
    this.toAccountId,
    this.toAmount,
    this.categoryId,
    this.payeeId,
    this.note,
    this.debtId,
    this.recurringTemplateId,
    required this.isPending,
    required this.startsPeriod,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['type'] = Variable<String>(
        $MovementsTable.$convertertype.toSql(type),
      );
    }
    {
      map['date'] = Variable<String>(
        $MovementsTable.$converterdate.toSql(date),
      );
    }
    map['account_id'] = Variable<int>(accountId);
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || toAccountId != null) {
      map['to_account_id'] = Variable<int>(toAccountId);
    }
    if (!nullToAbsent || toAmount != null) {
      map['to_amount'] = Variable<int>(toAmount);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || payeeId != null) {
      map['payee_id'] = Variable<int>(payeeId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || debtId != null) {
      map['debt_id'] = Variable<int>(debtId);
    }
    if (!nullToAbsent || recurringTemplateId != null) {
      map['recurring_template_id'] = Variable<int>(recurringTemplateId);
    }
    map['is_pending'] = Variable<bool>(isPending);
    map['starts_period'] = Variable<bool>(startsPeriod);
    return map;
  }

  MovementsCompanion toCompanion(bool nullToAbsent) {
    return MovementsCompanion(
      id: Value(id),
      type: Value(type),
      date: Value(date),
      accountId: Value(accountId),
      amount: Value(amount),
      toAccountId: toAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(toAccountId),
      toAmount: toAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(toAmount),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      payeeId: payeeId == null && nullToAbsent
          ? const Value.absent()
          : Value(payeeId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      debtId: debtId == null && nullToAbsent
          ? const Value.absent()
          : Value(debtId),
      recurringTemplateId: recurringTemplateId == null && nullToAbsent
          ? const Value.absent()
          : Value(recurringTemplateId),
      isPending: Value(isPending),
      startsPeriod: Value(startsPeriod),
    );
  }

  factory MovementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovementRow(
      id: serializer.fromJson<int>(json['id']),
      type: $MovementsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      date: serializer.fromJson<LocalDate>(json['date']),
      accountId: serializer.fromJson<int>(json['accountId']),
      amount: serializer.fromJson<int>(json['amount']),
      toAccountId: serializer.fromJson<int?>(json['toAccountId']),
      toAmount: serializer.fromJson<int?>(json['toAmount']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      payeeId: serializer.fromJson<int?>(json['payeeId']),
      note: serializer.fromJson<String?>(json['note']),
      debtId: serializer.fromJson<int?>(json['debtId']),
      recurringTemplateId: serializer.fromJson<int?>(
        json['recurringTemplateId'],
      ),
      isPending: serializer.fromJson<bool>(json['isPending']),
      startsPeriod: serializer.fromJson<bool>(json['startsPeriod']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(
        $MovementsTable.$convertertype.toJson(type),
      ),
      'date': serializer.toJson<LocalDate>(date),
      'accountId': serializer.toJson<int>(accountId),
      'amount': serializer.toJson<int>(amount),
      'toAccountId': serializer.toJson<int?>(toAccountId),
      'toAmount': serializer.toJson<int?>(toAmount),
      'categoryId': serializer.toJson<int?>(categoryId),
      'payeeId': serializer.toJson<int?>(payeeId),
      'note': serializer.toJson<String?>(note),
      'debtId': serializer.toJson<int?>(debtId),
      'recurringTemplateId': serializer.toJson<int?>(recurringTemplateId),
      'isPending': serializer.toJson<bool>(isPending),
      'startsPeriod': serializer.toJson<bool>(startsPeriod),
    };
  }

  MovementRow copyWith({
    int? id,
    MovementType? type,
    LocalDate? date,
    int? accountId,
    int? amount,
    Value<int?> toAccountId = const Value.absent(),
    Value<int?> toAmount = const Value.absent(),
    Value<int?> categoryId = const Value.absent(),
    Value<int?> payeeId = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<int?> debtId = const Value.absent(),
    Value<int?> recurringTemplateId = const Value.absent(),
    bool? isPending,
    bool? startsPeriod,
  }) => MovementRow(
    id: id ?? this.id,
    type: type ?? this.type,
    date: date ?? this.date,
    accountId: accountId ?? this.accountId,
    amount: amount ?? this.amount,
    toAccountId: toAccountId.present ? toAccountId.value : this.toAccountId,
    toAmount: toAmount.present ? toAmount.value : this.toAmount,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    payeeId: payeeId.present ? payeeId.value : this.payeeId,
    note: note.present ? note.value : this.note,
    debtId: debtId.present ? debtId.value : this.debtId,
    recurringTemplateId: recurringTemplateId.present
        ? recurringTemplateId.value
        : this.recurringTemplateId,
    isPending: isPending ?? this.isPending,
    startsPeriod: startsPeriod ?? this.startsPeriod,
  );
  MovementRow copyWithCompanion(MovementsCompanion data) {
    return MovementRow(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      date: data.date.present ? data.date.value : this.date,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      amount: data.amount.present ? data.amount.value : this.amount,
      toAccountId: data.toAccountId.present
          ? data.toAccountId.value
          : this.toAccountId,
      toAmount: data.toAmount.present ? data.toAmount.value : this.toAmount,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      payeeId: data.payeeId.present ? data.payeeId.value : this.payeeId,
      note: data.note.present ? data.note.value : this.note,
      debtId: data.debtId.present ? data.debtId.value : this.debtId,
      recurringTemplateId: data.recurringTemplateId.present
          ? data.recurringTemplateId.value
          : this.recurringTemplateId,
      isPending: data.isPending.present ? data.isPending.value : this.isPending,
      startsPeriod: data.startsPeriod.present
          ? data.startsPeriod.value
          : this.startsPeriod,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MovementRow(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('accountId: $accountId, ')
          ..write('amount: $amount, ')
          ..write('toAccountId: $toAccountId, ')
          ..write('toAmount: $toAmount, ')
          ..write('categoryId: $categoryId, ')
          ..write('payeeId: $payeeId, ')
          ..write('note: $note, ')
          ..write('debtId: $debtId, ')
          ..write('recurringTemplateId: $recurringTemplateId, ')
          ..write('isPending: $isPending, ')
          ..write('startsPeriod: $startsPeriod')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    date,
    accountId,
    amount,
    toAccountId,
    toAmount,
    categoryId,
    payeeId,
    note,
    debtId,
    recurringTemplateId,
    isPending,
    startsPeriod,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovementRow &&
          other.id == this.id &&
          other.type == this.type &&
          other.date == this.date &&
          other.accountId == this.accountId &&
          other.amount == this.amount &&
          other.toAccountId == this.toAccountId &&
          other.toAmount == this.toAmount &&
          other.categoryId == this.categoryId &&
          other.payeeId == this.payeeId &&
          other.note == this.note &&
          other.debtId == this.debtId &&
          other.recurringTemplateId == this.recurringTemplateId &&
          other.isPending == this.isPending &&
          other.startsPeriod == this.startsPeriod);
}

class MovementsCompanion extends UpdateCompanion<MovementRow> {
  final Value<int> id;
  final Value<MovementType> type;
  final Value<LocalDate> date;
  final Value<int> accountId;
  final Value<int> amount;
  final Value<int?> toAccountId;
  final Value<int?> toAmount;
  final Value<int?> categoryId;
  final Value<int?> payeeId;
  final Value<String?> note;
  final Value<int?> debtId;
  final Value<int?> recurringTemplateId;
  final Value<bool> isPending;
  final Value<bool> startsPeriod;
  const MovementsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.date = const Value.absent(),
    this.accountId = const Value.absent(),
    this.amount = const Value.absent(),
    this.toAccountId = const Value.absent(),
    this.toAmount = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.payeeId = const Value.absent(),
    this.note = const Value.absent(),
    this.debtId = const Value.absent(),
    this.recurringTemplateId = const Value.absent(),
    this.isPending = const Value.absent(),
    this.startsPeriod = const Value.absent(),
  });
  MovementsCompanion.insert({
    this.id = const Value.absent(),
    required MovementType type,
    required LocalDate date,
    required int accountId,
    required int amount,
    this.toAccountId = const Value.absent(),
    this.toAmount = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.payeeId = const Value.absent(),
    this.note = const Value.absent(),
    this.debtId = const Value.absent(),
    this.recurringTemplateId = const Value.absent(),
    this.isPending = const Value.absent(),
    this.startsPeriod = const Value.absent(),
  }) : type = Value(type),
       date = Value(date),
       accountId = Value(accountId),
       amount = Value(amount);
  static Insertable<MovementRow> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? date,
    Expression<int>? accountId,
    Expression<int>? amount,
    Expression<int>? toAccountId,
    Expression<int>? toAmount,
    Expression<int>? categoryId,
    Expression<int>? payeeId,
    Expression<String>? note,
    Expression<int>? debtId,
    Expression<int>? recurringTemplateId,
    Expression<bool>? isPending,
    Expression<bool>? startsPeriod,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (date != null) 'date': date,
      if (accountId != null) 'account_id': accountId,
      if (amount != null) 'amount': amount,
      if (toAccountId != null) 'to_account_id': toAccountId,
      if (toAmount != null) 'to_amount': toAmount,
      if (categoryId != null) 'category_id': categoryId,
      if (payeeId != null) 'payee_id': payeeId,
      if (note != null) 'note': note,
      if (debtId != null) 'debt_id': debtId,
      if (recurringTemplateId != null)
        'recurring_template_id': recurringTemplateId,
      if (isPending != null) 'is_pending': isPending,
      if (startsPeriod != null) 'starts_period': startsPeriod,
    });
  }

  MovementsCompanion copyWith({
    Value<int>? id,
    Value<MovementType>? type,
    Value<LocalDate>? date,
    Value<int>? accountId,
    Value<int>? amount,
    Value<int?>? toAccountId,
    Value<int?>? toAmount,
    Value<int?>? categoryId,
    Value<int?>? payeeId,
    Value<String?>? note,
    Value<int?>? debtId,
    Value<int?>? recurringTemplateId,
    Value<bool>? isPending,
    Value<bool>? startsPeriod,
  }) {
    return MovementsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      date: date ?? this.date,
      accountId: accountId ?? this.accountId,
      amount: amount ?? this.amount,
      toAccountId: toAccountId ?? this.toAccountId,
      toAmount: toAmount ?? this.toAmount,
      categoryId: categoryId ?? this.categoryId,
      payeeId: payeeId ?? this.payeeId,
      note: note ?? this.note,
      debtId: debtId ?? this.debtId,
      recurringTemplateId: recurringTemplateId ?? this.recurringTemplateId,
      isPending: isPending ?? this.isPending,
      startsPeriod: startsPeriod ?? this.startsPeriod,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $MovementsTable.$convertertype.toSql(type.value),
      );
    }
    if (date.present) {
      map['date'] = Variable<String>(
        $MovementsTable.$converterdate.toSql(date.value),
      );
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (toAccountId.present) {
      map['to_account_id'] = Variable<int>(toAccountId.value);
    }
    if (toAmount.present) {
      map['to_amount'] = Variable<int>(toAmount.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (payeeId.present) {
      map['payee_id'] = Variable<int>(payeeId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (debtId.present) {
      map['debt_id'] = Variable<int>(debtId.value);
    }
    if (recurringTemplateId.present) {
      map['recurring_template_id'] = Variable<int>(recurringTemplateId.value);
    }
    if (isPending.present) {
      map['is_pending'] = Variable<bool>(isPending.value);
    }
    if (startsPeriod.present) {
      map['starts_period'] = Variable<bool>(startsPeriod.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovementsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('accountId: $accountId, ')
          ..write('amount: $amount, ')
          ..write('toAccountId: $toAccountId, ')
          ..write('toAmount: $toAmount, ')
          ..write('categoryId: $categoryId, ')
          ..write('payeeId: $payeeId, ')
          ..write('note: $note, ')
          ..write('debtId: $debtId, ')
          ..write('recurringTemplateId: $recurringTemplateId, ')
          ..write('isPending: $isPending, ')
          ..write('startsPeriod: $startsPeriod')
          ..write(')'))
        .toString();
  }
}

class $PeriodStartsTable extends PeriodStarts
    with TableInfo<$PeriodStartsTable, PeriodStartRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PeriodStartsTable(this.attachedDatabase, [this._alias]);
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
  @override
  late final GeneratedColumnWithTypeConverter<LocalDate, String> date =
      GeneratedColumn<String>(
        'date',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
      ).withConverter<LocalDate>($PeriodStartsTable.$converterdate);
  @override
  List<GeneratedColumn> get $columns => [id, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'period_starts';
  @override
  VerificationContext validateIntegrity(
    Insertable<PeriodStartRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PeriodStartRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PeriodStartRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: $PeriodStartsTable.$converterdate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}date'],
        )!,
      ),
    );
  }

  @override
  $PeriodStartsTable createAlias(String alias) {
    return $PeriodStartsTable(attachedDatabase, alias);
  }

  static TypeConverter<LocalDate, String> $converterdate =
      const LocalDateConverter();
}

class PeriodStartRow extends DataClass implements Insertable<PeriodStartRow> {
  final int id;
  final LocalDate date;
  const PeriodStartRow({required this.id, required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['date'] = Variable<String>(
        $PeriodStartsTable.$converterdate.toSql(date),
      );
    }
    return map;
  }

  PeriodStartsCompanion toCompanion(bool nullToAbsent) {
    return PeriodStartsCompanion(id: Value(id), date: Value(date));
  }

  factory PeriodStartRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PeriodStartRow(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<LocalDate>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<LocalDate>(date),
    };
  }

  PeriodStartRow copyWith({int? id, LocalDate? date}) =>
      PeriodStartRow(id: id ?? this.id, date: date ?? this.date);
  PeriodStartRow copyWithCompanion(PeriodStartsCompanion data) {
    return PeriodStartRow(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PeriodStartRow(')
          ..write('id: $id, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PeriodStartRow &&
          other.id == this.id &&
          other.date == this.date);
}

class PeriodStartsCompanion extends UpdateCompanion<PeriodStartRow> {
  final Value<int> id;
  final Value<LocalDate> date;
  const PeriodStartsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
  });
  PeriodStartsCompanion.insert({
    this.id = const Value.absent(),
    required LocalDate date,
  }) : date = Value(date);
  static Insertable<PeriodStartRow> custom({
    Expression<int>? id,
    Expression<String>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
    });
  }

  PeriodStartsCompanion copyWith({Value<int>? id, Value<LocalDate>? date}) {
    return PeriodStartsCompanion(id: id ?? this.id, date: date ?? this.date);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(
        $PeriodStartsTable.$converterdate.toSql(date.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PeriodStartsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $RecurringOccurrencesTable extends RecurringOccurrences
    with TableInfo<$RecurringOccurrencesTable, RecurringOccurrenceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringOccurrencesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recurring_templates (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<LocalDate, String> periodStart =
      GeneratedColumn<String>(
        'period_start',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LocalDate>(
        $RecurringOccurrencesTable.$converterperiodStart,
      );
  @override
  List<GeneratedColumn> get $columns => [id, templateId, periodStart];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_occurrences';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecurringOccurrenceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {templateId, periodStart},
  ];
  @override
  RecurringOccurrenceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringOccurrenceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}template_id'],
      )!,
      periodStart: $RecurringOccurrencesTable.$converterperiodStart.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}period_start'],
        )!,
      ),
    );
  }

  @override
  $RecurringOccurrencesTable createAlias(String alias) {
    return $RecurringOccurrencesTable(attachedDatabase, alias);
  }

  static TypeConverter<LocalDate, String> $converterperiodStart =
      const LocalDateConverter();
}

class RecurringOccurrenceRow extends DataClass
    implements Insertable<RecurringOccurrenceRow> {
  final int id;
  final int templateId;
  final LocalDate periodStart;
  const RecurringOccurrenceRow({
    required this.id,
    required this.templateId,
    required this.periodStart,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['template_id'] = Variable<int>(templateId);
    {
      map['period_start'] = Variable<String>(
        $RecurringOccurrencesTable.$converterperiodStart.toSql(periodStart),
      );
    }
    return map;
  }

  RecurringOccurrencesCompanion toCompanion(bool nullToAbsent) {
    return RecurringOccurrencesCompanion(
      id: Value(id),
      templateId: Value(templateId),
      periodStart: Value(periodStart),
    );
  }

  factory RecurringOccurrenceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringOccurrenceRow(
      id: serializer.fromJson<int>(json['id']),
      templateId: serializer.fromJson<int>(json['templateId']),
      periodStart: serializer.fromJson<LocalDate>(json['periodStart']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'templateId': serializer.toJson<int>(templateId),
      'periodStart': serializer.toJson<LocalDate>(periodStart),
    };
  }

  RecurringOccurrenceRow copyWith({
    int? id,
    int? templateId,
    LocalDate? periodStart,
  }) => RecurringOccurrenceRow(
    id: id ?? this.id,
    templateId: templateId ?? this.templateId,
    periodStart: periodStart ?? this.periodStart,
  );
  RecurringOccurrenceRow copyWithCompanion(RecurringOccurrencesCompanion data) {
    return RecurringOccurrenceRow(
      id: data.id.present ? data.id.value : this.id,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      periodStart: data.periodStart.present
          ? data.periodStart.value
          : this.periodStart,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringOccurrenceRow(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('periodStart: $periodStart')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, templateId, periodStart);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringOccurrenceRow &&
          other.id == this.id &&
          other.templateId == this.templateId &&
          other.periodStart == this.periodStart);
}

class RecurringOccurrencesCompanion
    extends UpdateCompanion<RecurringOccurrenceRow> {
  final Value<int> id;
  final Value<int> templateId;
  final Value<LocalDate> periodStart;
  const RecurringOccurrencesCompanion({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    this.periodStart = const Value.absent(),
  });
  RecurringOccurrencesCompanion.insert({
    this.id = const Value.absent(),
    required int templateId,
    required LocalDate periodStart,
  }) : templateId = Value(templateId),
       periodStart = Value(periodStart);
  static Insertable<RecurringOccurrenceRow> custom({
    Expression<int>? id,
    Expression<int>? templateId,
    Expression<String>? periodStart,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (templateId != null) 'template_id': templateId,
      if (periodStart != null) 'period_start': periodStart,
    });
  }

  RecurringOccurrencesCompanion copyWith({
    Value<int>? id,
    Value<int>? templateId,
    Value<LocalDate>? periodStart,
  }) {
    return RecurringOccurrencesCompanion(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      periodStart: periodStart ?? this.periodStart,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
    }
    if (periodStart.present) {
      map['period_start'] = Variable<String>(
        $RecurringOccurrencesTable.$converterperiodStart.toSql(
          periodStart.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurringOccurrencesCompanion(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('periodStart: $periodStart')
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
  late final $PillarsTable pillars = $PillarsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $PayeesTable payees = $PayeesTable(this);
  late final $RecurringTemplatesTable recurringTemplates =
      $RecurringTemplatesTable(this);
  late final $MovementsTable movements = $MovementsTable(this);
  late final $PeriodStartsTable periodStarts = $PeriodStartsTable(this);
  late final $RecurringOccurrencesTable recurringOccurrences =
      $RecurringOccurrencesTable(this);
  late final Index movementsAccount = Index(
    'movements_account',
    'CREATE INDEX movements_account ON movements (account_id)',
  );
  late final Index movementsToAccount = Index(
    'movements_to_account',
    'CREATE INDEX movements_to_account ON movements (to_account_id)',
  );
  late final Index movementsCategory = Index(
    'movements_category',
    'CREATE INDEX movements_category ON movements (category_id)',
  );
  late final Index movementsDate = Index(
    'movements_date',
    'CREATE INDEX movements_date ON movements (date)',
  );
  late final CurrencyDao currencyDao = CurrencyDao(this as AppDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  late final AccountDao accountDao = AccountDao(this as AppDatabase);
  late final CategoryDao categoryDao = CategoryDao(this as AppDatabase);
  late final MovementDao movementDao = MovementDao(this as AppDatabase);
  late final PeriodDao periodDao = PeriodDao(this as AppDatabase);
  late final RecurringDao recurringDao = RecurringDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    currencies,
    settingsTable,
    accounts,
    pillars,
    categories,
    payees,
    recurringTemplates,
    movements,
    periodStarts,
    recurringOccurrences,
    movementsAccount,
    movementsToAccount,
    movementsCategory,
    movementsDate,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recurring_templates', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recurring_templates', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recurring_templates',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('movements', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recurring_templates',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recurring_occurrences', kind: UpdateKind.delete)],
    ),
  ]);
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
typedef $$PillarsTableCreateCompanionBuilder = PillarsCompanion Function({
  Value<int> id,
  required String name,
  required int color,
  required int sortOrder,
});
typedef $$PillarsTableUpdateCompanionBuilder = PillarsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> color,
  Value<int> sortOrder,
});

final class $$PillarsTableReferences
    extends BaseReferences<_$AppDatabase, $PillarsTable, PillarRow> {
  $$PillarsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CategoriesTable, List<CategoryRow>>
  _categoriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.categories,
    aliasName: 'pillars__id__categories__pillar_id',
  );

  $$CategoriesTableProcessedTableManager get categoriesRefs {
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.pillarId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_categoriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PillarsTableFilterComposer
    extends Composer<_$AppDatabase, $PillarsTable> {
  $$PillarsTableFilterComposer({
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

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> categoriesRefs(
    Expression<bool> Function($$CategoriesTableFilterComposer f) f,
  ) {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.pillarId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PillarsTableOrderingComposer
    extends Composer<_$AppDatabase, $PillarsTable> {
  $$PillarsTableOrderingComposer({
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

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PillarsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PillarsTable> {
  $$PillarsTableAnnotationComposer({
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

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> categoriesRefs<T extends Object>(
    Expression<T> Function($$CategoriesTableAnnotationComposer a) f,
  ) {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.pillarId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PillarsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PillarsTable,
          PillarRow,
          $$PillarsTableFilterComposer,
          $$PillarsTableOrderingComposer,
          $$PillarsTableAnnotationComposer,
          $$PillarsTableCreateCompanionBuilder,
          $$PillarsTableUpdateCompanionBuilder,
          (PillarRow, $$PillarsTableReferences),
          PillarRow,
          PrefetchHooks Function({bool categoriesRefs})
        > {
  $$PillarsTableTableManager(_$AppDatabase db, $PillarsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PillarsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PillarsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PillarsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => PillarsCompanion(
                id: id,
                name: name,
                color: color,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int color,
                required int sortOrder,
              }) => PillarsCompanion.insert(
                id: id,
                name: name,
                color: color,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PillarsTable, PillarRow>(table),
                  $$PillarsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (categoriesRefs) db.categories],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (categoriesRefs)
                    await $_getPrefetchedDataByColumns<
                      PillarRow,
                      $PillarsTable,
                      CategoryRow,
                      $CategoriesTable
                    >(
                      currentTable: table,
                      referencedTable: $$PillarsTableReferences
                          ._categoriesRefsTable(db),
                      managerFromTypedResult: (p0) => $$PillarsTableReferences(
                        db,
                        table,
                        p0,
                      ).categoriesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'pillar_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PillarsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PillarsTable,
      PillarRow,
      $$PillarsTableFilterComposer,
      $$PillarsTableOrderingComposer,
      $$PillarsTableAnnotationComposer,
      $$PillarsTableCreateCompanionBuilder,
      $$PillarsTableUpdateCompanionBuilder,
      (PillarRow, $$PillarsTableReferences),
      PillarRow,
      PrefetchHooks Function({bool categoriesRefs})
    >;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  required CategoryType type,
  required CategoryRole role,
  required String name,
  required String iconKey,
  required int color,
  Value<int?> pillarId,
  Value<String?> defaultName,
  Value<String?> defaultIconKey,
  required int sortOrder,
  Value<bool> isArchived,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  Value<CategoryType> type,
  Value<CategoryRole> role,
  Value<String> name,
  Value<String> iconKey,
  Value<int> color,
  Value<int?> pillarId,
  Value<String?> defaultName,
  Value<String?> defaultIconKey,
  Value<int> sortOrder,
  Value<bool> isArchived,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, CategoryRow> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PillarsTable _pillarIdTable(_$AppDatabase db) =>
      db.pillars.createAlias('categories__pillar_id__pillars__id');

  $$PillarsTableProcessedTableManager? get pillarId {
    final $_column = $_itemColumn<int>('pillar_id');
    if ($_column == null) return null;
    final manager = $$PillarsTableTableManager(
      $_db,
      $_db.pillars,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pillarIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $RecurringTemplatesTable,
    List<RecurringTemplateRow>
  >
  _recurringTemplatesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recurringTemplates,
        aliasName: 'categories__id__recurring_templates__category_id',
      );

  $$RecurringTemplatesTableProcessedTableManager get recurringTemplatesRefs {
    final manager = $$RecurringTemplatesTableTableManager(
      $_db,
      $_db.recurringTemplates,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurringTemplatesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MovementsTable, List<MovementRow>>
  _movementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.movements,
    aliasName: 'categories__id__movements__category_id',
  );

  $$MovementsTableProcessedTableManager get movementsRefs {
    final manager = $$MovementsTableTableManager(
      $_db,
      $_db.movements,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_movementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
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

  ColumnWithTypeConverterFilters<CategoryType, CategoryType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<CategoryRole, CategoryRole, String> get role =>
      $composableBuilder(
        column: $table.role,
        builder: (column) => ColumnWithTypeConverterFilters(column),
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

  ColumnFilters<String> get defaultName => $composableBuilder(
    column: $table.defaultName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultIconKey => $composableBuilder(
    column: $table.defaultIconKey,
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

  $$PillarsTableFilterComposer get pillarId {
    final $$PillarsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pillarId,
      referencedTable: $db.pillars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PillarsTableFilterComposer(
            $db: $db,
            $table: $db.pillars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> recurringTemplatesRefs(
    Expression<bool> Function($$RecurringTemplatesTableFilterComposer f) f,
  ) {
    final $$RecurringTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringTemplates,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.recurringTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> movementsRefs(
    Expression<bool> Function($$MovementsTableFilterComposer f) f,
  ) {
    final $$MovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementsTableFilterComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
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

  ColumnOrderings<String> get defaultName => $composableBuilder(
    column: $table.defaultName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultIconKey => $composableBuilder(
    column: $table.defaultIconKey,
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

  $$PillarsTableOrderingComposer get pillarId {
    final $$PillarsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pillarId,
      referencedTable: $db.pillars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PillarsTableOrderingComposer(
            $db: $db,
            $table: $db.pillars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CategoryType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CategoryRole, String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get defaultName => $composableBuilder(
    column: $table.defaultName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultIconKey => $composableBuilder(
    column: $table.defaultIconKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  $$PillarsTableAnnotationComposer get pillarId {
    final $$PillarsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pillarId,
      referencedTable: $db.pillars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PillarsTableAnnotationComposer(
            $db: $db,
            $table: $db.pillars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> recurringTemplatesRefs<T extends Object>(
    Expression<T> Function($$RecurringTemplatesTableAnnotationComposer a) f,
  ) {
    final $$RecurringTemplatesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recurringTemplates,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurringTemplatesTableAnnotationComposer(
                $db: $db,
                $table: $db.recurringTemplates,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> movementsRefs<T extends Object>(
    Expression<T> Function($$MovementsTableAnnotationComposer a) f,
  ) {
    final $$MovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          CategoryRow,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (CategoryRow, $$CategoriesTableReferences),
          CategoryRow,
          PrefetchHooks Function({
            bool pillarId,
            bool recurringTemplatesRefs,
            bool movementsRefs,
          })
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<CategoryType> type = const Value.absent(),
                Value<CategoryRole> role = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> iconKey = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<int?> pillarId = const Value.absent(),
                Value<String?> defaultName = const Value.absent(),
                Value<String?> defaultIconKey = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                type: type,
                role: role,
                name: name,
                iconKey: iconKey,
                color: color,
                pillarId: pillarId,
                defaultName: defaultName,
                defaultIconKey: defaultIconKey,
                sortOrder: sortOrder,
                isArchived: isArchived,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required CategoryType type,
                required CategoryRole role,
                required String name,
                required String iconKey,
                required int color,
                Value<int?> pillarId = const Value.absent(),
                Value<String?> defaultName = const Value.absent(),
                Value<String?> defaultIconKey = const Value.absent(),
                required int sortOrder,
                Value<bool> isArchived = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                type: type,
                role: role,
                name: name,
                iconKey: iconKey,
                color: color,
                pillarId: pillarId,
                defaultName: defaultName,
                defaultIconKey: defaultIconKey,
                sortOrder: sortOrder,
                isArchived: isArchived,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriesTable, CategoryRow>(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                pillarId = false,
                recurringTemplatesRefs = false,
                movementsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recurringTemplatesRefs) db.recurringTemplates,
                    if (movementsRefs) db.movements,
                  ],
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
                        if (pillarId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.pillarId,
                            referencedTable: $$CategoriesTableReferences
                                ._pillarIdTable(db),
                            referencedColumn: $$CategoriesTableReferences
                                ._pillarIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recurringTemplatesRefs)
                        await $_getPrefetchedDataByColumns<
                          CategoryRow,
                          $CategoriesTable,
                          RecurringTemplateRow,
                          $RecurringTemplatesTable
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._recurringTemplatesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).recurringTemplatesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'category_id',
                          typedResults: items,
                        ),
                      if (movementsRefs)
                        await $_getPrefetchedDataByColumns<
                          CategoryRow,
                          $CategoriesTable,
                          MovementRow,
                          $MovementsTable
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._movementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).movementsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'category_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      CategoryRow,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (CategoryRow, $$CategoriesTableReferences),
      CategoryRow,
      PrefetchHooks Function({
        bool pillarId,
        bool recurringTemplatesRefs,
        bool movementsRefs,
      })
    >;
typedef $$PayeesTableCreateCompanionBuilder = PayeesCompanion Function({
  Value<int> id,
  required String name,
  required String key,
});
typedef $$PayeesTableUpdateCompanionBuilder = PayeesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> key,
});

final class $$PayeesTableReferences
    extends BaseReferences<_$AppDatabase, $PayeesTable, PayeeRow> {
  $$PayeesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $RecurringTemplatesTable,
    List<RecurringTemplateRow>
  >
  _recurringTemplatesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recurringTemplates,
        aliasName: 'payees__id__recurring_templates__payee_id',
      );

  $$RecurringTemplatesTableProcessedTableManager get recurringTemplatesRefs {
    final manager = $$RecurringTemplatesTableTableManager(
      $_db,
      $_db.recurringTemplates,
    ).filter((f) => f.payeeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurringTemplatesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MovementsTable, List<MovementRow>>
  _movementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.movements,
    aliasName: 'payees__id__movements__payee_id',
  );

  $$MovementsTableProcessedTableManager get movementsRefs {
    final manager = $$MovementsTableTableManager(
      $_db,
      $_db.movements,
    ).filter((f) => f.payeeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_movementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PayeesTableFilterComposer
    extends Composer<_$AppDatabase, $PayeesTable> {
  $$PayeesTableFilterComposer({
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

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recurringTemplatesRefs(
    Expression<bool> Function($$RecurringTemplatesTableFilterComposer f) f,
  ) {
    final $$RecurringTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringTemplates,
      getReferencedColumn: (t) => t.payeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.recurringTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> movementsRefs(
    Expression<bool> Function($$MovementsTableFilterComposer f) f,
  ) {
    final $$MovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.payeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementsTableFilterComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PayeesTableOrderingComposer
    extends Composer<_$AppDatabase, $PayeesTable> {
  $$PayeesTableOrderingComposer({
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

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PayeesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PayeesTable> {
  $$PayeesTableAnnotationComposer({
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

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  Expression<T> recurringTemplatesRefs<T extends Object>(
    Expression<T> Function($$RecurringTemplatesTableAnnotationComposer a) f,
  ) {
    final $$RecurringTemplatesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recurringTemplates,
          getReferencedColumn: (t) => t.payeeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurringTemplatesTableAnnotationComposer(
                $db: $db,
                $table: $db.recurringTemplates,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> movementsRefs<T extends Object>(
    Expression<T> Function($$MovementsTableAnnotationComposer a) f,
  ) {
    final $$MovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.payeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PayeesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PayeesTable,
          PayeeRow,
          $$PayeesTableFilterComposer,
          $$PayeesTableOrderingComposer,
          $$PayeesTableAnnotationComposer,
          $$PayeesTableCreateCompanionBuilder,
          $$PayeesTableUpdateCompanionBuilder,
          (PayeeRow, $$PayeesTableReferences),
          PayeeRow,
          PrefetchHooks Function({
            bool recurringTemplatesRefs,
            bool movementsRefs,
          })
        > {
  $$PayeesTableTableManager(_$AppDatabase db, $PayeesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PayeesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PayeesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PayeesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> key = const Value.absent(),
          }) => PayeesCompanion(id: id, name: name, key: key),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String key,
          }) => PayeesCompanion.insert(id: id, name: name, key: key),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PayeesTable, PayeeRow>(table),
                  $$PayeesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({recurringTemplatesRefs = false, movementsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recurringTemplatesRefs) db.recurringTemplates,
                    if (movementsRefs) db.movements,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recurringTemplatesRefs)
                        await $_getPrefetchedDataByColumns<
                          PayeeRow,
                          $PayeesTable,
                          RecurringTemplateRow,
                          $RecurringTemplatesTable
                        >(
                          currentTable: table,
                          referencedTable: $$PayeesTableReferences
                              ._recurringTemplatesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PayeesTableReferences(
                                db,
                                table,
                                p0,
                              ).recurringTemplatesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'payee_id',
                          typedResults: items,
                        ),
                      if (movementsRefs)
                        await $_getPrefetchedDataByColumns<
                          PayeeRow,
                          $PayeesTable,
                          MovementRow,
                          $MovementsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PayeesTableReferences
                              ._movementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PayeesTableReferences(
                                db,
                                table,
                                p0,
                              ).movementsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'payee_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PayeesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PayeesTable,
      PayeeRow,
      $$PayeesTableFilterComposer,
      $$PayeesTableOrderingComposer,
      $$PayeesTableAnnotationComposer,
      $$PayeesTableCreateCompanionBuilder,
      $$PayeesTableUpdateCompanionBuilder,
      (PayeeRow, $$PayeesTableReferences),
      PayeeRow,
      PrefetchHooks Function({bool recurringTemplatesRefs, bool movementsRefs})
    >;
typedef $$RecurringTemplatesTableCreateCompanionBuilder =
    RecurringTemplatesCompanion Function({
      Value<int> id,
      required MovementType type,
      required RecurringCadence cadence,
      required int categoryId,
      required int accountId,
      Value<int?> toAccountId,
      required int amount,
      Value<int?> toAmount,
      Value<int?> payeeId,
      Value<String?> note,
      Value<int?> dueDay,
      Value<bool> remind,
      Value<bool> isActive,
      required LocalDate createdOn,
    });
typedef $$RecurringTemplatesTableUpdateCompanionBuilder =
    RecurringTemplatesCompanion Function({
      Value<int> id,
      Value<MovementType> type,
      Value<RecurringCadence> cadence,
      Value<int> categoryId,
      Value<int> accountId,
      Value<int?> toAccountId,
      Value<int> amount,
      Value<int?> toAmount,
      Value<int?> payeeId,
      Value<String?> note,
      Value<int?> dueDay,
      Value<bool> remind,
      Value<bool> isActive,
      Value<LocalDate> createdOn,
    });

final class $$RecurringTemplatesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecurringTemplatesTable,
          RecurringTemplateRow
        > {
  $$RecurringTemplatesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) => db.categories
      .createAlias('recurring_templates__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('recurring_templates__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<int>('account_id')!;

    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _toAccountIdTable(_$AppDatabase db) => db.accounts
      .createAlias('recurring_templates__to_account_id__accounts__id');

  $$AccountsTableProcessedTableManager? get toAccountId {
    final $_column = $_itemColumn<int>('to_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PayeesTable _payeeIdTable(_$AppDatabase db) =>
      db.payees.createAlias('recurring_templates__payee_id__payees__id');

  $$PayeesTableProcessedTableManager? get payeeId {
    final $_column = $_itemColumn<int>('payee_id');
    if ($_column == null) return null;
    final manager = $$PayeesTableTableManager(
      $_db,
      $_db.payees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_payeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MovementsTable, List<MovementRow>>
  _movementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.movements,
    aliasName: 'recurring_templates__id__movements__recurring_template_id',
  );

  $$MovementsTableProcessedTableManager get movementsRefs {
    final manager = $$MovementsTableTableManager($_db, $_db.movements).filter(
      (f) => f.recurringTemplateId.id.sqlEquals($_itemColumn<int>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_movementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $RecurringOccurrencesTable,
    List<RecurringOccurrenceRow>
  >
  _recurringOccurrencesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recurringOccurrences,
        aliasName:
            'recurring_templates__id__recurring_occurrences__template_id',
      );

  $$RecurringOccurrencesTableProcessedTableManager
  get recurringOccurrencesRefs {
    final manager = $$RecurringOccurrencesTableTableManager(
      $_db,
      $_db.recurringOccurrences,
    ).filter((f) => f.templateId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurringOccurrencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecurringTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $RecurringTemplatesTable> {
  $$RecurringTemplatesTableFilterComposer({
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

  ColumnWithTypeConverterFilters<MovementType, MovementType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<RecurringCadence, RecurringCadence, String>
  get cadence => $composableBuilder(
    column: $table.cadence,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get toAmount => $composableBuilder(
    column: $table.toAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueDay => $composableBuilder(
    column: $table.dueDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get remind => $composableBuilder(
    column: $table.remind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LocalDate, LocalDate, String> get createdOn =>
      $composableBuilder(
        column: $table.createdOn,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
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

  $$AccountsTableFilterComposer get toAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toAccountId,
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

  $$PayeesTableFilterComposer get payeeId {
    final $$PayeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payeeId,
      referencedTable: $db.payees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayeesTableFilterComposer(
            $db: $db,
            $table: $db.payees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> movementsRefs(
    Expression<bool> Function($$MovementsTableFilterComposer f) f,
  ) {
    final $$MovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.recurringTemplateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementsTableFilterComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recurringOccurrencesRefs(
    Expression<bool> Function($$RecurringOccurrencesTableFilterComposer f) f,
  ) {
    final $$RecurringOccurrencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringOccurrences,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringOccurrencesTableFilterComposer(
            $db: $db,
            $table: $db.recurringOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecurringTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurringTemplatesTable> {
  $$RecurringTemplatesTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cadence => $composableBuilder(
    column: $table.cadence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get toAmount => $composableBuilder(
    column: $table.toAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueDay => $composableBuilder(
    column: $table.dueDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get remind => $composableBuilder(
    column: $table.remind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdOn => $composableBuilder(
    column: $table.createdOn,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
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

  $$AccountsTableOrderingComposer get toAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toAccountId,
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

  $$PayeesTableOrderingComposer get payeeId {
    final $$PayeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payeeId,
      referencedTable: $db.payees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayeesTableOrderingComposer(
            $db: $db,
            $table: $db.payees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurringTemplatesTable> {
  $$RecurringTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MovementType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RecurringCadence, String> get cadence =>
      $composableBuilder(column: $table.cadence, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<int> get toAmount =>
      $composableBuilder(column: $table.toAmount, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get dueDay =>
      $composableBuilder(column: $table.dueDay, builder: (column) => column);

  GeneratedColumn<bool> get remind =>
      $composableBuilder(column: $table.remind, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LocalDate, String> get createdOn =>
      $composableBuilder(column: $table.createdOn, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
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

  $$AccountsTableAnnotationComposer get toAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toAccountId,
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

  $$PayeesTableAnnotationComposer get payeeId {
    final $$PayeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payeeId,
      referencedTable: $db.payees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayeesTableAnnotationComposer(
            $db: $db,
            $table: $db.payees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> movementsRefs<T extends Object>(
    Expression<T> Function($$MovementsTableAnnotationComposer a) f,
  ) {
    final $$MovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.recurringTemplateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recurringOccurrencesRefs<T extends Object>(
    Expression<T> Function($$RecurringOccurrencesTableAnnotationComposer a) f,
  ) {
    final $$RecurringOccurrencesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recurringOccurrences,
          getReferencedColumn: (t) => t.templateId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurringOccurrencesTableAnnotationComposer(
                $db: $db,
                $table: $db.recurringOccurrences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RecurringTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecurringTemplatesTable,
          RecurringTemplateRow,
          $$RecurringTemplatesTableFilterComposer,
          $$RecurringTemplatesTableOrderingComposer,
          $$RecurringTemplatesTableAnnotationComposer,
          $$RecurringTemplatesTableCreateCompanionBuilder,
          $$RecurringTemplatesTableUpdateCompanionBuilder,
          (RecurringTemplateRow, $$RecurringTemplatesTableReferences),
          RecurringTemplateRow,
          PrefetchHooks Function({
            bool categoryId,
            bool accountId,
            bool toAccountId,
            bool payeeId,
            bool movementsRefs,
            bool recurringOccurrencesRefs,
          })
        > {
  $$RecurringTemplatesTableTableManager(
    _$AppDatabase db,
    $RecurringTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurringTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecurringTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecurringTemplatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<MovementType> type = const Value.absent(),
                Value<RecurringCadence> cadence = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<int> accountId = const Value.absent(),
                Value<int?> toAccountId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<int?> toAmount = const Value.absent(),
                Value<int?> payeeId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int?> dueDay = const Value.absent(),
                Value<bool> remind = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<LocalDate> createdOn = const Value.absent(),
              }) => RecurringTemplatesCompanion(
                id: id,
                type: type,
                cadence: cadence,
                categoryId: categoryId,
                accountId: accountId,
                toAccountId: toAccountId,
                amount: amount,
                toAmount: toAmount,
                payeeId: payeeId,
                note: note,
                dueDay: dueDay,
                remind: remind,
                isActive: isActive,
                createdOn: createdOn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required MovementType type,
                required RecurringCadence cadence,
                required int categoryId,
                required int accountId,
                Value<int?> toAccountId = const Value.absent(),
                required int amount,
                Value<int?> toAmount = const Value.absent(),
                Value<int?> payeeId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int?> dueDay = const Value.absent(),
                Value<bool> remind = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required LocalDate createdOn,
              }) => RecurringTemplatesCompanion.insert(
                id: id,
                type: type,
                cadence: cadence,
                categoryId: categoryId,
                accountId: accountId,
                toAccountId: toAccountId,
                amount: amount,
                toAmount: toAmount,
                payeeId: payeeId,
                note: note,
                dueDay: dueDay,
                remind: remind,
                isActive: isActive,
                createdOn: createdOn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecurringTemplatesTable, RecurringTemplateRow>(
                    table,
                  ),
                  $$RecurringTemplatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoryId = false,
                accountId = false,
                toAccountId = false,
                payeeId = false,
                movementsRefs = false,
                recurringOccurrencesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (movementsRefs) db.movements,
                    if (recurringOccurrencesRefs) db.recurringOccurrences,
                  ],
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
                        if (categoryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoryId,
                            referencedTable: $$RecurringTemplatesTableReferences
                                ._categoryIdTable(db),
                            referencedColumn:
                                $$RecurringTemplatesTableReferences
                                    ._categoryIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (accountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.accountId,
                            referencedTable: $$RecurringTemplatesTableReferences
                                ._accountIdTable(db),
                            referencedColumn:
                                $$RecurringTemplatesTableReferences
                                    ._accountIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (toAccountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.toAccountId,
                            referencedTable: $$RecurringTemplatesTableReferences
                                ._toAccountIdTable(db),
                            referencedColumn:
                                $$RecurringTemplatesTableReferences
                                    ._toAccountIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (payeeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.payeeId,
                            referencedTable: $$RecurringTemplatesTableReferences
                                ._payeeIdTable(db),
                            referencedColumn:
                                $$RecurringTemplatesTableReferences
                                    ._payeeIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (movementsRefs)
                        await $_getPrefetchedDataByColumns<
                          RecurringTemplateRow,
                          $RecurringTemplatesTable,
                          MovementRow,
                          $MovementsTable
                        >(
                          currentTable: table,
                          referencedTable: $$RecurringTemplatesTableReferences
                              ._movementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecurringTemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).movementsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'recurring_template_id',
                          typedResults: items,
                        ),
                      if (recurringOccurrencesRefs)
                        await $_getPrefetchedDataByColumns<
                          RecurringTemplateRow,
                          $RecurringTemplatesTable,
                          RecurringOccurrenceRow,
                          $RecurringOccurrencesTable
                        >(
                          currentTable: table,
                          referencedTable: $$RecurringTemplatesTableReferences
                              ._recurringOccurrencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecurringTemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).recurringOccurrencesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'template_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RecurringTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecurringTemplatesTable,
      RecurringTemplateRow,
      $$RecurringTemplatesTableFilterComposer,
      $$RecurringTemplatesTableOrderingComposer,
      $$RecurringTemplatesTableAnnotationComposer,
      $$RecurringTemplatesTableCreateCompanionBuilder,
      $$RecurringTemplatesTableUpdateCompanionBuilder,
      (RecurringTemplateRow, $$RecurringTemplatesTableReferences),
      RecurringTemplateRow,
      PrefetchHooks Function({
        bool categoryId,
        bool accountId,
        bool toAccountId,
        bool payeeId,
        bool movementsRefs,
        bool recurringOccurrencesRefs,
      })
    >;
typedef $$MovementsTableCreateCompanionBuilder = MovementsCompanion Function({
  Value<int> id,
  required MovementType type,
  required LocalDate date,
  required int accountId,
  required int amount,
  Value<int?> toAccountId,
  Value<int?> toAmount,
  Value<int?> categoryId,
  Value<int?> payeeId,
  Value<String?> note,
  Value<int?> debtId,
  Value<int?> recurringTemplateId,
  Value<bool> isPending,
  Value<bool> startsPeriod,
});
typedef $$MovementsTableUpdateCompanionBuilder = MovementsCompanion Function({
  Value<int> id,
  Value<MovementType> type,
  Value<LocalDate> date,
  Value<int> accountId,
  Value<int> amount,
  Value<int?> toAccountId,
  Value<int?> toAmount,
  Value<int?> categoryId,
  Value<int?> payeeId,
  Value<String?> note,
  Value<int?> debtId,
  Value<int?> recurringTemplateId,
  Value<bool> isPending,
  Value<bool> startsPeriod,
});

final class $$MovementsTableReferences
    extends BaseReferences<_$AppDatabase, $MovementsTable, MovementRow> {
  $$MovementsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('movements__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<int>('account_id')!;

    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _toAccountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('movements__to_account_id__accounts__id');

  $$AccountsTableProcessedTableManager? get toAccountId {
    final $_column = $_itemColumn<int>('to_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('movements__category_id__categories__id');

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PayeesTable _payeeIdTable(_$AppDatabase db) =>
      db.payees.createAlias('movements__payee_id__payees__id');

  $$PayeesTableProcessedTableManager? get payeeId {
    final $_column = $_itemColumn<int>('payee_id');
    if ($_column == null) return null;
    final manager = $$PayeesTableTableManager(
      $_db,
      $_db.payees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_payeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RecurringTemplatesTable _recurringTemplateIdTable(_$AppDatabase db) =>
      db.recurringTemplates.createAlias(
        'movements__recurring_template_id__recurring_templates__id',
      );

  $$RecurringTemplatesTableProcessedTableManager? get recurringTemplateId {
    final $_column = $_itemColumn<int>('recurring_template_id');
    if ($_column == null) return null;
    final manager = $$RecurringTemplatesTableTableManager(
      $_db,
      $_db.recurringTemplates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recurringTemplateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MovementsTableFilterComposer
    extends Composer<_$AppDatabase, $MovementsTable> {
  $$MovementsTableFilterComposer({
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

  ColumnWithTypeConverterFilters<MovementType, MovementType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<LocalDate, LocalDate, String> get date =>
      $composableBuilder(
        column: $table.date,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get toAmount => $composableBuilder(
    column: $table.toAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get debtId => $composableBuilder(
    column: $table.debtId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPending => $composableBuilder(
    column: $table.isPending,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get startsPeriod => $composableBuilder(
    column: $table.startsPeriod,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
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

  $$AccountsTableFilterComposer get toAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toAccountId,
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

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PayeesTableFilterComposer get payeeId {
    final $$PayeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payeeId,
      referencedTable: $db.payees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayeesTableFilterComposer(
            $db: $db,
            $table: $db.payees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecurringTemplatesTableFilterComposer get recurringTemplateId {
    final $$RecurringTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recurringTemplateId,
      referencedTable: $db.recurringTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.recurringTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $MovementsTable> {
  $$MovementsTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get toAmount => $composableBuilder(
    column: $table.toAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get debtId => $composableBuilder(
    column: $table.debtId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPending => $composableBuilder(
    column: $table.isPending,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get startsPeriod => $composableBuilder(
    column: $table.startsPeriod,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
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

  $$AccountsTableOrderingComposer get toAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toAccountId,
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

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PayeesTableOrderingComposer get payeeId {
    final $$PayeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payeeId,
      referencedTable: $db.payees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayeesTableOrderingComposer(
            $db: $db,
            $table: $db.payees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecurringTemplatesTableOrderingComposer get recurringTemplateId {
    final $$RecurringTemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recurringTemplateId,
      referencedTable: $db.recurringTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringTemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.recurringTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovementsTable> {
  $$MovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MovementType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LocalDate, String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<int> get toAmount =>
      $composableBuilder(column: $table.toAmount, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get debtId =>
      $composableBuilder(column: $table.debtId, builder: (column) => column);

  GeneratedColumn<bool> get isPending =>
      $composableBuilder(column: $table.isPending, builder: (column) => column);

  GeneratedColumn<bool> get startsPeriod => $composableBuilder(
    column: $table.startsPeriod,
    builder: (column) => column,
  );

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
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

  $$AccountsTableAnnotationComposer get toAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toAccountId,
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

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PayeesTableAnnotationComposer get payeeId {
    final $$PayeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payeeId,
      referencedTable: $db.payees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayeesTableAnnotationComposer(
            $db: $db,
            $table: $db.payees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecurringTemplatesTableAnnotationComposer get recurringTemplateId {
    final $$RecurringTemplatesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.recurringTemplateId,
          referencedTable: $db.recurringTemplates,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurringTemplatesTableAnnotationComposer(
                $db: $db,
                $table: $db.recurringTemplates,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$MovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovementsTable,
          MovementRow,
          $$MovementsTableFilterComposer,
          $$MovementsTableOrderingComposer,
          $$MovementsTableAnnotationComposer,
          $$MovementsTableCreateCompanionBuilder,
          $$MovementsTableUpdateCompanionBuilder,
          (MovementRow, $$MovementsTableReferences),
          MovementRow,
          PrefetchHooks Function({
            bool accountId,
            bool toAccountId,
            bool categoryId,
            bool payeeId,
            bool recurringTemplateId,
          })
        > {
  $$MovementsTableTableManager(_$AppDatabase db, $MovementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<MovementType> type = const Value.absent(),
                Value<LocalDate> date = const Value.absent(),
                Value<int> accountId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<int?> toAccountId = const Value.absent(),
                Value<int?> toAmount = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int?> payeeId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int?> debtId = const Value.absent(),
                Value<int?> recurringTemplateId = const Value.absent(),
                Value<bool> isPending = const Value.absent(),
                Value<bool> startsPeriod = const Value.absent(),
              }) => MovementsCompanion(
                id: id,
                type: type,
                date: date,
                accountId: accountId,
                amount: amount,
                toAccountId: toAccountId,
                toAmount: toAmount,
                categoryId: categoryId,
                payeeId: payeeId,
                note: note,
                debtId: debtId,
                recurringTemplateId: recurringTemplateId,
                isPending: isPending,
                startsPeriod: startsPeriod,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required MovementType type,
                required LocalDate date,
                required int accountId,
                required int amount,
                Value<int?> toAccountId = const Value.absent(),
                Value<int?> toAmount = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int?> payeeId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int?> debtId = const Value.absent(),
                Value<int?> recurringTemplateId = const Value.absent(),
                Value<bool> isPending = const Value.absent(),
                Value<bool> startsPeriod = const Value.absent(),
              }) => MovementsCompanion.insert(
                id: id,
                type: type,
                date: date,
                accountId: accountId,
                amount: amount,
                toAccountId: toAccountId,
                toAmount: toAmount,
                categoryId: categoryId,
                payeeId: payeeId,
                note: note,
                debtId: debtId,
                recurringTemplateId: recurringTemplateId,
                isPending: isPending,
                startsPeriod: startsPeriod,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MovementsTable, MovementRow>(table),
                  $$MovementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                accountId = false,
                toAccountId = false,
                categoryId = false,
                payeeId = false,
                recurringTemplateId = false,
              }) {
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
                        if (accountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.accountId,
                            referencedTable: $$MovementsTableReferences
                                ._accountIdTable(db),
                            referencedColumn: $$MovementsTableReferences
                                ._accountIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (toAccountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.toAccountId,
                            referencedTable: $$MovementsTableReferences
                                ._toAccountIdTable(db),
                            referencedColumn: $$MovementsTableReferences
                                ._toAccountIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (categoryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoryId,
                            referencedTable: $$MovementsTableReferences
                                ._categoryIdTable(db),
                            referencedColumn: $$MovementsTableReferences
                                ._categoryIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (payeeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.payeeId,
                            referencedTable: $$MovementsTableReferences
                                ._payeeIdTable(db),
                            referencedColumn: $$MovementsTableReferences
                                ._payeeIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (recurringTemplateId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.recurringTemplateId,
                            referencedTable: $$MovementsTableReferences
                                ._recurringTemplateIdTable(db),
                            referencedColumn: $$MovementsTableReferences
                                ._recurringTemplateIdTable(db)
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

typedef $$MovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovementsTable,
      MovementRow,
      $$MovementsTableFilterComposer,
      $$MovementsTableOrderingComposer,
      $$MovementsTableAnnotationComposer,
      $$MovementsTableCreateCompanionBuilder,
      $$MovementsTableUpdateCompanionBuilder,
      (MovementRow, $$MovementsTableReferences),
      MovementRow,
      PrefetchHooks Function({
        bool accountId,
        bool toAccountId,
        bool categoryId,
        bool payeeId,
        bool recurringTemplateId,
      })
    >;
typedef $$PeriodStartsTableCreateCompanionBuilder =
    PeriodStartsCompanion Function({Value<int> id, required LocalDate date});
typedef $$PeriodStartsTableUpdateCompanionBuilder =
    PeriodStartsCompanion Function({Value<int> id, Value<LocalDate> date});

class $$PeriodStartsTableFilterComposer
    extends Composer<_$AppDatabase, $PeriodStartsTable> {
  $$PeriodStartsTableFilterComposer({
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

  ColumnWithTypeConverterFilters<LocalDate, LocalDate, String> get date =>
      $composableBuilder(
        column: $table.date,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$PeriodStartsTableOrderingComposer
    extends Composer<_$AppDatabase, $PeriodStartsTable> {
  $$PeriodStartsTableOrderingComposer({
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

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PeriodStartsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PeriodStartsTable> {
  $$PeriodStartsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LocalDate, String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$PeriodStartsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PeriodStartsTable,
          PeriodStartRow,
          $$PeriodStartsTableFilterComposer,
          $$PeriodStartsTableOrderingComposer,
          $$PeriodStartsTableAnnotationComposer,
          $$PeriodStartsTableCreateCompanionBuilder,
          $$PeriodStartsTableUpdateCompanionBuilder,
          (
            PeriodStartRow,
            BaseReferences<_$AppDatabase, $PeriodStartsTable, PeriodStartRow>,
          ),
          PeriodStartRow,
          PrefetchHooks Function()
        > {
  $$PeriodStartsTableTableManager(_$AppDatabase db, $PeriodStartsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PeriodStartsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PeriodStartsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PeriodStartsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<LocalDate> date = const Value.absent(),
          }) => PeriodStartsCompanion(id: id, date: date),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required LocalDate date,
          }) => PeriodStartsCompanion.insert(id: id, date: date),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PeriodStartsTable, PeriodStartRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PeriodStartsTable,
                    PeriodStartRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PeriodStartsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PeriodStartsTable,
      PeriodStartRow,
      $$PeriodStartsTableFilterComposer,
      $$PeriodStartsTableOrderingComposer,
      $$PeriodStartsTableAnnotationComposer,
      $$PeriodStartsTableCreateCompanionBuilder,
      $$PeriodStartsTableUpdateCompanionBuilder,
      (
        PeriodStartRow,
        BaseReferences<_$AppDatabase, $PeriodStartsTable, PeriodStartRow>,
      ),
      PeriodStartRow,
      PrefetchHooks Function()
    >;
typedef $$RecurringOccurrencesTableCreateCompanionBuilder =
    RecurringOccurrencesCompanion Function({
      Value<int> id,
      required int templateId,
      required LocalDate periodStart,
    });
typedef $$RecurringOccurrencesTableUpdateCompanionBuilder =
    RecurringOccurrencesCompanion Function({
      Value<int> id,
      Value<int> templateId,
      Value<LocalDate> periodStart,
    });

final class $$RecurringOccurrencesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecurringOccurrencesTable,
          RecurringOccurrenceRow
        > {
  $$RecurringOccurrencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RecurringTemplatesTable _templateIdTable(_$AppDatabase db) =>
      db.recurringTemplates.createAlias(
        'recurring_occurrences__template_id__recurring_templates__id',
      );

  $$RecurringTemplatesTableProcessedTableManager get templateId {
    final $_column = $_itemColumn<int>('template_id')!;

    final manager = $$RecurringTemplatesTableTableManager(
      $_db,
      $_db.recurringTemplates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecurringOccurrencesTableFilterComposer
    extends Composer<_$AppDatabase, $RecurringOccurrencesTable> {
  $$RecurringOccurrencesTableFilterComposer({
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

  ColumnWithTypeConverterFilters<LocalDate, LocalDate, String>
  get periodStart => $composableBuilder(
    column: $table.periodStart,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$RecurringTemplatesTableFilterComposer get templateId {
    final $$RecurringTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.recurringTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.recurringTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringOccurrencesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurringOccurrencesTable> {
  $$RecurringOccurrencesTableOrderingComposer({
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

  ColumnOrderings<String> get periodStart => $composableBuilder(
    column: $table.periodStart,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecurringTemplatesTableOrderingComposer get templateId {
    final $$RecurringTemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.recurringTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringTemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.recurringTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringOccurrencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurringOccurrencesTable> {
  $$RecurringOccurrencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LocalDate, String> get periodStart =>
      $composableBuilder(
        column: $table.periodStart,
        builder: (column) => column,
      );

  $$RecurringTemplatesTableAnnotationComposer get templateId {
    final $$RecurringTemplatesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.templateId,
          referencedTable: $db.recurringTemplates,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurringTemplatesTableAnnotationComposer(
                $db: $db,
                $table: $db.recurringTemplates,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$RecurringOccurrencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecurringOccurrencesTable,
          RecurringOccurrenceRow,
          $$RecurringOccurrencesTableFilterComposer,
          $$RecurringOccurrencesTableOrderingComposer,
          $$RecurringOccurrencesTableAnnotationComposer,
          $$RecurringOccurrencesTableCreateCompanionBuilder,
          $$RecurringOccurrencesTableUpdateCompanionBuilder,
          (RecurringOccurrenceRow, $$RecurringOccurrencesTableReferences),
          RecurringOccurrenceRow,
          PrefetchHooks Function({bool templateId})
        > {
  $$RecurringOccurrencesTableTableManager(
    _$AppDatabase db,
    $RecurringOccurrencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurringOccurrencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecurringOccurrencesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RecurringOccurrencesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> templateId = const Value.absent(),
                Value<LocalDate> periodStart = const Value.absent(),
              }) => RecurringOccurrencesCompanion(
                id: id,
                templateId: templateId,
                periodStart: periodStart,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int templateId,
                required LocalDate periodStart,
              }) => RecurringOccurrencesCompanion.insert(
                id: id,
                templateId: templateId,
                periodStart: periodStart,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $RecurringOccurrencesTable,
                    RecurringOccurrenceRow
                  >(table),
                  $$RecurringOccurrencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({templateId = false}) {
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
                    if (templateId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.templateId,
                        referencedTable: $$RecurringOccurrencesTableReferences
                            ._templateIdTable(db),
                        referencedColumn: $$RecurringOccurrencesTableReferences
                            ._templateIdTable(db)
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

typedef $$RecurringOccurrencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecurringOccurrencesTable,
      RecurringOccurrenceRow,
      $$RecurringOccurrencesTableFilterComposer,
      $$RecurringOccurrencesTableOrderingComposer,
      $$RecurringOccurrencesTableAnnotationComposer,
      $$RecurringOccurrencesTableCreateCompanionBuilder,
      $$RecurringOccurrencesTableUpdateCompanionBuilder,
      (RecurringOccurrenceRow, $$RecurringOccurrencesTableReferences),
      RecurringOccurrenceRow,
      PrefetchHooks Function({bool templateId})
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
  $$PillarsTableTableManager get pillars =>
      $$PillarsTableTableManager(_db, _db.pillars);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$PayeesTableTableManager get payees =>
      $$PayeesTableTableManager(_db, _db.payees);
  $$RecurringTemplatesTableTableManager get recurringTemplates =>
      $$RecurringTemplatesTableTableManager(_db, _db.recurringTemplates);
  $$MovementsTableTableManager get movements =>
      $$MovementsTableTableManager(_db, _db.movements);
  $$PeriodStartsTableTableManager get periodStarts =>
      $$PeriodStartsTableTableManager(_db, _db.periodStarts);
  $$RecurringOccurrencesTableTableManager get recurringOccurrences =>
      $$RecurringOccurrencesTableTableManager(_db, _db.recurringOccurrences);
}
