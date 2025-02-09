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
  List<Product> _favoriteProducts;

  ProductsRepositoryImpl(
    this._productsDataSource,
    this._productsDatabaseDataSource,
    this._favoriteProductDataSource,
    this._favoriteProducts,
  );

  @override
  Future<Either<Failure, List<Product>>> getProducts(bool forceUpdate) async {
    if (forceUpdate) {
      final result = await _productsDataSource.getProducts();
      result.fold(
        (l) => null,
        (r) => _productsDatabaseDataSource.saveProducts(r),
      );
      _favoriteProducts = _favoriteProductDataSource.getProducts();
    }

    final cacheResult = await _productsDatabaseDataSource.getProducts();
    if (cacheResult.isRight()) {
      return cacheResult.map((r) => r.map((e) {
            final isFavorite = _favoriteProducts.any((fav) => fav.id == e.id);
            return e.copyWith(isFavorite: isFavorite);
          }).toList());
    } else {
      final networkResult = await _productsDataSource.getProducts();
      if (networkResult.isRight()) {
        networkResult.fold(
            (l) => null,
            (r) => _productsDatabaseDataSource.saveProducts(
                  r,
                ));
      }
      return networkResult;
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
    final listFromDataSource = _favoriteProductDataSource.getProducts();

    if (listFromDataSource.isNotEmpty) {
      _favoriteProducts.clear();
      _favoriteProducts.addAll(listFromDataSource);
    }

    return Future.value(_favoriteProducts);
  }

  @override
  Future<bool> addFavoriteProduct(Product product) async {
    final updatedProduct = product.copyWith(isFavorite: true);
    _favoriteProducts.removeWhere((p) => p.id == product.id);
    _favoriteProducts.add(updatedProduct);
    return _favoriteProductDataSource.saveProducts(_favoriteProducts);
  }

  @override
  Future<bool> removeFavoriteProduct(Product product) async {
    _favoriteProducts.removeWhere((p) => p.id == product.id);
    return _favoriteProductDataSource.saveProducts(_favoriteProducts);
  }
}
