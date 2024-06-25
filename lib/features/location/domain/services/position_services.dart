import 'package:dartz/dartz.dart';

abstract interface class PositionService {
  Future<Tuple2<double?, double?>> getPosition();
}
