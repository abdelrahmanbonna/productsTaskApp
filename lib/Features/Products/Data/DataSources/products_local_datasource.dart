import 'package:dartz/dartz.dart';
import 'package:task_app/Core/Error/failures.dart';
import 'package:task_app/Features/Products/Data/DataSources/products_datasource.dart';
import 'package:task_app/Features/Products/Data/Models/product_model.dart';
import 'package:task_app/Core/DataBase/hive_database.dart';
import 'package:task_app/Features/Products/products_constants.dart';

class ProductsLocalDatasource extends ProductsDatabaseDataSource {
  final HiveDatabase _hiveDatabase;

  ProductsLocalDatasource(this._hiveDatabase);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    final products = await _hiveDatabase.getData(ProductsConstants.productsKey);
    if (products.isNotEmpty) {
      return Right(products.entries.map((entry) => Product.fromJson(entry.value)).toList());
    } else {
      return const Left(CacheFailure(message: 'No products found'));
    }
  }

  @override
  Future<bool> saveProducts(List<Product> products) async {
    return _hiveDatabase
        .saveData(ProductsConstants.productsKey, products.map((e) => e.toJson()).toList())
        .then((value) => true)
        .catchError((error) => false);
  }
}