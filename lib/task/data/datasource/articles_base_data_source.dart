import 'package:movie_app_clean_arch/task/data/models/article_response_model.dart';

abstract class ArticlesBaseDataSource{
  Future<ArticlesPageModel> getArticles({int offset = 0, int limit = 25});
}