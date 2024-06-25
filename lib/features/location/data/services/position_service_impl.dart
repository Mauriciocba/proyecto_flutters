import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pamphlets_management/features/location/data/models/location_permission_model.dart';
import 'package:pamphlets_management/features/location/domain/services/position_services.dart';
import 'package:permission_handler/permission_handler.dart';

class PositionServiceImpl implements PositionService {
  @override
  Future<Tuple2<double?, double?>> getPosition() async {
    double? latitude;
    double? longitude;

    LocationPermissionModel permission;

    permission = LocationPermissionModel.fromPermissionStatus(
        await Permission.location.status);
    if (permission.isAllowed) {
      final position = await Geolocator.getCurrentPosition();
      latitude = position.latitude;
      longitude = position.longitude;
    }
    return Tuple2<double?, double?>(latitude, longitude);
  }
}
