import 'package:collector/data/database_service.dart';
import 'package:collector/model/item_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';

class HiveDatabaseService extends DatabaseService {
  static final String boxPrefix = '${dotenv.env['WEB_HIVE_BOX_NAME']!}_';

  static Future<void> initializeHive() async {
    Hive
      ..registerAdapter(ItemModelAdapter())
      ..registerAdapter(ItemOwnershipStatusAdapter())
      ..registerAdapter(ItemStatusAdapter())
      ..registerAdapter(ItemTypeAdapter());

    await openBoxes();
  }

  static Future<void> openBoxes() async {
    // Open boxes
    await Hive.openBox('$boxPrefix${TableNames.item.name}');
    await Hive.openBox('$boxPrefix${TableNames.collection.name}');
  }

  static Future<void> closeBoxes() async {
    // Close boxes
    await Hive.box('$boxPrefix${TableNames.item.name}').close();
    await Hive.box('$boxPrefix${TableNames.collection.name}').close();
  }

  @override
  Future<void> saveData(String tablename, String key, dynamic value) async {
    final box = Hive.box('$boxPrefix$tablename');
    try {
      await box.put(key, value);
    } catch (e) {
      debugPrint('Error putting data to Hive: $e');
    }
  }

  @override
  Future<void> saveAllData(String tablename, Map<String, dynamic> map) async {
    final box = Hive.box('$boxPrefix$tablename');
    try {
      await box.putAll(map);
    } catch (e) {
      debugPrint('Error putting all data to Hive: $e');
    }
  }

  @override
  Future<dynamic> loadData(String tablename, Object key) async {
    final box = Hive.box('$boxPrefix$tablename');
    final item = await box.get(key);
    return item;
  }

  @override
  Future<Map<String, dynamic>> loadAllData(String tablename) async {
    final box = Hive.box('$boxPrefix$tablename');
    final data = box.toMap();
    return Map<String, dynamic>.from(data);
  }

  @override
  Future<void> deleteAllData(String tablename) async {
    final box = Hive.box('$boxPrefix$tablename');
    return box.deleteFromDisk();
  }

  @override
  Future<void> deleteData(String tablename, String key) async {
    final box = Hive.box('$boxPrefix$tablename');
    await box.delete(key);
  }
}
