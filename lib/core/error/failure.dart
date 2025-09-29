import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;
  final dynamic data;

  const Failure(this.message, {this.statusCode, this.data});

  @override
  List<Object?> get props => [message, statusCode, data];

  @override
  String toString() =>
      'Failure(message: $message, statusCode: $statusCode, data: $data)';
}

class ServerFailure extends Failure {
  const ServerFailure(
      super.message, {
        super.statusCode,
        super.data,
      });

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure('Connection timeout with server');

      case DioExceptionType.sendTimeout:
        return const ServerFailure('Send timeout with server');

      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Receive timeout from server');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response,
        );

      case DioExceptionType.cancel:
        return const ServerFailure('Request was canceled');

      case DioExceptionType.connectionError:
        return const ServerFailure('Network connection error\nplease check your internet and try again');

      case DioExceptionType.unknown:
        if (dioError.message != null &&
            dioError.message!.contains('SocketException')) {
          return const ServerFailure(
              'No network connection. Please check your internet and try again');
        }
        return const ServerFailure('Unexpected error occurred, please try again');

      default:
        return const ServerFailure('Error occurred, try again later');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, Response? response) {
    final data = response?.data;
    if (statusCode == 422) {
      if (data != null && data is Map<String, dynamic>) {
        final detail = data['detail'];
        if (detail != null && detail is List) {
          final messages = detail.map((e) {
            if (e is Map<String, dynamic>) {
              return e['msg']?.toString() ?? 'Invalid input';
            }
            return 'Invalid input';
          }).join(', ');

          return ServerFailure(
            messages,
            statusCode: statusCode,
            data: data,
          );
        }
      }

      return ServerFailure(
        'Validation error occurred',
        statusCode: statusCode,
        data: data,
      );    }

    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return ServerFailure(
          response?.data['error']?['message'] ??
              'Unauthorized request, please login again',
          statusCode: statusCode,
          data: response?.data,
        );
      case 404:
        return ServerFailure(
          'Resource not found',
          statusCode: statusCode,
          data: response?.data,
        );
      case 500:
        return ServerFailure(
          'Internal server error, please try again later',
          statusCode: statusCode,
          data: response?.data,
        );
      default:
        return ServerFailure(
          'An unexpected error occurred',
          statusCode: statusCode,
          data: response?.data,
        );
    }
  }
}
