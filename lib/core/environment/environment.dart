import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String port = dotenv.get('PORT');
  static String host = dotenv.get('HOST');
  static String protocol = dotenv.get('PROTOCOL');
  static String baseUrl = dotenv.get('URL');
  static String googleClientId = dotenv.get('GOOGLE_CLIENT_ID');
  static String serverGoogleClientId = dotenv.get('SERVER_GOOGLE_CLIENT_ID');
}
