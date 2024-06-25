import 'package:pamphlets_management/features/home/data/local/token_checker_repository.dart';
import 'package:pamphlets_management/features/login/data/storage/credential_local_storage_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenCheckerRepositoryImpl implements TokenCheckerRepository {
  @override
  Future<bool> checkToken() async {
    final storage = await SharedPreferences.getInstance();

    return storage.containsKey(CredentialLocalStorageImpl.tokenKey);
  }
}
