import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_prime_wave_task/core/error/failure.dart';
import 'package:flutter_prime_wave_task/task/data/models/article_page_model.dart';
import '../../domain/repository/base_articles_repository.dart';
import '../datasource/articles_base_data_source.dart';

@LazySingleton(as: BaseArticlesRepository)
class ArticlesRepositoryImpl extends BaseArticlesRepository{
  final ArticlesBaseDataSource articlesBaseDataSource;
  ArticlesRepositoryImpl({required this.articlesBaseDataSource});
  @override
  Future<Either<Failure, ArticlesPageModel>> getArticles({int offset = 1, int limit = 100}) async{
    final result = await articlesBaseDataSource.getArticles(offset: offset, limit: limit);
      return result;
  }
}