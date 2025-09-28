import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_arch/core/di/service_locater.dart';
import 'package:movie_app_clean_arch/task/presentation/controller/states/articles_states.dart';
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
          child: BlocBuilder<ArticlesCubit, ArticlesStates>(
            buildWhen: (previousState, currentState) =>
                    currentState is! ArticlesLoadingState,
            builder: (context, state) {
              switch (state) {
                case ArticlesLoadingState _:
                  return const Center(child: CircularProgressIndicator());
                case ArticlesSuccessState _:
                  return ArticlesListWidget(articles: state.articles);
                case ArticlesErrorState _:
                  return const Center(child: Text('Error'));
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
