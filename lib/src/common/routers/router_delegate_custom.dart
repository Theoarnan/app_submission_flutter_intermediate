import 'dart:developer';

import 'package:app_submission_flutter_intermediate/src/common/routers/page_configuration_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/pages/login_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/pages/register_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/pages/splash_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/repository/auth_repository.dart';
import 'package:app_submission_flutter_intermediate/src/features/settings/presentation/pages/setting_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/pages/camera_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/pages/detail_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/pages/home_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/pages/post_story_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouterDelegateCustom extends RouterDelegate<PageConfigurationModel>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;

  RouterDelegateCustom(
    this.authRepository,
  ) : _navigatorKey = GlobalKey<NavigatorState>();

  String? selectStory;
  bool isForm = false;

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;
  bool isSetting = false;
  bool isPostStory = false;
  bool isCamera = false;
  bool? isUnknown;

  List<Page> get _splashStack => const [
        MaterialPage(
          key: ValueKey("SplashPage"),
          child: SplashPage(),
        ),
      ];

  List<Page> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey("LoginPage"),
          child: LoginPage(
            onRegister: () {
              isRegister = true;
              notifyListeners();
            },
            onRegisterSuccess: () {
              isRegister = false;
              notifyListeners();
            },
          ),
        ),
        if (isRegister)
          const MaterialPage(
            key: ValueKey("RegisterPage"),
            child: RegisterPage(),
          ),
      ];

  List<Page> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey("HomePage"),
          child: HomePage(
            toSetting: () {
              isSetting = true;
              notifyListeners();
            },
            toPostStory: () {
              isPostStory = true;
              notifyListeners();
            },
            toDetailStory: (String stroyId) {
              selectStory = stroyId;
              notifyListeners();
            },
          ),
        ),
        if (isSetting)
          const MaterialPage(
            key: ValueKey("SettingPage"),
            child: SettingPage(),
          ),
        if (selectStory != null)
          MaterialPage(
            key: ValueKey("DetailPage-$selectStory"),
            child: DetailPage(
              idStory: selectStory!,
            ),
          ),
        if (isPostStory)
          MaterialPage(
            key: const ValueKey("PostStoryPage"),
            child: PostStoryPage(
              toCamera: () {
                isCamera = true;
                notifyListeners();
              },
              toHome: () {
                isPostStory = false;
                notifyListeners();
              },
            ),
          ),
        if (isCamera)
          MaterialPage(
            key: const ValueKey("CameraPage"),
            child: CameraPage(
              toBackPostStory: () {
                isCamera = false;
                isPostStory = true;
                notifyListeners();
              },
            ),
          ),
      ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState || state is LoginSuccessState) {
          isLoggedIn = true;
          isSetting = false;
          selectStory = null;
          isPostStory = false;
          isCamera = false;
          notifyListeners();
        } else if (state is UnAuthenticatedState) {
          if (state.isLoggedIn == null) {
            BlocProvider.of<AuthBloc>(context).add(
              const SetIsLoggedIn(stateKey: false),
            );
          }
          isSetting = false;
          selectStory = null;
          isPostStory = false;
          isCamera = false;
          isLoggedIn = state.isLoggedIn;
          notifyListeners();
        }
      },
      child: Navigator(
        key: _navigatorKey,
        pages: [
          if (isLoggedIn == null)
            ..._splashStack
          else if (isLoggedIn == true)
            ..._loggedInStack
          else
            ..._loggedOutStack
        ],
        onPopPage: (route, result) {
          final didPop = route.didPop(result);
          if (!didPop) {
            return false;
          }
          isRegister = false;
          isSetting = false;
          selectStory = null;
          isPostStory = false;
          isCamera = false;
          notifyListeners();
          return true;
        },
      ),
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(PageConfigurationModel configuration) async {
    if (configuration.isUnknownPage) {
      isUnknown = true;
      isRegister = false;
    } else if (configuration.isSplashPage) {
      isLoggedIn = null;
    } else if (configuration.isRegisterPage) {
      isRegister = true;
    } else if (configuration.isHomePage) {
      isUnknown = false;
      isLoggedIn = true;
      isSetting = false;
      isPostStory = false;
      selectStory = null;
      isCamera = false;
    } else if (configuration.isSetting) {
      isUnknown = false;
      isLoggedIn = true;
      isSetting = true;
      selectStory = null;
      isPostStory = false;
      isCamera = false;
    } else if (configuration.isDetailStoryPage) {
      isUnknown = false;
      isLoggedIn = true;
      isSetting = false;
      isPostStory = false;
      isCamera = false;
      selectStory = configuration.storyId.toString();
    } else if (configuration.isPostStory) {
      isUnknown = false;
      isLoggedIn = true;
      isSetting = false;
      selectStory = null;
      isPostStory = true;
      isCamera = false;
    } else {
      log(' Could not set new route');
    }
    notifyListeners();
  }

  @override
  PageConfigurationModel? get currentConfiguration {
    if (isLoggedIn == null) {
      return PageConfigurationModel.splash();
    } else if (isRegister == true) {
      return PageConfigurationModel.register();
    } else if (!isLoggedIn!) {
      return PageConfigurationModel.login();
    } else if (isLoggedIn! &&
        selectStory == null &&
        !isSetting &&
        !isPostStory) {
      return PageConfigurationModel.home();
    } else if (isLoggedIn! &&
        isSetting &&
        selectStory == null &&
        !isPostStory) {
      return PageConfigurationModel.setting();
    } else if (isLoggedIn! && selectStory != null && !isPostStory) {
      return PageConfigurationModel.detailStory(selectStory!);
    } else if (isLoggedIn! &&
        isPostStory &&
        !isSetting &&
        selectStory == null) {
      return PageConfigurationModel.postStory();
    } else if (isUnknown!) {
      return PageConfigurationModel.unknown();
    } else {
      return null;
    }
  }
}
