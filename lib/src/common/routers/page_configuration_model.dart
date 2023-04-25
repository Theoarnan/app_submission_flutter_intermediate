class PageConfigurationModel {
  final bool isUnknownPage;
  final bool? isLoggin;
  final bool isRegister;
  final bool isSetting;
  final bool isPostStory;
  final String? storyId;

  PageConfigurationModel.splash()
      : isUnknownPage = false,
        isRegister = false,
        isLoggin = null,
        storyId = null,
        isSetting = false,
        isPostStory = false;

  PageConfigurationModel.login()
      : isUnknownPage = false,
        isRegister = false,
        isLoggin = false,
        storyId = null,
        isSetting = false,
        isPostStory = false;

  PageConfigurationModel.register()
      : isUnknownPage = false,
        isRegister = true,
        isLoggin = false,
        storyId = null,
        isSetting = false,
        isPostStory = false;

  PageConfigurationModel.home()
      : isUnknownPage = false,
        isRegister = false,
        isLoggin = true,
        storyId = null,
        isSetting = false,
        isPostStory = false;

  PageConfigurationModel.detailStory(String id)
      : isUnknownPage = false,
        isRegister = false,
        isLoggin = true,
        storyId = id,
        isSetting = false,
        isPostStory = false;

  PageConfigurationModel.setting()
      : isUnknownPage = false,
        isRegister = false,
        isLoggin = true,
        storyId = null,
        isSetting = true,
        isPostStory = false;

  PageConfigurationModel.postStory()
      : isUnknownPage = false,
        isRegister = false,
        isLoggin = true,
        storyId = null,
        isSetting = false,
        isPostStory = true;

  PageConfigurationModel.unknown()
      : isUnknownPage = true,
        isRegister = false,
        isLoggin = false,
        storyId = null,
        isSetting = false,
        isPostStory = false;

  bool get isSplashPage =>
      isUnknownPage == false &&
      isRegister == false &&
      isLoggin == null &&
      storyId == null &&
      isSetting == false &&
      isPostStory == false;

  bool get isLogginPage =>
      isUnknownPage == false &&
      isRegister == false &&
      isLoggin == false &&
      storyId == null &&
      isSetting == false &&
      isPostStory == false;

  bool get isRegisterPage =>
      isUnknownPage == false &&
      isRegister == true &&
      isLoggin == false &&
      storyId == null &&
      isSetting == false &&
      isPostStory == false;

  bool get isHomePage =>
      isUnknownPage == false &&
      isRegister == false &&
      isLoggin == true &&
      storyId == null &&
      isSetting == false &&
      isPostStory == false;

  bool get isDetailStoryPage =>
      isUnknownPage == false &&
      isRegister == false &&
      isLoggin == true &&
      storyId != null &&
      isSetting == false &&
      isPostStory == false;

  bool get isSettingPage =>
      isUnknownPage == false &&
      isRegister == false &&
      isLoggin == true &&
      storyId == null &&
      isSetting == true &&
      isPostStory == false;

  bool get isPostStoryPage =>
      isUnknownPage == false &&
      isRegister == false &&
      isLoggin == true &&
      storyId == null &&
      isSetting == false &&
      isPostStory == true;
}
