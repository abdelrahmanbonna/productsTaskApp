import 'package:dartz/dartz.dart';
import 'package:task_app/Core/Error/failures.dart';
import 'package:task_app/Features/Products/Data/DataSources/products_datasource.dart';
import 'package:task_app/Features/Products/Data/Models/product_model.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> getProducts();
}

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsDataSource _productsDataSource;
  final ProductsDatabaseDataSource _productsDatabaseDataSource;

  ProductsRepositoryImpl(
    this._productsDataSource,
    this._productsDatabaseDataSource,
  );
  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    final cacheResult = await _productsDatabaseDataSource.getProducts();
    if (cacheResult.isRight()) {
      return cacheResult;
    } else {
      final networkResult = await _productsDataSource.getProducts();
      if (networkResult.isRight()) {
        networkResult.fold((l) => null, (r) => _productsDatabaseDataSource.saveProducts(r));
      } 
      return networkResult;
    }
  }
}
