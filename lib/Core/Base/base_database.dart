abstract class BaseDatabase {
  Future<bool> saveData<T>(String key, T data);
  Future<dynamic> getData(String key);
  Future<bool> deleteData(String key);
}
