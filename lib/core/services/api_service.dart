import '../api/api_consumer.dart';

class ApiService {
  final ApiConsumer apiConsumer;

  ApiService({required this.apiConsumer});

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return apiConsumer.get(path, queryParameters: queryParameters);
  }

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return apiConsumer.post(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return apiConsumer.put(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return apiConsumer.delete(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }
}
