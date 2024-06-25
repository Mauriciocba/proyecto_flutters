import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/sponsor_edit/data/edit_sponsor_repository_impl.dart';
import 'package:pamphlets_management/features/sponsor_edit/domain/repositories/sponsor_edit_repository.dart';
import 'package:pamphlets_management/features/sponsor_edit/domain/use_cases/edit_sponsor_use_case.dart';

void editSponsorsGetItConfigure() {
  //Repositories
  GetIt.instance.registerSingleton<SponsorsEditRepository>(
      EditSponsorRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerFactory(
    ()=> EditSponsorsUseCase(GetIt.instance<SponsorsEditRepository>()));
}
