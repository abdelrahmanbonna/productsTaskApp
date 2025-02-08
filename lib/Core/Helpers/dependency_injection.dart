import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:task_app/Core/Config/app_constants.dart';
import 'package:task_app/Core/DataBase/hive_database.dart';
import 'package:task_app/Core/Network/network_service.dart';
import 'package:task_app/Features/Products/Data/DataSources/products_datasource.dart';
import 'package:task_app/Features/Products/Data/DataSources/products_local_datasource.dart';
import 'package:task_app/Features/Products/Data/DataSources/products_remote_datasource.dart';
import 'package:task_app/Features/Products/Data/Repositories/products_repository.dart';

/// DependencyInjection is responsible for registering all app-wide dependencies
/// This includes services, repositories, and global controllers
class DependencyInjection {
  static void init() {
    // Register core services
    _initCoreServices();

    // Register repositories
    _initRepositories();
  }

  static void _initCoreServices() {
    // Core services are initialized here
    Get.put<Dio>(Dio(), permanent: true);
    Get.put<NetworkService>(
      NetworkService(
        dio: Get.find<Dio>(),
        baseUrl: AppConstants.baseUrl,
        interceptors: [],
      ),
      permanent: true,
    );

    Get.put<Box>(Hive.box(AppConstants.hiveBoxName), permanent: true);
    Get.put<HiveDatabase>(HiveDatabase(Get.find<Box>()), permanent: true);
  }

  static void _initRepositories() {
    // Repositories are initialized here
    Get.put<ProductsDataSource>(
        ProductsRemoteDatasource(Get.find<NetworkService>()),
        permanent: true);
    Get.put<ProductsDatabaseDataSource>(
        ProductsLocalDatasource(Get.find<HiveDatabase>()),
        permanent: true);
    Get.put<ProductsRepository>(
      ProductsRepositoryImpl(
        Get.find<ProductsDataSource>(),
        Get.find<ProductsDatabaseDataSource>(),
      ),
      permanent: true,
    );
  }
}
