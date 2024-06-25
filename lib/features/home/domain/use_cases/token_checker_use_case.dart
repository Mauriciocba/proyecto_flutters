import 'package:pamphlets_management/features/home/data/local/token_checker_repository.dart';

class TokenCheckerUseCase {
  final TokenCheckerRepository _tokenCheckerRepository;

  TokenCheckerUseCase({required TokenCheckerRepository tokenCheckerRepository})
      : _tokenCheckerRepository = tokenCheckerRepository;

  Future<bool> checkToken() async {
    return await _tokenCheckerRepository.checkToken();
  }
}
