import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class ApiClient{
  final Dio _dio;
  ApiClient(this._dio);

  Future<Response> get({
    required String endPoint,
    Map<String,dynamic>? queryParameters,
    int retries = 3,
  }) async {
    int attempt = 0;
   while(true){
    try{
      var response = await _dio.get(
        endPoint,
        queryParameters: queryParameters,
      );
      return response;
    }
    catch(e){
      attempt++;
      if (attempt > retries) rethrow;
      await Future.delayed(Duration(seconds: 1 << attempt));
    }
  }
  }
}