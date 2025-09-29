import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failure.dart';
import '../../data/models/article_page_model.dart';
import '../repository/base_articles_repository.dart';

@lazySingleton
class GetArticlesUseCase{
  final BaseArticlesRepository articlesRepository;
  GetArticlesUseCase({required this.articlesRepository});

  Future<Either<Failure, ArticlesPageModel>> execute({int offset = 0, int limit = 25}) async{
    return await articlesRepository.getArticles(offset: offset, limit: limit);
  }
}