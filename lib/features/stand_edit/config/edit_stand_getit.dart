import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/stand_edit/data/edit_stand_repository_impl.dart';
import 'package:pamphlets_management/features/stand_edit/domain/repositories/stand_edit_repository.dart';
import 'package:pamphlets_management/features/stand_edit/domain/use_cases/edit_stand_use_case.dart';

void editStandGetItConfigure() {
  //Repositories
  GetIt.instance.registerSingleton<StandEditRepository>(
      EditStandRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerFactory(
    ()=> EditStandsUseCase(GetIt.instance<StandEditRepository>()));
}
