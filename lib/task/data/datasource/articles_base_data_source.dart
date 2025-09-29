import 'package:dartz/dartz.dart';
import 'package:movie_app_clean_arch/core/error/failure.dart';
import 'package:movie_app_clean_arch/task/data/models/article_response_model.dart';

abstract class ArticlesBaseDataSource{
  Future<Either<Failure,ArticlesPageModel>> getArticles({int offset = 0, int limit = 25});
}