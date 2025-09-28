import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../data/models/article_response_model.dart';

abstract class BaseArticlesRepository{
  Future<Either<Failure, ArticlesPageModel>> getArticles({int offset = 0, int limit = 25});
}