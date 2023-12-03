import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'features/daily_news/data/data_sources/local/app_database.dart';
import 'features/daily_news/domain/usecases/get_saved_article.dart';
import 'features/daily_news/domain/usecases/remove_article.dart';
import 'features/daily_news/domain/usecases/save_article.dart';
import 'features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';

final di = GetIt.instance;

Future<void> initializeDependencies() async {

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  di.registerSingleton<AppDatabase>(database);
  
  // Dio
  di.registerSingleton<Dio>(Dio());

  // Dependencies
  di.registerSingleton<NewsApiService>(NewsApiService(di()));

  di.registerSingleton<ArticleRepository>(
    ArticleRepositoryImpl(di(),di())
  );
  
  //UseCases
  di.registerSingleton<GetArticleUseCase>(
    GetArticleUseCase(di())
  );

  di.registerSingleton<GetSavedArticleUseCase>(
    GetSavedArticleUseCase(di())
  );

  di.registerSingleton<SaveArticleUseCase>(
    SaveArticleUseCase(di())
  );
  
  di.registerSingleton<RemoveArticleUseCase>(
    RemoveArticleUseCase(di())
  );


  //Blocs
  di.registerFactory<RemoteArticlesBloc>(
    ()=> RemoteArticlesBloc(di())
  );

  di.registerFactory<LocalArticleBloc>(
    ()=> LocalArticleBloc(di(),di(),di())
  );


}