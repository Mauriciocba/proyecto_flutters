import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/news_info/data/news_info_repository_impl.dart';
import 'package:pamphlets_management/features/news_info/domain/repositories/news_info_repository.dart';
import 'package:pamphlets_management/features/news_info/domain/use_cases/news_info_use_case.dart';

import '../../../core/network/api_service.dart';

void newsInfoConfigure() {
  //Repositories
  GetIt.instance.registerLazySingleton<NewsInfoRepository>(() =>
      NewsInfoRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerSingleton(
      GetNewsInfoUseCase(GetIt.instance<NewsInfoRepository>()));
}
