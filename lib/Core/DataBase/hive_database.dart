import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:task_app/Core/Base/base_database.dart';

class HiveDatabase implements BaseDatabase {
  final Box _box;

  HiveDatabase(this._box);

  @override
  Future<Map<String, dynamic>> getData(String key) {
    return _box.get(key);
  }

  @override
  Future<bool> deleteData(String key) {
    return _box.delete(key).then((value) => true).catchError((error) => false);
  }

  @override
  Future<bool> saveData<T>(String key, T data) {
    final String json = jsonEncode(data);
    return _box.put(key, json).then((value) => true).catchError((error) => false);
  }
}