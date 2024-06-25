import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/location/domain/services/position_services.dart';

class GetUserPositionUseCase {
  final PositionService _positionService;
  GetUserPositionUseCase(this._positionService);

  Future<Tuple2<double?, double?>> call() async {
    return await _positionService.getPosition();
  }
}
