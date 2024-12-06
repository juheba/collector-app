import 'package:collector/data/persistence/database_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabaseService extends DatabaseService {
  late Database _db;
  final String dbFileName = dotenv.env['ANDROID_DB_FILE_NAME']!;

  @override
  Future<void> saveData(String tablename, String key, dynamic value) async {
    _db = await openDatabase(dbFileName);
    await _db.transaction((txn) async {
      await txn.rawInsert('INSERT INTO $tablename(key, value) VALUES("$key", "$value")');
    });
  }

  @override
  Future<void> saveAllData(String tablename, Map<String, dynamic> map) async {
    await _db.insert(tablename, map, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<dynamic> loadData(String tablename, String key) async {
    _db = await openDatabase(dbFileName);
    final list = await _db.rawQuery('SELECT * FROM $tablename WHERE key="$key"');
    return list.isNotEmpty ? list.first['value'] : null;
  }

  @override
  Future<Map<String, dynamic>> loadAllData(String tablename) async {
    _db = await openDatabase(dbFileName);
    final list = await _db.rawQuery('SELECT * FROM $tablename');
    return Map<String, dynamic>.from(list.first);
  }

  @override
  Future<void> deleteAllData(String tablename) async {
    _db = await openDatabase(dbFileName);
    await _db.rawQuery('DELETE * FROM $tablename');
  }

  @override
  Future<void> deleteData(String tablename, String key) async {
    _db = await openDatabase(dbFileName);
    await _db.rawQuery('DELETE * FROM $tablename WHERE key="$key"');
  }
}
