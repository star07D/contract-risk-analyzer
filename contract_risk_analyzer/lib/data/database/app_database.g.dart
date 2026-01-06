// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ContractsTable extends Contracts
    with TableInfo<$ContractsTable, Contract> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContractsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
      'cost', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _isMonthlyCostMeta =
      const VerificationMeta('isMonthlyCost');
  @override
  late final GeneratedColumn<bool> isMonthlyCost = GeneratedColumn<bool>(
      'is_monthly_cost', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_monthly_cost" IN (0, 1))'));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _minimumDurationMonthsMeta =
      const VerificationMeta('minimumDurationMonths');
  @override
  late final GeneratedColumn<int> minimumDurationMonths = GeneratedColumn<int>(
      'minimum_duration_months', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _noticePeriodDaysMeta =
      const VerificationMeta('noticePeriodDays');
  @override
  late final GeneratedColumn<int> noticePeriodDays = GeneratedColumn<int>(
      'notice_period_days', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _renewalCycleMonthsMeta =
      const VerificationMeta('renewalCycleMonths');
  @override
  late final GeneratedColumn<int> renewalCycleMonths = GeneratedColumn<int>(
      'renewal_cycle_months', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        category,
        cost,
        isMonthlyCost,
        startDate,
        minimumDurationMonths,
        noticePeriodDays,
        renewalCycleMonths
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contracts';
  @override
  VerificationContext validateIntegrity(Insertable<Contract> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
          _costMeta, cost.isAcceptableOrUnknown(data['cost']!, _costMeta));
    } else if (isInserting) {
      context.missing(_costMeta);
    }
    if (data.containsKey('is_monthly_cost')) {
      context.handle(
          _isMonthlyCostMeta,
          isMonthlyCost.isAcceptableOrUnknown(
              data['is_monthly_cost']!, _isMonthlyCostMeta));
    } else if (isInserting) {
      context.missing(_isMonthlyCostMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('minimum_duration_months')) {
      context.handle(
          _minimumDurationMonthsMeta,
          minimumDurationMonths.isAcceptableOrUnknown(
              data['minimum_duration_months']!, _minimumDurationMonthsMeta));
    } else if (isInserting) {
      context.missing(_minimumDurationMonthsMeta);
    }
    if (data.containsKey('notice_period_days')) {
      context.handle(
          _noticePeriodDaysMeta,
          noticePeriodDays.isAcceptableOrUnknown(
              data['notice_period_days']!, _noticePeriodDaysMeta));
    } else if (isInserting) {
      context.missing(_noticePeriodDaysMeta);
    }
    if (data.containsKey('renewal_cycle_months')) {
      context.handle(
          _renewalCycleMonthsMeta,
          renewalCycleMonths.isAcceptableOrUnknown(
              data['renewal_cycle_months']!, _renewalCycleMonthsMeta));
    } else if (isInserting) {
      context.missing(_renewalCycleMonthsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contract map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contract(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      cost: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cost'])!,
      isMonthlyCost: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_monthly_cost'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      minimumDurationMonths: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}minimum_duration_months'])!,
      noticePeriodDays: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}notice_period_days'])!,
      renewalCycleMonths: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}renewal_cycle_months'])!,
    );
  }

  @override
  $ContractsTable createAlias(String alias) {
    return $ContractsTable(attachedDatabase, alias);
  }
}

