import 'package:pamphlets_management/features/location/data/models/location_permission_model.dart';
import 'package:pamphlets_management/features/location/domain/services/location_permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionServiceImpl implements LocationPermissionService {
  @override
  Future<void> requestPermission() async {
    LocationPermissionModel permission =
        LocationPermissionModel.fromPermissionStatus(
            await Permission.location.status);
    if (!permission.isAllowed) {
      await Permission.location.request();
    }
  }
}
