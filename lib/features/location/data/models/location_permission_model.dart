import 'package:permission_handler/permission_handler.dart';

enum LocationPermissionTypes { allow, denied }

class LocationPermissionModel {
  final bool isAllowed;

  LocationPermissionModel({required this.isAllowed});

  factory LocationPermissionModel.fromPermissionStatus(
      PermissionStatus status) {
    return LocationPermissionModel(
      isAllowed: status.isGranted || status.isProvisional,
    );
  }
}
