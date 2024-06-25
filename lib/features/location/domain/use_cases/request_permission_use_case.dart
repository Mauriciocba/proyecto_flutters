import 'package:pamphlets_management/features/location/domain/services/location_permission_service.dart';

class RequestPermissionUseCase {
  final LocationPermissionService _locationPermissionService;
  RequestPermissionUseCase(this._locationPermissionService);

  Future<void> call() async {
    await _locationPermissionService.requestPermission();
  }
}
