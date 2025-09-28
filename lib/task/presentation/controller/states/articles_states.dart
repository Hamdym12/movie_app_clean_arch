import 'package:equatable/equatable.dart';
import '../../../domain/entities/article.dart';

abstract class ArticlesStates extends Equatable{
  final List<Article> articles;
  final int offset;
  final int limit;
  final int totalArticles;
  final bool isFetching;
  const ArticlesStates({
    this.articles = const [],
    this.offset = 0,
    this.limit = 0,
    this.totalArticles = 100,
    this.isFetching = false
  });
  @override
  List<Object?> get props => [articles,offset,limit,totalArticles,isFetching];
}
class ArticlesInitialState extends ArticlesStates{
  const ArticlesInitialState({super.articles,super.offset,super.limit,super.totalArticles,super.isFetching});
  @override
  List<Object?> get props => [super.props];
}
class ArticlesLoadingState extends ArticlesStates{
  const ArticlesLoadingState({super.articles,super.offset,super.limit,super.totalArticles,super.isFetching});
  @override
  List<Object?> get props => [super.props];
}
class ArticlesSuccessState extends ArticlesStates{
  const ArticlesSuccessState({super.articles,super.offset,super.limit,super.totalArticles,super.isFetching});
  @override
  List<Object?> get props => [super.props];
}
class ArticlesErrorState extends ArticlesStates{
  final String message;
  const ArticlesErrorState(this.message,{super.articles,super.offset,super.limit,super.totalArticles,super.isFetching});
  @override
  List<Object?> get props => [super.props,message];

}