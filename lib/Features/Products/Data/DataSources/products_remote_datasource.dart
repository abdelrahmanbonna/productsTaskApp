import 'package:dartz/dartz.dart';
import 'package:task_app/Core/Error/failures.dart';
import 'package:task_app/Features/Products/Data/DataSources/products_datasource.dart';
import 'package:task_app/Features/Products/Data/Models/product_model.dart';
import 'package:task_app/Core/Network/network_service.dart';
import 'package:task_app/Features/Products/products_endpoints.dart';

class ProductsRemoteDatasource extends ProductsDataSource {
  final NetworkService _networkService;

  ProductsRemoteDatasource(this._networkService);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    final response = await _networkService.get(ProductsEndpoints.products);
    if (response.statusCode == 200) {
      final List<Product> products = (response.data as List)
          .map((e) => Product.fromJson(e))
          .toList();
      return Right(products);
    } else {
      return const Left(ServerFailure(message: 'Failed to load products'));
    }
  }
}