import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app_clean_arch/core/error/failure.dart';
import 'package:movie_app_clean_arch/task/data/models/article_response_model.dart';
import 'package:movie_app_clean_arch/task/domain/entities/article.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/repository/base_articles_repository.dart';
import '../datasource/articles_base_data_source.dart';

@LazySingleton(as: BaseArticlesRepository)
class ArticlesRepositoryImpl extends BaseArticlesRepository{
  final ArticlesBaseDataSource articlesBaseDataSource;
  ArticlesRepositoryImpl({required this.articlesBaseDataSource});
  @override
  Future<Either<Failure, ArticlesPageModel>> getArticles({int offset = 1, int limit = 100}) async{
    final result = await articlesBaseDataSource.getArticles(offset: offset, limit: limit);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}