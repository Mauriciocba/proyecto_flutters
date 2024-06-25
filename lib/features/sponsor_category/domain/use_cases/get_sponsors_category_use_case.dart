import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_model.dart';

import '../repositories/sponsors_category_repository.dart';

class GetSponsorsCategoryUseCase {
  final SponsorsCategoryRepository _sponsorsCategoryRepository;

  GetSponsorsCategoryUseCase(this._sponsorsCategoryRepository);

  Future<Either<String, List<SponsorsCategoryModel>>> call(int eventId) async {
    final failOrCSponsors = await _sponsorsCategoryRepository.getEventID(
      eventId: eventId,
    );

    return failOrCSponsors.fold(
      (left) => Left('Error al obtener categoría de Sponsors: $left'),
      (right) {
        if (right.isEmpty) {
          return const Left('No hay categoría de Sponsors cargados');
        }
        return Right(right);
      },
    );
  }
}
