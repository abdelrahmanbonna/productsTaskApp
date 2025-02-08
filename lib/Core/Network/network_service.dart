import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkService {
  final String baseUrl;
  final Dio dio;
  final List<Interceptor> interceptors;

  NetworkService({required this.dio, this.interceptors = const [], required this.baseUrl}) {
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        requestHeader: true,
        responseHeader: true,
        requestBody: true,
        responseBody: true,
      ));
    }
    dio.interceptors.addAll(interceptors);
  }

  //To be used like this: [ networkService.addHeader('Authorization', 'Bearer $yourToken'); ]
  void addHeader(String key, String value) {
    interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          options.headers[key] = value;
          return handler.next(options); // Added semicolon here
        },
      ),
    );
    dio.interceptors.addAll(interceptors);
  }

  Future<Response> get(String url) async {
    return await dio.get('$baseUrl$url');
  }

  Future<Response> post(String url, dynamic data) async {
    return await dio.post('$baseUrl$url', data: data);
  }
}