class Contract extends DataClass implements Insertable<Contract> {
  final int id;
  final String name;
  final String category;
  final double cost;
  final bool isMonthlyCost;
  final DateTime startDate;
  final int minimumDurationMonths;
  final int noticePeriodDays;
  final int renewalCycleMonths;
  const Contract(
      {required this.id,
      required this.name,
      required this.category,
      required this.cost,
      required this.isMonthlyCost,
      required this.startDate,
      required this.minimumDurationMonths,
      required this.noticePeriodDays,
      required this.renewalCycleMonths});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['cost'] = Variable<double>(cost);
    map['is_monthly_cost'] = Variable<bool>(isMonthlyCost);
    map['start_date'] = Variable<DateTime>(startDate);
    map['minimum_duration_months'] = Variable<int>(minimumDurationMonths);
    map['notice_period_days'] = Variable<int>(noticePeriodDays);
    map['renewal_cycle_months'] = Variable<int>(renewalCycleMonths);
    return map;
  }

  ContractsCompanion toCompanion(bool nullToAbsent) {
    return ContractsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      cost: Value(cost),
      isMonthlyCost: Value(isMonthlyCost),
      startDate: Value(startDate),
      minimumDurationMonths: Value(minimumDurationMonths),
      noticePeriodDays: Value(noticePeriodDays),
      renewalCycleMonths: Value(renewalCycleMonths),
    );
  }

  factory Contract.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contract(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      cost: serializer.fromJson<double>(json['cost']),
      isMonthlyCost: serializer.fromJson<bool>(json['isMonthlyCost']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      minimumDurationMonths:
          serializer.fromJson<int>(json['minimumDurationMonths']),
      noticePeriodDays: serializer.fromJson<int>(json['noticePeriodDays']),
      renewalCycleMonths: serializer.fromJson<int>(json['renewalCycleMonths']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'cost': serializer.toJson<double>(cost),
      'isMonthlyCost': serializer.toJson<bool>(isMonthlyCost),
      'startDate': serializer.toJson<DateTime>(startDate),
      'minimumDurationMonths': serializer.toJson<int>(minimumDurationMonths),
      'noticePeriodDays': serializer.toJson<int>(noticePeriodDays),
      'renewalCycleMonths': serializer.toJson<int>(renewalCycleMonths),
    };
  }

  Contract copyWith(
          {int? id,
          String? name,
          String? category,
          double? cost,
          bool? isMonthlyCost,
          DateTime? startDate,
          int? minimumDurationMonths,
          int? noticePeriodDays,
          int? renewalCycleMonths}) =>
      Contract(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        cost: cost ?? this.cost,
        isMonthlyCost: isMonthlyCost ?? this.isMonthlyCost,
        startDate: startDate ?? this.startDate,
        minimumDurationMonths:
            minimumDurationMonths ?? this.minimumDurationMonths,
        noticePeriodDays: noticePeriodDays ?? this.noticePeriodDays,
        renewalCycleMonths: renewalCycleMonths ?? this.renewalCycleMonths,
      );
  Contract copyWithCompanion(ContractsCompanion data) {
    return Contract(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      cost: data.cost.present ? data.cost.value : this.cost,
      isMonthlyCost: data.isMonthlyCost.present
          ? data.isMonthlyCost.value
          : this.isMonthlyCost,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      minimumDurationMonths: data.minimumDurationMonths.present
          ? data.minimumDurationMonths.value
          : this.minimumDurationMonths,
      noticePeriodDays: data.noticePeriodDays.present
          ? data.noticePeriodDays.value
          : this.noticePeriodDays,
      renewalCycleMonths: data.renewalCycleMonths.present
          ? data.renewalCycleMonths.value
          : this.renewalCycleMonths,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contract(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('cost: $cost, ')
          ..write('isMonthlyCost: $isMonthlyCost, ')
          ..write('startDate: $startDate, ')
          ..write('minimumDurationMonths: $minimumDurationMonths, ')
          ..write('noticePeriodDays: $noticePeriodDays, ')
          ..write('renewalCycleMonths: $renewalCycleMonths')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, category, cost, isMonthlyCost,
      startDate, minimumDurationMonths, noticePeriodDays, renewalCycleMonths);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contract &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.cost == this.cost &&
          other.isMonthlyCost == this.isMonthlyCost &&
          other.startDate == this.startDate &&
          other.minimumDurationMonths == this.minimumDurationMonths &&
          other.noticePeriodDays == this.noticePeriodDays &&
          other.renewalCycleMonths == this.renewalCycleMonths);
}

class ContractsCompanion extends UpdateCompanion<Contract> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> category;
  final Value<double> cost;
  final Value<bool> isMonthlyCost;
  final Value<DateTime> startDate;
  final Value<int> minimumDurationMonths;
  final Value<int> noticePeriodDays;
  final Value<int> renewalCycleMonths;
  const ContractsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.cost = const Value.absent(),
    this.isMonthlyCost = const Value.absent(),
    this.startDate = const Value.absent(),
    this.minimumDurationMonths = const Value.absent(),
    this.noticePeriodDays = const Value.absent(),
    this.renewalCycleMonths = const Value.absent(),
  });
  ContractsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String category,
    required double cost,
    required bool isMonthlyCost,
    required DateTime startDate,
    required int minimumDurationMonths,
    required int noticePeriodDays,
    required int renewalCycleMonths,
  })  : name = Value(name),
        category = Value(category),
        cost = Value(cost),
        isMonthlyCost = Value(isMonthlyCost),
        startDate = Value(startDate),
        minimumDurationMonths = Value(minimumDurationMonths),
        noticePeriodDays = Value(noticePeriodDays),
        renewalCycleMonths = Value(renewalCycleMonths);
  static Insertable<Contract> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<double>? cost,
    Expression<bool>? isMonthlyCost,
    Expression<DateTime>? startDate,
    Expression<int>? minimumDurationMonths,
    Expression<int>? noticePeriodDays,
    Expression<int>? renewalCycleMonths,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (cost != null) 'cost': cost,
      if (isMonthlyCost != null) 'is_monthly_cost': isMonthlyCost,
      if (startDate != null) 'start_date': startDate,
      if (minimumDurationMonths != null)
        'minimum_duration_months': minimumDurationMonths,
      if (noticePeriodDays != null) 'notice_period_days': noticePeriodDays,
      if (renewalCycleMonths != null)
        'renewal_cycle_months': renewalCycleMonths,
    });
  }

  ContractsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? category,
      Value<double>? cost,
      Value<bool>? isMonthlyCost,
      Value<DateTime>? startDate,
      Value<int>? minimumDurationMonths,
      Value<int>? noticePeriodDays,
      Value<int>? renewalCycleMonths}) {
    return ContractsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      cost: cost ?? this.cost,
      isMonthlyCost: isMonthlyCost ?? this.isMonthlyCost,
      startDate: startDate ?? this.startDate,
      minimumDurationMonths:
          minimumDurationMonths ?? this.minimumDurationMonths,
      noticePeriodDays: noticePeriodDays ?? this.noticePeriodDays,
      renewalCycleMonths: renewalCycleMonths ?? this.renewalCycleMonths,
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
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (isMonthlyCost.present) {
      map['is_monthly_cost'] = Variable<bool>(isMonthlyCost.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (minimumDurationMonths.present) {
      map['minimum_duration_months'] =
          Variable<int>(minimumDurationMonths.value);
    }
    if (noticePeriodDays.present) {
      map['notice_period_days'] = Variable<int>(noticePeriodDays.value);
    }
    if (renewalCycleMonths.present) {
      map['renewal_cycle_months'] = Variable<int>(renewalCycleMonths.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContractsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('cost: $cost, ')
          ..write('isMonthlyCost: $isMonthlyCost, ')
          ..write('startDate: $startDate, ')
          ..write('minimumDurationMonths: $minimumDurationMonths, ')
          ..write('noticePeriodDays: $noticePeriodDays, ')
          ..write('renewalCycleMonths: $renewalCycleMonths')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ContractsTable contracts = $ContractsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [contracts];
}

typedef $$ContractsTableCreateCompanionBuilder = ContractsCompanion Function({
  Value<int> id,
  required String name,
  required String category,
  required double cost,
  required bool isMonthlyCost,
  required DateTime startDate,
  required int minimumDurationMonths,
  required int noticePeriodDays,
  required int renewalCycleMonths,
});
typedef $$ContractsTableUpdateCompanionBuilder = ContractsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> category,
  Value<double> cost,
  Value<bool> isMonthlyCost,
  Value<DateTime> startDate,
  Value<int> minimumDurationMonths,
  Value<int> noticePeriodDays,
  Value<int> renewalCycleMonths,
});

class $$ContractsTableFilterComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get cost => $composableBuilder(
      column: $table.cost, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isMonthlyCost => $composableBuilder(
      column: $table.isMonthlyCost, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minimumDurationMonths => $composableBuilder(
      column: $table.minimumDurationMonths,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get noticePeriodDays => $composableBuilder(
      column: $table.noticePeriodDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get renewalCycleMonths => $composableBuilder(
      column: $table.renewalCycleMonths,
      builder: (column) => ColumnFilters(column));
}

class $$ContractsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get cost => $composableBuilder(
      column: $table.cost, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isMonthlyCost => $composableBuilder(
      column: $table.isMonthlyCost,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minimumDurationMonths => $composableBuilder(
      column: $table.minimumDurationMonths,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get noticePeriodDays => $composableBuilder(
      column: $table.noticePeriodDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get renewalCycleMonths => $composableBuilder(
      column: $table.renewalCycleMonths,
      builder: (column) => ColumnOrderings(column));
}

class $$ContractsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableAnnotationComposer({
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

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<bool> get isMonthlyCost => $composableBuilder(
      column: $table.isMonthlyCost, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<int> get minimumDurationMonths => $composableBuilder(
      column: $table.minimumDurationMonths, builder: (column) => column);

  GeneratedColumn<int> get noticePeriodDays => $composableBuilder(
      column: $table.noticePeriodDays, builder: (column) => column);

  GeneratedColumn<int> get renewalCycleMonths => $composableBuilder(
      column: $table.renewalCycleMonths, builder: (column) => column);
}

class $$ContractsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContractsTable,
    Contract,
    $$ContractsTableFilterComposer,
    $$ContractsTableOrderingComposer,
    $$ContractsTableAnnotationComposer,
    $$ContractsTableCreateCompanionBuilder,
    $$ContractsTableUpdateCompanionBuilder,
    (Contract, BaseReferences<_$AppDatabase, $ContractsTable, Contract>),
    Contract,
    PrefetchHooks Function()> {
  $$ContractsTableTableManager(_$AppDatabase db, $ContractsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContractsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContractsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContractsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<double> cost = const Value.absent(),
            Value<bool> isMonthlyCost = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<int> minimumDurationMonths = const Value.absent(),
            Value<int> noticePeriodDays = const Value.absent(),
            Value<int> renewalCycleMonths = const Value.absent(),
          }) =>
              ContractsCompanion(
            id: id,
            name: name,
            category: category,
            cost: cost,
            isMonthlyCost: isMonthlyCost,
            startDate: startDate,
            minimumDurationMonths: minimumDurationMonths,
            noticePeriodDays: noticePeriodDays,
            renewalCycleMonths: renewalCycleMonths,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String category,
            required double cost,
            required bool isMonthlyCost,
            required DateTime startDate,
            required int minimumDurationMonths,
            required int noticePeriodDays,
            required int renewalCycleMonths,
          }) =>
              ContractsCompanion.insert(
            id: id,
            name: name,
            category: category,
            cost: cost,
            isMonthlyCost: isMonthlyCost,
            startDate: startDate,
            minimumDurationMonths: minimumDurationMonths,
            noticePeriodDays: noticePeriodDays,
            renewalCycleMonths: renewalCycleMonths,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ContractsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ContractsTable,
    Contract,
    $$ContractsTableFilterComposer,
    $$ContractsTableOrderingComposer,
    $$ContractsTableAnnotationComposer,
    $$ContractsTableCreateCompanionBuilder,
    $$ContractsTableUpdateCompanionBuilder,
    (Contract, BaseReferences<_$AppDatabase, $ContractsTable, Contract>),
    Contract,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ContractsTableTableManager get contracts =>
      $$ContractsTableTableManager(_db, _db.contracts);
}
