import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/get_articles_usecase.dart';
import '../states/articles_states.dart';

@lazySingleton
class ArticlesCubit extends Cubit<ArticlesStates>{
  ArticlesCubit(this._getArticlesUseCase):super(ArticlesInitialState());
  final GetArticlesUseCase _getArticlesUseCase;

  Future<void> getArticles({int offset = 0, int limit = 25})async{
    if (state.isFetching || state.limit >= state.totalArticles) return;
    final nextLimit = (state.limit + limit).clamp(0, state.totalArticles);

    emit(ArticlesLoadingState(
          isFetching: true,
          offset: state.offset,
          limit: nextLimit,
          totalArticles: state.totalArticles,
          articles: state.articles,
      ));
    try{
        final response = await _getArticlesUseCase.execute(offset: state.offset, limit: nextLimit);
        response.fold((l){
          emit(ArticlesErrorState(
            l.message,
            articles: state.articles,
            offset: state.offset,
            limit: state.limit,
            totalArticles: state.totalArticles,
            isFetching: false,
          ));
        },
           (r) {
             final updatedArticles = [...state.articles, ...r.articles];
             final nextOffset = state.offset + r.articles.length;
             emit(ArticlesSuccessState(
               articles: updatedArticles,
               offset: nextOffset,
               limit: nextLimit,
               totalArticles: r.totalArticles,
               isFetching: false,
             ));
             print(updatedArticles.length);
        });
      }catch(e){
        emit(ArticlesErrorState(
          e.toString(),
          articles: state.articles,
          offset: state.offset,
          limit: state.limit,
          totalArticles: state.totalArticles,
          isFetching: false,
        ));
    }
  }
}