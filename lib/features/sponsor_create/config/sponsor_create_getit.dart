import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/sponsor_create/data/sponsors_create_repository_impl.dart';
import 'package:pamphlets_management/features/sponsor_create/domain/repositories/sponsors_create_repository.dart';
import 'package:pamphlets_management/features/sponsor_create/domain/use_cases/register_sponsor_use_case.dart';

void sponsorsCreateConfigure() {
  //Repositories
  GetIt.instance.registerSingleton<SponsorCreateRepository>(
      SponsorsCreateRepositoryImpl(
          apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerFactory(
      () => RegisterSponsorUseCase(GetIt.instance<SponsorCreateRepository>()));
}
