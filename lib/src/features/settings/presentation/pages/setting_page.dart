import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/flavor/flutter_mode_config.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/settings/presentation/bloc/setting_bloc_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingPage extends StatefulWidget {
  final Function() toHomePage;
  const SettingPage({
    super.key,
    required this.toHomePage,
  });
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
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

  bool get isModeRelease => FlutterModeConfig.flutterMode == 'Release';

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
            onPressed: () => widget.toHomePage(),
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
            translate.setting,
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5.h,
              horizontal: 4.w,
            ).copyWith(top: 0),
            child: FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: fromLeft,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 48.sp,
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            child: Text(
                              'AT',
                              style: textTheme.bodyLarge?.copyWith(
                                color: ThemeCustom.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Arnan Theopilus',
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'artheo@gmail.com',
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: ThemeCustom.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    // Container(
                    //   color: ThemeCustom.yellowColor,
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 16.w,
                    //     vertical: 10.h,
                    //   ),
                    //   child: Center(
                    //     child: Text(
                    //       '${UtilHelper.getModeApp(
                    //         FlavorConfig.instance.flavor.name,
                    //       )}${!isModeRelease ? ' - ${FlutterModeConfig.flutterMode} ' : ''}',
                    //       style: textTheme.bodyLarge?.copyWith(
                    //         fontWeight: FontWeight.w500,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    WidgetCustom.expansionListLite(
                      context,
                      title: translate.changeLanguage,
                      icon: Icons.translate_rounded,
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      children: [
                        ListTile(
                          leading: Text(
                            UtilHelper.getFlag('id'),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          title: Text(
                            'Indonesia',
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onTap: () {
                            final bloc =
                                BlocProvider.of<SettingBlocCubit>(context);
                            return bloc.setLocale(const Locale('id'));
                          },
                        ),
                        ListTile(
                          leading: Text(
                            UtilHelper.getFlag('en'),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          title: Text(
                            'English',
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onTap: () {
                            final bloc =
                                BlocProvider.of<SettingBlocCubit>(context);
                            return bloc.setLocale(const Locale('en'));
                          },
                        )
                      ],
                    ),
                    WidgetCustom.listTileCustom(
                      context,
                      title: 'About',
                      icon: Icons.info_outline_rounded,
                      onTap: () {
                        WidgetCustom.dialogLoadingState(context);
                        context
                            .read<AuthBloc>()
                            .add(const LogoutAccountEvent());
                      },
                    ),
                    WidgetCustom.listTileCustom(
                      context,
                      title: translate.logout,
                      icon: Icons.logout,
                      onTap: () {
                        WidgetCustom.dialogLoadingState(context);
                        context
                            .read<AuthBloc>()
                            .add(const LogoutAccountEvent());
                      },
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.h),
                      child: FutureBuilder(
                        future: PackageInfo.fromPlatform(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return Container();
                          PackageInfo? packageInfo = snapshot.data;
                          return Center(
                            child: Text(
                              'version ${packageInfo?.version}',
                              style: textTheme.bodyLarge?.copyWith(
                                color: ThemeCustom.secondaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
