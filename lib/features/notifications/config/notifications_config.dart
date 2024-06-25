import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/notifications/data/notifier_service_impl.dart';
import 'package:pamphlets_management/features/notifications/domain/service/notifier_service.dart';
import 'package:pamphlets_management/features/notifications/domain/use_cases/send_notification_use_case.dart';

void notifierConfig() {
  //Service
  GetIt.instance.registerLazySingleton<NotifierService>(
      () => NotifierServiceImpl(apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerSingleton(SendNotificationUseCase(
    notificationSenderService: GetIt.instance.get<NotifierService>(),
  ));
}
