import 'package:dartz/dartz.dart';
import 'package:flutter_prime_wave_task/core/error/failure.dart';
import 'package:flutter_prime_wave_task/task/data/models/article_page_model.dart';
import 'articles_base_data_source.dart';

class ArticlesLocalDataSource extends ArticlesBaseDataSource{
  @override
  Future<Either<Failure, ArticlesPageModel>> getArticles({int offset = 0, int limit = 25}) {
    // TODO: implement getArticles
    throw UnimplementedError();
  }
}