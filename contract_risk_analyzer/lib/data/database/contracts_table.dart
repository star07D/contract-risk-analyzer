import 'package:drift/drift.dart';

class Contracts extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get category => text()();

  RealColumn get cost => real()();

  BoolColumn get isMonthlyCost => boolean()();

  DateTimeColumn get startDate => dateTime()();

  IntColumn get minimumDurationMonths => integer()();

  IntColumn get noticePeriodDays => integer()();

  IntColumn get renewalCycleMonths => integer()();
}
