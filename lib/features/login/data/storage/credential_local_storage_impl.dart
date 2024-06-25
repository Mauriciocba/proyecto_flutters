import 'package:pamphlets_management/features/login/data/storage/credential_local_storage.dart';
import 'package:pamphlets_management/features/login/domain/entities/credential.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CredentialLocalStorageImpl implements CredentialLocalStorage {
  static const String tokenKey = 'TOKEN';
  final String refreshTokenKey = 'REFRESH_TOKEN';

  @override
  void save(Credential credential) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(tokenKey, credential.token);
    await prefs.setString(refreshTokenKey, credential.refreshToken);
  }

  @override
  Future<Credential> read() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString(tokenKey);
    final refreshToken = prefs.getString(refreshTokenKey);

    return Credential(token: token!, refreshToken: refreshToken!);
  }

  @override
  void clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
