import 'package:dartz/dartz.dart';
import 'package:task_app/Core/Error/failures.dart';
import 'package:task_app/Features/Products/Data/DataSources/favorite_product_datasource.dart';
import 'package:task_app/Features/Products/Data/DataSources/products_datasource.dart';
import 'package:task_app/Features/Products/Data/Models/product_model.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> getProducts(bool forceUpdate);
  Future<bool> saveFavoriteProducts(List<Product> products);
  Future<bool> addFavoriteProduct(Product product);
  Future<bool> removeFavoriteProduct(Product product);
  Future<bool> removeFavoriteProducts();
  Future<List<Product>> getFavoriteProducts();
}

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsDataSource _productsDataSource;
  final ProductsDatabaseDataSource _productsDatabaseDataSource;
  final FavoriteProductDataSource _favoriteProductDataSource;
  final List<Product> _favoriteProducts;

  ProductsRepositoryImpl(
    this._productsDataSource,
    this._productsDatabaseDataSource,
    this._favoriteProductDataSource,
    this._favoriteProducts,
  );
  @override
  Future<Either<Failure, List<Product>>> getProducts(bool forceUpdate) async {
    if (forceUpdate) {
      final networkResult = await _productsDataSource.getProducts();
      if (networkResult.isRight()) {
        networkResult.fold((l) => null, (r) => _productsDatabaseDataSource.saveProducts(r));
      } 
      return networkResult;
    }else{
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
  
  @override
  Future<bool> removeFavoriteProducts() {
    return _favoriteProductDataSource.removeProducts();
  }
  
  @override
  Future<bool> saveFavoriteProducts(List<Product> products) {
    return _favoriteProductDataSource.saveProducts(products);
  }
  
  @override
  Future<List<Product>> getFavoriteProducts() async {
    final listFromDataSource = await  _favoriteProductDataSource.getProducts();
  
    if(listFromDataSource.isNotEmpty){
      _favoriteProducts.clear();
      _favoriteProducts.addAll(listFromDataSource);
    }

    return Future.value(_favoriteProducts);
  }
  
  @override
  Future<bool> addFavoriteProduct(Product product) {
    _favoriteProducts.add(product);
    return _favoriteProductDataSource.saveProducts(_favoriteProducts);
  }
  
  @override
  Future<bool> removeFavoriteProduct(Product product) {
    _favoriteProducts.remove(product);
    return _favoriteProductDataSource.saveProducts(_favoriteProducts);
  }
}
