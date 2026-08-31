import 'package:dio/dio.dart';

import '../errors/exceptions.dart';
import 'api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio});

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  ServerException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ServerException('Connection timeout');
      case DioExceptionType.sendTimeout:
        return ServerException('Send timeout');
      case DioExceptionType.receiveTimeout:
        return ServerException('Receive timeout');
      case DioExceptionType.connectionError:
        return ServerException('Connection error');
      case DioExceptionType.cancel:
        return ServerException('Request cancelled');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?.toString();
        return ServerException(
          message ?? 'Bad response with status code: $statusCode',
        );
      case DioExceptionType.badCertificate:
        return ServerException('Bad certificate');
      case DioExceptionType.transformTimeout:
        return ServerException('Transform timeout');
      case DioExceptionType.unknown:
        return ServerException(error.message ?? 'Unknown error occurred');
    }
  }
}
