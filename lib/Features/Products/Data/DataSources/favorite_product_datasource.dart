import 'package:task_app/Core/DataBase/hive_database.dart';
import 'package:task_app/Features/Products/Data/Models/product_model.dart';
import 'package:task_app/Features/Products/products_constants.dart';

abstract class FavoriteProductDataSource {
  Future<bool> saveProducts(List<Product> products);
  Future<bool> removeProducts();
  Future<List<Product>> getProducts();
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
  Future<List<Product>> getProducts() {
    return _hiveDatabase
        .getData(ProductsConstants.favoriteProductsKey)
        .map((dynamic entry) => Product.fromJson(entry))
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
