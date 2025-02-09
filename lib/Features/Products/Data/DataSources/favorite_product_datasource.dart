import 'package:task_app/Core/DataBase/hive_database.dart';
import 'package:task_app/Features/Products/Data/Models/product_model.dart';
import 'package:task_app/Features/Products/products_constants.dart';

abstract class FavoriteProductDataSource {
  Future<bool> saveProducts(List<Product> products);
  Future<bool> removeProducts();
  List<Product> getProducts();
}

class FavoriteProductDatasourceImpl implements FavoriteProductDataSource {
  final HiveDatabase _hiveDatabase;

  FavoriteProductDatasourceImpl(this._hiveDatabase);

  @override
  Future<bool> saveProducts(List<Product> products) async {
    return _hiveDatabase
        .saveData(ProductsConstants.favoriteProductsKey,
            products.map((e) => e.toJson()).toList())
        .then((value) => true)
        .catchError((error) => false);
  }

  @override
  List<Product> getProducts() {
    final List<dynamic> list =
        _hiveDatabase.getData(ProductsConstants.favoriteProductsKey);

    return list
        .map((entry) => Product.fromJson(entry as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<bool> removeProducts() {
    return _hiveDatabase
        .deleteData(ProductsConstants.favoriteProductsKey)
        .then((value) => true)
        .catchError((error) => false);
  }
}
