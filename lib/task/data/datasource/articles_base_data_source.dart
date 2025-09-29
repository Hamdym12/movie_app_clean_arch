import 'package:dartz/dartz.dart';
import 'package:flutter_prime_wave_task/core/error/failure.dart';
import 'package:flutter_prime_wave_task/task/data/models/article_page_model.dart';

abstract class ArticlesBaseDataSource{
  Future<Either<Failure,ArticlesPageModel>> getArticles({int offset = 0, int limit = 25});
}