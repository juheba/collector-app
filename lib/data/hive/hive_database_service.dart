import 'package:collector/data/database_service.dart';
import 'package:collector/model/item_model.dart';
import 'package:hive/hive.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HiveDatabaseService extends DatabaseService {
  static final String boxPrefix = '${dotenv.env['WEB_HIVE_BOX_NAME']!}_';

  static Future<void> initializeHive() async {
    Hive.registerAdapter(ItemModelAdapter());
    Hive.registerAdapter(ItemOwnershipStatusAdapter());
    Hive.registerAdapter(ItemStatusAdapter());
    Hive.registerAdapter(ItemTypeAdapter());

    openBoxes();
  }

  static Future<void> openBoxes() async {
    // Open boxes
    await Hive.openBox('$boxPrefix${TableNames.item.name}');
    //await Hive.openBox('$boxPrefix${TableNames.collection.name}');
  }

  static Future<void> closeBoxes() async {
    // Close boxes
    Hive.box('$boxPrefix${TableNames.item.name}').close();
    //Hive.box('$boxPrefix${TableNames.collection.name}').close();
  }

  @override
  Future<void> saveData(String tablename, String key, dynamic value) async {
    var box = Hive.box('$boxPrefix$tablename');
    try {
      await box.put(key, value);
    } catch (e) {
      print('Error putting data to Hive: $e');
    }
  }

  @override
  Future<void> saveAllData(String tablename, Map<String, dynamic> map) async {
    var box = await Hive.openBox('$boxPrefix$tablename');
    try {
      await box.putAll(map);
    } catch (e) {
      print('Error putting all data to Hive: $e');
    }
  }

  @override
  Future<Object> loadData(String tablename, Object key) async {
    var box = await Hive.openBox('$boxPrefix$tablename');
    var item = await box.get(key);
    return item;
  }

  @override
  Future<Map<String, dynamic>> loadAllData(String tablename) async {
    var box = await Hive.openBox('$boxPrefix$tablename');
    var data = box.toMap();
    return Map<String, dynamic>.from(data);
  }

  @override
  Future<void> deleteAllData(String tablename) async {
    var box = await Hive.openBox('$boxPrefix$tablename');
    return await box.deleteFromDisk();
  }

  @override
  Future<void> deleteData(String tablename, String key) async {
    var box = await Hive.openBox('$boxPrefix$tablename');
    await box.delete(key);
  }
}
