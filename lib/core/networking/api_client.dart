import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retry/retry.dart';
import '../helpers/toast_helper.dart';

@Singleton()
class ApiClient {
  final Dio _dio;
  ApiClient(this._dio);

  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    int retries = 3
  }) async {
    int attempt = 0;
    final retryOptions = RetryOptions(
      maxAttempts: retries + 1,
      delayFactor: const Duration(seconds: 4),
      maxDelay: const Duration(seconds: 12),
    );

    return retryOptions.retry(
          () async {
        attempt++;
        return _dio.get(
          endPoint,
          queryParameters: queryParameters,
        );
      },
      retryIf: (e) => e is DioException,
      onRetry: (e) {
        if (e is DioException) {
          final message = e.message ??  'Unknown error';

          final shortMessage = message.length > 40
              ? '${message.substring(0, 40)}...' : message;
          showToast(
            message: "Error occurred: $shortMessage. Retrying… Attempt $attempt",
          );
        } else {
          showToast(
            message: "Unexpected error occurred. Retrying… Attempt $attempt",
          );
        }
      },
    );
  }
}
