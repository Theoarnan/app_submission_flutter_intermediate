import 'dart:developer';

import 'package:app_submission_flutter_intermediate/src/common/routers/page_configuration_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/pages/login_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/pages/register_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/pages/splash_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/repository/auth_repository.dart';
import 'package:app_submission_flutter_intermediate/src/features/settings/presentation/pages/setting_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/camera_bloc/camera_bloc_cubit.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/stories_bloc/stories_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/pages/camera_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/pages/detail_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/pages/home_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/pages/post_story_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/widgets/choose_media.dart';
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
  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;
  bool isSetting = false;
  bool isPostStory = false;
  bool isCamera = false;
  bool isChooseMedia = false;
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
          ),
        ),
        if (isRegister)
          MaterialPage(
            key: const ValueKey("RegisterPage"),
            child: RegisterPage(
              onBackLogin: () {
                isRegister = false;
                notifyListeners();
              },
            ),
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
            toDetailStory: (String storyId) {
              selectStory = storyId;
              notifyListeners();
            },
          ),
        ),
        if (isSetting)
          MaterialPage(
            key: const ValueKey("SettingPage"),
            child: SettingPage(
              toHomePage: () {
                isSetting = false;
                notifyListeners();
              },
            ),
          ),
        if (selectStory != null)
          MaterialPage(
            key: ValueKey("DetailPage-$selectStory"),
            child: DetailPage(
              idStory: selectStory!,
              toHomePage: () {
                selectStory = null;
                notifyListeners();
              },
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
              onCloseMedia: () {
                isChooseMedia = false;
                notifyListeners();
              },
              toChooseMedia: () {
                isChooseMedia = true;
                notifyListeners();
              },
              toHome: () {
                isPostStory = false;
                notifyListeners();
              },
            ),
          ),
        if (isChooseMedia)
          ChooseMedia(
            onCloseChoose: () {
              isChooseMedia = false;
              notifyListeners();
            },
            toCamera: () {
              isCamera = true;
              notifyListeners();
            },
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
        if (state is AuthenticatedState) {
          isLoggedIn = true;
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
          isChooseMedia = false;
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
          isChooseMedia = false;
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
    } else if (configuration.isRegisterPage) {
      isRegister = true;
    } else if (configuration.isHomePage ||
        configuration.isLogginPage ||
        configuration.isSplashPage) {
      isUnknown = false;
      isRegister = false;
      isSetting = false;
      isPostStory = false;
      selectStory = null;
      isCamera = false;
      isChooseMedia = false;
    } else if (configuration.isSettingPage) {
      isUnknown = false;
      isRegister = false;
      isSetting = true;
      selectStory = null;
      isPostStory = false;
      isCamera = false;
      isChooseMedia = false;
    } else if (configuration.isDetailStoryPage) {
      isUnknown = false;
      isRegister = false;
      isSetting = false;
      isPostStory = false;
      isCamera = false;
      isChooseMedia = false;
      selectStory = configuration.storyId.toString();
    } else if (configuration.isPostStoryPage) {
      isUnknown = false;
      isRegister = false;
      isSetting = false;
      selectStory = null;
      isPostStory = true;
      isChooseMedia = false;
      isCamera = false;
    } else if (configuration.isChooseMediaPage) {
      isUnknown = false;
      isRegister = false;
      isSetting = false;
      selectStory = null;
      isPostStory = true;
      isChooseMedia = true;
      isCamera = false;
    } else if (configuration.isCameraPage) {
      isUnknown = false;
      isRegister = false;
      isSetting = false;
      selectStory = null;
      isPostStory = true;
      isChooseMedia = true;
      isCamera = true;
    } else {
      log(' Could not set new route');
    }
    notifyListeners();
  }

  @override
  PageConfigurationModel? get currentConfiguration {
    if (isLoggedIn == null) {
      return PageConfigurationModel.splash();
    } else if (isRegister && !isLoggedIn!) {
      return PageConfigurationModel.register();
    } else if (!isLoggedIn!) {
      return PageConfigurationModel.login();
    } else if (isLoggedIn! &&
        selectStory == null &&
        !isSetting &&
        !isPostStory &&
        !isChooseMedia &&
        !isCamera) {
      _navigatorKey.currentContext!.read<StoriesBloc>().add(GetAllStories());
      return PageConfigurationModel.home();
    } else if (isLoggedIn! &&
        isSetting &&
        selectStory == null &&
        !isPostStory &&
        !isChooseMedia &&
        !isCamera) {
      return PageConfigurationModel.setting();
    } else if (isLoggedIn! &&
        !isSetting &&
        selectStory != null &&
        !isPostStory &&
        !isChooseMedia &&
        !isCamera) {
      return PageConfigurationModel.detailStory(selectStory!);
    } else if (isLoggedIn! &&
        isPostStory &&
        !isSetting &&
        selectStory == null &&
        !isChooseMedia &&
        !isCamera) {
      _navigatorKey.currentContext!.read<CameraBlocCubit>().cameraStopped();
      return PageConfigurationModel.postStory();
    } else if (isLoggedIn! &&
        isPostStory &&
        !isSetting &&
        selectStory == null &&
        isChooseMedia &&
        !isCamera) {
      return PageConfigurationModel.chooseMedia();
    } else if (isLoggedIn! &&
        isPostStory &&
        !isSetting &&
        selectStory == null &&
        isChooseMedia &&
        isCamera) {
      return PageConfigurationModel.camera();
    } else if (isUnknown!) {
      return PageConfigurationModel.unknown();
    } else {
      return null;
    }
  }
}
