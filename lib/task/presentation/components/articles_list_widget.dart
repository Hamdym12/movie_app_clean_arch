import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/article.dart';
import '../controller/cubits/articles_cubit.dart';
import '../controller/states/articles_states.dart';
import '../screens/article_details_screen.dart';

class ArticlesListWidget extends StatefulWidget {
  const ArticlesListWidget({super.key, required this.articles});
  final List<Article> articles;

  @override
  State<ArticlesListWidget> createState() => _ArticlesListWidgetState();
}

class _ArticlesListWidgetState extends State<ArticlesListWidget> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 0 && !_showScrollToTop) {
      setState(() => _showScrollToTop = true);
    } else if (_scrollController.offset <= 0 && _showScrollToTop) {
      setState(() => _showScrollToTop = false);
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

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
            controller: _scrollController,
           itemBuilder: (context,index){
             final body = widget.articles[index].body.length > 100
                 ? '${widget.articles[index].body.substring(0, 100)}...'
                 : widget.articles[index].body;
             return ListTile(
               title: Text(widget.articles[index].title),
               subtitle: Text(body),
               onTap: (){
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => ArticleDetailsScreen(article: widget.articles[index]),
                   )
                 );
               },
             );
           },
           separatorBuilder: (context,index)=>const Divider(),
           itemCount: widget.articles.length
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
            ),
          if (_showScrollToTop)
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: ()=>_scrollToTop(),
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                    ),
                    child: Icon(
                     Icons.keyboard_double_arrow_up_rounded
                    ),
                  )
              ),
            ),
          )
        ],
        ),
      ),
    );
  }
}
