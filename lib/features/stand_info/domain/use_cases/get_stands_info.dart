import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/stand_info/domain/entities/stands_info_model.dart';
import 'package:pamphlets_management/features/stand_info/domain/repositories/stands_info_repository.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

class GetStandsInfoUseCase {
  final StandsInfoRepository _standsInfoRepository;

  GetStandsInfoUseCase(this._standsInfoRepository);

  Future<Either<String, List<StandsInfoModel>>> call(int eventId)async{
    final failOrStands = await _standsInfoRepository.getStandsInfoByEvent(
      eventId: eventId,
    );

    if (failOrStands.getRight().isEmpty) {
      return const Left('No hay Stands cargados');
    }

    return Right(failOrStands.getRight());
  }
}