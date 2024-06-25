import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/sponsors_info/domain/entities/sponsors_info_model.dart';
import 'package:pamphlets_management/features/sponsors_info/domain/repositories/sponsors_info_repository.dart';

class GetSponsorsInfoUseCase {
  final SponsorsInfoRepository _sponsorsInfoRepository;

  GetSponsorsInfoUseCase(this._sponsorsInfoRepository);

  Future<Either<String, List<Sponsor>>> call(int eventId) async {
    final failOrSponsors = await _sponsorsInfoRepository.getSponsorsInfoByEvent(
      eventId: eventId,
    );

    return failOrSponsors.fold(
      (left) => Left('Error al obtener información de los Sponsors: $left'),
      (right) {
        if (right.isEmpty) {
          return const Left('No hay Sponsors cargados');
        }
        return Right(right);
      },
    );
  }
}
