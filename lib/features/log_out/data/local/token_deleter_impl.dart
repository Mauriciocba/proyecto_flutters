import 'package:pamphlets_management/features/log_out/data/local/token_deleter.dart';
import 'package:pamphlets_management/features/login/data/storage/credential_local_storage_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenDeleterImpl implements TokenDeleter {
  @override
  Future<bool> deleteToken() async {
    final storage = await SharedPreferences.getInstance();

    return await storage.remove(CredentialLocalStorageImpl.tokenKey);
  }
}
