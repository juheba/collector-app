import 'package:collector/data/persistence/hive/hive_database_service.dart';
import 'package:collector/data/persistence/sqflight/sqflite_database_service.dart';
import 'package:collector/model/collection_model.dart';
import 'package:collector/model/item_model.dart';
import 'package:flutter/foundation.dart';

abstract class DatabaseService {
  static DatabaseService? _instance;

  static DatabaseService get instance {
    _instance ??= kIsWeb ? HiveDatabaseService() : SqfliteDatabaseService();
    return _instance!;
  }

  Future<void> saveData(String tablename, String key, dynamic value);
  Future<void> saveAllData(String tablename, Map<String, dynamic> map);
  Future<dynamic> loadData(String tablename, String key);
  Future<Map<String, dynamic>> loadAllData(String tablename);
  Future<void> deleteData(String tablename, String key);
  Future<void> deleteAllData(String tablename);

  Future<void> saveItem(String key, ItemModel value) {
    return saveData(TableNames.item.name, key, value);
  }

  Future<void> saveAllItems(Map<String, ItemModel> map) {
    return saveAllData(TableNames.item.name, map);
  }

  Future<ItemModel> loadItem(String key) {
    return loadData(TableNames.item.name, key).then(
      (value) => value as ItemModel,
    );
  }

  Future<Map<String, ItemModel>> loadAllItems() {
    return loadAllData(TableNames.item.name).then(
      (value) => value.cast<String, ItemModel>(),
    );
  }

  Future<void> deleteItem(String key) {
    return deleteData(TableNames.item.name, key);
  }

  Future<void> deleteAllItems() {
    return deleteAllData(TableNames.item.name);
  }

  Future<void> saveCollection(String key, CollectionModel value) {
    return saveData(TableNames.collection.name, key, value);
  }

  Future<void> saveAllCollections(Map<String, CollectionModel> map) {
    return saveAllData(TableNames.collection.name, map);
  }

  Future<CollectionModel> loadCollection(String key) {
    return loadData(TableNames.collection.name, key).then(
      (value) => value as CollectionModel,
    );
  }

  Future<Map<String, CollectionModel>> loadAllCollections() {
    return loadAllData(TableNames.collection.name).then(
      (value) => value.cast<String, CollectionModel>(),
    );
  }

  Future<void> deleteCollection(String key) {
    return deleteData(TableNames.item.name, key);
  }

  Future<void> deleteAllCollections() {
    return deleteAllData(TableNames.item.name);
  }
}

enum TableNames {
  collection('Collections'),
  item('Items');

  const TableNames(this.name);
  final String name;
}
