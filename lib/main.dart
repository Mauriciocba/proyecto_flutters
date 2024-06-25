import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pamphlets_management/config/app_config_getit.dart';
import 'package:pamphlets_management/core/router/app_router.dart';
import 'package:url_strategy/url_strategy.dart';

import 'utils/styles/web_theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "dev.env");
  debugPrint(dotenv.get('ENV'));
  configureGetItApp();

  await initializeDateFormatting('es');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: navigatorKey,
      theme: WebTheme.getTheme(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
      debugShowCheckedModeBanner: false,
      routerConfig: GetIt.instance.get<AppRouter>().getRouterConfig(),
      title: 'Pamphlets management',
    );
  }
}
