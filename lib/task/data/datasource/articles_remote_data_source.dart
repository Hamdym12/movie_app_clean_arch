import 'package:injectable/injectable.dart';
import 'package:movie_app_clean_arch/core/networking/api_constants.dart';
import 'package:movie_app_clean_arch/task/data/datasource/articles_base_data_source.dart';
import 'package:movie_app_clean_arch/task/data/models/article_response_model.dart';

import '../../../core/error/error_message_model.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/networking/api_client.dart';

@LazySingleton(as: ArticlesBaseDataSource)
class ArticlesRemoteDataSource extends ArticlesBaseDataSource{
  final ApiClient apiClient;
  ArticlesRemoteDataSource(this.apiClient);

  @override
  Future<ArticlesPageModel> getArticles({int offset = 0, int limit = 25}) async{

      final response = await apiClient.get(
          endPoint:ApiConstants.getArticlesPath,
          queryParameters: {
            'offset': offset,
            'limit': limit
          });
      if (response.statusCode == 200) {
        return ArticlesPageModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
    }
  }
}