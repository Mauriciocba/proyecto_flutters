import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pamphlets_management/features/home/presentation/home_page.dart';
import 'package:pamphlets_management/features/login/presentation/page/login_page.dart';
import 'package:pamphlets_management/features/sign_up/presentation/page/sign_up_page.dart';
import 'package:pamphlets_management/features/validation/presentation/page/validator_page.dart';
import 'package:pamphlets_management/features/validation/presentation/widgets/not_found_user_id.dart';
import 'package:pamphlets_management/features/forgot_password/presentation/widgets/otp_password_form.dart';

void setupAppRouter() {
  GetIt.instance.registerSingleton<AppRouter>(_AppRouterImpl());
}

abstract interface class AppRouter {
  void go(String routeName);
  void back();

  RouterConfig<Object> getRouterConfig();
}

class _AppRouterImpl implements AppRouter {
  late GoRouter _goRouter;

  _AppRouterImpl() {
    _goRouter = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (_, __) => const MaterialPage(child: LoginPage()),
        ),
        GoRoute(
          path: '/signUp',
          pageBuilder: (_, __) => const MaterialPage(child: SignUpPage()),
        ),
        GoRoute(
          path: '/email/validation',
          pageBuilder: (_, state) {
            final Map<String, String> queryParams = state.uri.queryParameters;
            final String? userIdParam = queryParams['user'];

            if (userIdParam != null) {
              return MaterialPage(
                  child: ValidatorPage(
                userId: int.tryParse(userIdParam)!,
              ));
            } else {
              return const MaterialPage(child: NotFoundUserId());
            }
          },
        ),
        GoRoute(
          path: '/forgot-password/validation',
          pageBuilder: (_, state) {
            final Map<String, String> queryParams = state.uri.queryParameters;
            final String? userIdParam = queryParams['user'];

            if (userIdParam != null) {
              return MaterialPage(
                  child: OtpPasswordForm(
                userId: int.tryParse(userIdParam)!,
              ));
            } else {
              return const MaterialPage(child: NotFoundUserId());
            }
          },
        ),
        GoRoute(
          path: '/home',
          pageBuilder: (_, __) => const MaterialPage(child: HomePage()),
        ),
      ],
    );
  }

  @override
  void back() {
    _goRouter.pop();
  }

  @override
  void go(String routeName) {
    _goRouter.go(routeName);
  }

  @override
  RouterConfig<Object> getRouterConfig() {
    return _goRouter;
  }
}
