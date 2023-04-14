import 'dart:developer';

import 'package:app_submission_flutter_intermediate/src/common/routers/router_utils.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/not_found_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/pages/login_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/pages/register_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/pages/splash_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/moments/presentation/pages/detail_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/moments/presentation/pages/home_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/moments/presentation/pages/post_story_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/settings/presentation/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterApp {
  static late BuildContext context;
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  RouterApp.setStream(BuildContext ctx) {
    context = ctx;
  }

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: PAGES.splash.screenPath,
        name: PAGES.splash.screenName,
        builder: (context, state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: PAGES.login.screenPath,
        name: PAGES.login.screenName,
        builder: (context, state) {
          return const LoginPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: PAGES.register.screenPath,
            name: PAGES.register.screenName,
            builder: (context, state) {
              return const RegisterPage();
            },
          ),
        ],
      ),
      GoRoute(
        path: PAGES.home.screenPath,
        name: PAGES.home.screenName,
        builder: (context, state) {
          return const HomePage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: PAGES.detail.screenPath,
            name: PAGES.detail.screenName,
            builder: (context, state) {
              return const DetailPage();
            },
          ),
          GoRoute(
            path: PAGES.postStory.screenPath,
            name: PAGES.postStory.screenName,
            builder: (context, state) {
              return const PostStoryPage();
            },
          ),
          GoRoute(
            path: PAGES.setting.screenPath,
            name: PAGES.setting.screenName,
            builder: (context, state) {
              return const SettingPage();
            },
          ),
        ],
      ),
    ],
    initialLocation: PAGES.splash.screenPath,
    errorBuilder: (context, state) => const NotFoundPage(),
    redirect: (_, GoRouterState state) {
      final bool isLoginPage = state.subloc == PAGES.login.screenPath ||
          state.subloc == PAGES.register.screenPath;
      log('Test: ${state.subloc}');

      ///  Check if not login
      ///  if current page is login page we don't need to direct user
      ///  but if not we must direct user to login page
      // if (!sl<PrefManager>().isLogin) {
      //   return isLoginPage ? null : Routes.login.path;
      // }

      /// Check if already login and in login page
      /// we should direct user to main page

      // if (isLoginPage && sl<PrefManager>().isLogin) {
      //   return Routes.root.path;
      // }

      /// No direct
      return null;
    },
  );

  static GoRouter get router => _router;
}
