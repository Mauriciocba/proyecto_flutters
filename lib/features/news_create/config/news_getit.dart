import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/news_create/data/news_repository_impl.dart';
import 'package:pamphlets_management/features/news_create/domain/repositories/news_repository.dart';
import 'package:pamphlets_management/features/news_create/domain/use_case/register_news.dart';

import '../../../core/network/api_service.dart';

void newsConfigure() {
  //Repositories
  GetIt.instance.registerSingleton<NewsRepository>(
      NewsRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerFactory(
      () => RegisterNewsUseCase(GetIt.instance<NewsRepository>()));
}
