// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sqflite/sqflite.dart';

abstract class SqfliteTable {
  final String databasePath;
  final int version;
  SqfliteTable({
    required this.databasePath,
    required this.version,
  });

  Future<Database> get database;
}
