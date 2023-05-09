class PageConfigurationModel {
  final bool isUnknownPage;
  final bool? isLoggin;
  final bool isRegister;
  final bool isSetting;
  final bool isPostStory;
  final bool isCamera;
  final bool isChooseMedia;
  final bool isMap;
  final bool isMapChoose;
  final String? storyId;

  PageConfigurationModel.splash()
      : isUnknownPage = false,
        isRegister = false,
        isLoggin = null,
        storyId = null,
        isSetting = false,
        isCamera = false,
        isChooseMedia = false,
        isMap = false,
        isMapChoose = false,
        isPostStory = false;

  PageConfigurationModel.login()
      : isUnknownPage = false,
        isRegister = false,
        isLoggin = false,
        storyId = null,
        isSetting = false,
        isCamera = false,
        isChooseMedia = false,
        isMap = false,
        isMapChoose = false,
        isPostStory = false;

  PageConfigurationModel.register()
      : isUnknownPage = false,
        isRegister = true,
        isLoggin = false,
        storyId = null,
        isSetting = false,
        isCamera = false,
        isChooseMedia = false,
        isMap = false,
        isMapChoose = false,
        isPostStory = false;

  PageConfigurationModel.home()
      : isUnknownPage = false,
        isRegister = false,
        isLoggin = true,
        storyId = null,
        isSetting = false,
        isCamera = false,
        isChooseMedia = false,
        isMap = false,
        isMapChoose = false,
        isPostStory = false;

  PageConfigurationModel.detailStory(String id)
      : isUnknownPage = false,
        isRegister = false,
        isLoggin = true,
        storyId = id,
        isSetting = false,
        isCamera = false,
        isChooseMedia = false,
        isMap = false,
        isMapChoose = false,
        isPostStory = false;

  PageConfigurationModel.setting()
      : isUnknownPage = false,
        isRegister = false,
        isLoggin = true,
        storyId = null,
        isSetting = true,
        isCamera = false,
        isChooseMedia = false,
        isMap = false,
        isMapChoose = false,
        isPostStory = false;

  PageConfigurationModel.postStory()
      : isUnknownPage = false,
        isRegister = false,
        isLoggin = true,
        storyId = null,
        isSetting = false,
        isCamera = false,
        isChooseMedia = false,
        isMap = false,
        isMapChoose = false,
        isPostStory = true;

  PageConfigurationModel.unknown()
      : isUnknownPage = true,
        isRegister = false,
        isLoggin = false,
        storyId = null,
        isSetting = false,
        isCamera = false,
        isChooseMedia = false,
        isMap = false,
        isMapChoose = false,
        isPostStory = false;

  PageConfigurationModel.camera()
      : isUnknownPage = false,
        isRegister = false,
        isLoggin = true,
        storyId = null,
        isSetting = false,
        isCamera = true,
        isChooseMedia = true,
        isMap = false,
        isMapChoose = false,
        isPostStory = true;

  PageConfigurationModel.chooseMedia()
      : isUnknownPage = false,
        isRegister = false,
        isLoggin = true,
        storyId = null,
        isSetting = false,
        isCamera = false,
        isChooseMedia = true,
        isMap = false,
        isMapChoose = false,
        isPostStory = true;

  PageConfigurationModel.maps(String id)
      : isUnknownPage = false,
        isRegister = false,
        isLoggin = true,
        storyId = id,
        isSetting = false,
        isCamera = false,
        isChooseMedia = false,
        isMap = true,
        isMapChoose = false,
        isPostStory = false;

  PageConfigurationModel.mapChoose()
      : isUnknownPage = false,
        isRegister = false,
        isLoggin = true,
        storyId = null,
        isSetting = false,
        isCamera = false,
        isChooseMedia = false,
        isMap = false,
        isMapChoose = true,
        isPostStory = true;

  bool get isSplashPage =>
      isUnknownPage == false &&
      isRegister == false &&
      isLoggin == null &&
      storyId == null &&
      isSetting == false &&
      isCamera == false &&
      isChooseMedia == false &&
      isMap == false &&
      isMapChoose == false &&
      isPostStory == false;

  bool get isLogginPage =>
      isUnknownPage == false &&
      isRegister == false &&
      isLoggin == false &&
      storyId == null &&
      isSetting == false &&
      isCamera == false &&
      isChooseMedia == false &&
      isMap == false &&
      isMapChoose == false &&
      isPostStory == false;

  bool get isRegisterPage =>
      isUnknownPage == false &&
      isRegister == true &&
      isLoggin == false &&
      storyId == null &&
      isSetting == false &&
      isCamera == false &&
      isChooseMedia == false &&
      isMap == false &&
      isMapChoose == false &&
      isPostStory == false;

  bool get isHomePage =>
      isUnknownPage == false &&
      isRegister == false &&
      isLoggin == true &&
      storyId == null &&
      isSetting == false &&
      isCamera == false &&
      isChooseMedia == false &&
      isMap == false &&
      isMapChoose == false &&
      isPostStory == false;

  bool get isDetailStoryPage =>
      isUnknownPage == false &&
      isRegister == false &&
      isLoggin == true &&
      storyId != null &&
      isSetting == false &&
      isCamera == false &&
      isChooseMedia == false &&
      isMap == false &&
      isMapChoose == false &&
      isPostStory == false;

  bool get isSettingPage =>
      isUnknownPage == false &&
      isRegister == false &&
      isLoggin == true &&
      storyId == null &&
      isSetting == true &&
      isCamera == false &&
      isChooseMedia == false &&
      isMap == false &&
      isMapChoose == false &&
      isPostStory == false;

  bool get isPostStoryPage =>
      isUnknownPage == false &&
      isRegister == false &&
      isLoggin == true &&
      storyId == null &&
      isSetting == false &&
      isCamera == false &&
      isChooseMedia == false &&
      isMap == false &&
      isMapChoose == false &&
      isPostStory == true;

  bool get isCameraPage =>
      isUnknownPage == false &&
      isRegister == false &&
      isLoggin == true &&
      storyId == null &&
      isSetting == false &&
      isCamera == true &&
      isChooseMedia == true &&
      isMap == false &&
      isMapChoose == false &&
      isPostStory == true;

  bool get isChooseMediaPage =>
      isUnknownPage == false &&
      isRegister == false &&
      isLoggin == true &&
      storyId == null &&
      isSetting == false &&
      isCamera == false &&
      isChooseMedia == true &&
      isMap == false &&
      isMapChoose == false &&
      isPostStory == true;

  bool get isMapPage =>
      isUnknownPage == false &&
      isRegister == false &&
      isLoggin == true &&
      storyId != null &&
      isSetting == false &&
      isCamera == false &&
      isChooseMedia == false &&
      isMap == true &&
      isMapChoose == false &&
      isPostStory == false;

  bool get isMapChoosePage =>
      isUnknownPage == false &&
      isRegister == false &&
      isLoggin == true &&
      storyId == null &&
      isSetting == false &&
      isCamera == false &&
      isChooseMedia == false &&
      isMap == false &&
      isMapChoose == true &&
      isPostStory == true;
}
