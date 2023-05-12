import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/flavor/flutter_mode_config.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatefulWidget {
  final Function() toSettingPage;
  const AboutPage({
    super.key,
    required this.toSettingPage,
  });

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Offset> fromTop;
  late Animation<Offset> fromLeft;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..forward();
    animation = UtilHelper.initializeCurvedAnimation(controller);
    fromTop = UtilHelper.initializePositioned(controller, isFromTop: true);
    fromLeft = UtilHelper.initializePositioned(controller, isFromLeft: true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  bool get isModeRelease => FlutterModeConfig.flutterMode == 'release';
  EdgeInsets get defaultPadding => EdgeInsets.symmetric(
        horizontal: 16.w,
      );

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: IconButton(
            onPressed: () => widget.toSettingPage(),
            iconSize: 24.sp,
            icon: const Icon(
              Icons.arrow_back,
              color: ThemeCustom.darkColor,
            ),
          ),
        ),
        title: SlideTransition(
          position: fromLeft,
          child: Text(
            translate.about,
            style: textTheme.labelLarge?.copyWith(
              fontSize: 24.sp,
            ),
          ),
        ),
        toolbarHeight: 58.h,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          height: 1.sh,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SlideTransition(
                    position: fromTop,
                    child: Image.asset(
                      ConstantsName.imgLogo1,
                      width: 0.8.sw,
                      height: 0.3.sh,
                    ),
                  ),
                ),
                Padding(
                  padding: defaultPadding,
                  child: SlideTransition(
                    position: fromTop,
                    child: Text(
                      translate.descAbout,
                      textAlign: TextAlign.left,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                        color: ThemeCustom.darkColor.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                SlideTransition(
                  position: fromTop,
                  child: Container(
                    color: UtilHelper.getColorIdentify(),
                    padding: defaultPadding.copyWith(top: 12.h, bottom: 12.h),
                    child: Center(
                      child: Text(
                        UtilHelper.getModeApp(),
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                SlideTransition(
                  position: fromLeft,
                  child: Padding(
                    padding: defaultPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translate.information,
                          textAlign: TextAlign.left,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Text(
                              translate.type,
                              textAlign: TextAlign.left,
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Badge(
                              largeSize: 20.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              backgroundColor: UtilHelper.getIsPaidApp()
                                  ? ThemeCustom.primaryColor
                                  : ThemeCustom.greenColor,
                              label: Text(
                                UtilHelper.getIsPaidApp()
                                    ? translate.paidApp
                                    : translate.freeApp,
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Text(
                              translate.version,
                              textAlign: TextAlign.left,
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            FutureBuilder(
                              future: PackageInfo.fromPlatform(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) return Container();
                                PackageInfo? packageInfo = snapshot.data;
                                return Center(
                                  child: Text(
                                    '${packageInfo?.version}',
                                    style: textTheme.bodyLarge?.copyWith(
                                      color: ThemeCustom.secondaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 6.h),
                        if (!isModeRelease)
                          Row(
                            children: [
                              Text(
                                translate.mode,
                                textAlign: TextAlign.left,
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                '-${FlutterModeConfig.flutterMode}',
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: ThemeCustom.secondaryColor,
                                ),
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
