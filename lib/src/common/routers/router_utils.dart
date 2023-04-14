enum PAGES {
  splash,
  register,
  login,
  home,
  detail,
  postStory,
  setting,
  error,
}

const String basePath = '/moments';

extension AppPageExtension on PAGES {
  String get screenPath {
    switch (this) {
      case PAGES.splash:
        return '$basePath/splash';
      case PAGES.login:
        return '$basePath/auth';
      case PAGES.register:
        return 'register';
      case PAGES.home:
        return basePath;
      case PAGES.detail:
        return 'detail';
      case PAGES.postStory:
        return 'post';
      case PAGES.setting:
        return 'setting';
      case PAGES.error:
        return '$basePath/error';
      default:
        return '$basePath/splash';
    }
  }

  String get screenName {
    switch (this) {
      case PAGES.splash:
        return 'splashPage';
      case PAGES.login:
        return 'loginPage';
      case PAGES.register:
        return 'registerPage';
      case PAGES.home:
        return 'homePage';
      case PAGES.detail:
        return 'detailPage';
      case PAGES.postStory:
        return 'postPage';
      case PAGES.setting:
        return 'settingPage';
      case PAGES.error:
        return 'errorPage';
      default:
        return 'splashPage';
    }
  }
}
