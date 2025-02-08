import 'package:dartz/dartz.dart';
import 'package:task_app/Core/Error/failures.dart';
import 'package:task_app/Features/Products/Data/Models/product_model.dart';

abstract class ProductsDataSource {
  Future<Either<Failure, List<Product>>> getProducts();
}

abstract class ProductsDatabaseDataSource extends ProductsDataSource {
  Future<bool> saveProducts(List<Product> products);
}