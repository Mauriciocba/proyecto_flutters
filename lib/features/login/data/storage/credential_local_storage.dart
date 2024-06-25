import 'package:pamphlets_management/features/login/domain/entities/credential.dart';

abstract interface class CredentialLocalStorage {
  void save(Credential credential);

  Future<Credential> read();

  void clear();
}
