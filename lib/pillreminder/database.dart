// database.dart

// required package imports
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:pill_pal/pillreminder/entities/medicine.dart';
import 'package:pill_pal/pillreminder/entities/reminder.dart';
import 'package:pill_pal/pillreminder/entities/reminderCheck.dart';
import 'package:pill_pal/pillreminder/util/converters/ColorIntConverter.dart';
import 'package:pill_pal/pillreminder/util/converters/DateTimeConverter.dart';
import 'package:pill_pal/pillreminder/util/converters/ListStringConverter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/medicine_dao.dart';
import 'dao/reminder_check_dao.dart';
import 'dao/reminder_dao.dart';

part 'database.g.dart'; // the generated code will be there

@TypeConverters([DateTimeConverter, ListStringConverter, ColorIntConverter])
@Database(version: 1, entities: [Medicine, Reminder, ReminderCheck])
abstract class AppDatabase extends FloorDatabase {
  MedicineDao get medicineDao;

  ReminderDao get reminderDao;

  ReminderCheckDao get reminderCheckDao;
}

Future<AppDatabase> initDb() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  return database;
}
