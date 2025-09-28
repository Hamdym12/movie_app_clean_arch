// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../task/data/datasource/articles_base_data_source.dart' as _i317;
import '../../task/data/datasource/articles_remote_data_source.dart' as _i983;
import '../../task/data/repository/articles_repoistory_impl.dart' as _i1049;
import '../../task/domain/repository/base_articles_repository.dart' as _i91;
import '../../task/domain/usecases/get_articles_usecase.dart' as _i71;
import '../../task/presentation/controller/cubits/articles_cubit.dart' as _i220;
import '../networking/api_client.dart' as _i846;
import '../networking/dio_factory.dart' as _i103;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.singleton<_i846.ApiClient>(() => _i846.ApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i317.ArticlesBaseDataSource>(
      () => _i983.ArticlesRemoteDataSource(gh<_i846.ApiClient>()),
    );
    gh.lazySingleton<_i91.BaseArticlesRepository>(
      () => _i1049.ArticlesRepositoryImpl(
        articlesBaseDataSource: gh<_i317.ArticlesBaseDataSource>(),
      ),
    );
    gh.lazySingleton<_i71.GetArticlesUseCase>(
      () => _i71.GetArticlesUseCase(
        articlesRepository: gh<_i91.BaseArticlesRepository>(),
      ),
    );
    gh.lazySingleton<_i220.ArticlesCubit>(
      () => _i220.ArticlesCubit(gh<_i71.GetArticlesUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i103.RegisterModule {}
