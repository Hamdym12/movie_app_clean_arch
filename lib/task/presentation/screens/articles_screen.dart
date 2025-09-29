import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_arch/core/di/service_locater.dart';
import 'package:movie_app_clean_arch/core/widgets/custom_error_widget.dart';
import 'package:movie_app_clean_arch/task/presentation/controller/states/articles_states.dart';
import '../../../core/helpers/toast_helper.dart';
import '../components/articles_list_widget.dart';
import '../controller/cubits/articles_cubit.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});
  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ArticlesCubit>()..getArticles(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Articles')),
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: BlocConsumer<ArticlesCubit, ArticlesStates>(
            listener: (prev,currentState){
              if(currentState is ArticlesErrorState){
                showToast(message: currentState.errorMessage);
              }
            },
            listenWhen: (prev,currentState)=>currentState is ArticlesErrorState,
            buildWhen: (prev,currentState)=>currentState is! LoadMoreArticlesState,
            builder: (context, state) {
              switch (state) {
                case ArticlesLoadingState _:
                  return const Center(child: CircularProgressIndicator());
                case ArticlesSuccessState _:
                  return ArticlesListWidget(articles: state.articles);
                case ArticlesErrorState _:
                  return CustomErrorWidget(
                      errorMessage: state.errorMessage,
                      onRetry: () => context.read<ArticlesCubit>().getArticles()
                  );
                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
