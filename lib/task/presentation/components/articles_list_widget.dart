import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/article.dart';
import '../controller/cubits/articles_cubit.dart';
import '../controller/states/articles_states.dart';
import '../screens/article_details_screen.dart';

class ArticlesListWidget extends StatelessWidget {
  const ArticlesListWidget({super.key, required this.articles});
  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ArticlesCubit>().reset();
        context.read<ArticlesCubit>().getArticles();
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            if (notification.metrics.pixels == notification.metrics.maxScrollExtent
            && !context.read<ArticlesCubit>().state.isFetching) {
              context.read<ArticlesCubit>().getArticles(limit: 50,isLoadMore: true);
            }
           }
          return false;
          },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
          ListView.separated(
           itemBuilder: (context,index){
             final body = articles[index].body.length > 100
                 ? '${articles[index].body.substring(0, 100)}...'
                 : articles[index].body;
             return ListTile(
               title: Text(articles[index].title),
               subtitle: Text(body),
               onTap: (){
                 Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => ArticleDetailsScreen(article: articles[index]),
                     )
                 );
               },
             );
           },
           separatorBuilder: (context,index)=>const Divider(),
           itemCount: articles.length
            ),
          BlocBuilder<ArticlesCubit, ArticlesStates>(
          builder: (context, state) {
            if (state.isFetching) {
              return Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: Center(child: const CircularProgressIndicator()),
              );
            }
            return const SizedBox.shrink();
           },
           ),
          BlocBuilder<ArticlesCubit, ArticlesStates>(
            builder: (context, state) {
             return PositionedDirectional(
              start: 0,
              end: 40,
              bottom: 40,
              child: Align(
               alignment: AlignmentDirectional.centerEnd,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                    child: Text("${state.limit}/${state.totalArticles}")
                )
              ),
             );
           },
            )
        ],
        ),
      ),
    );
  }
}
