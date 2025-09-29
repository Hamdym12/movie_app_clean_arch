import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_prime_wave_task/core/error/failure.dart';
import 'package:flutter_prime_wave_task/core/networking/api_constants.dart';
import 'package:flutter_prime_wave_task/task/data/datasource/articles_base_data_source.dart';
import 'package:flutter_prime_wave_task/task/data/models/article_page_model.dart';
import '../../../core/networking/api_client.dart';

@LazySingleton(as: ArticlesBaseDataSource)
class ArticlesRemoteDataSource extends ArticlesBaseDataSource{
  ArticlesRemoteDataSource(this.apiClient);
  final ApiClient apiClient;
  @override
  Future<Either<Failure, ArticlesPageModel>> getArticles({int offset = 0, int limit = 25}) async{
    try{
      final response = await apiClient.get(
        endPoint:ApiConstants.getArticlesPath,
        queryParameters: {
          'offset': offset,
          'limit': limit
     });
     if(response.statusCode == 200){
       return right(ArticlesPageModel.fromJson(response.data));
     }
     else{
       return left(ServerFailure.fromResponse(response.statusCode,response));
     }
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}