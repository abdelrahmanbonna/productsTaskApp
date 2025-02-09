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
    //todo: fix this
    //E/flutter (12082): [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: type 'List<dynamic>' is not a subtype of type 'FutureOr<List<Product>>?'
// E/flutter (12082): #0      FavoriteProductDatasourceImpl.getProducts (package:task_app/Features/Products/Data/DataSources/favorite_product_datasource.dart:30:10)
// E/flutter (12082): #1      ProductsRepositoryImpl.getFavoriteProducts (package:task_app/Features/Products/Data/Repositories/products_repository.dart:72:65)
// E/flutter (12082): #2      DetailsBloc._onGetFavoriteStatusEvent (package:task_app/Features/Details/Presentation/Blocs/details_bloc.dart:44:31)
// E/flutter (12082): #3      Bloc.on.<anonymous closure>.handleEvent (package:bloc/src/bloc.dar
    return Future.value(_hiveDatabase
        .getData(ProductsConstants.favoriteProductsKey)
        .map((dynamic entry) => Product.fromJson(entry))
        .toList());
  }

  @override
  Future<bool> removeProducts() {
    return _hiveDatabase
        .deleteData(ProductsConstants.favoriteProductsKey)
        .then((value) => true)
        .catchError((error) => false);
  }
}
