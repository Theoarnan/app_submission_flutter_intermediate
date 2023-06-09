import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/flavor/flutter_mode_config.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/shared_preference_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/models/login/login_result_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/settings/presentation/bloc/setting_bloc_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingPage extends StatefulWidget {
  final Function() toHomePage;
  final Function() toAboutPage;
  const SettingPage({
    super.key,
    required this.toHomePage,
    required this.toAboutPage,
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
  late LoginResultModel? dataUser;

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
                              UtilHelper.generateInitialText(
                                SharedPreferencesHelper().nameUser,
                              ),
                              style: textTheme.bodyLarge?.copyWith(
                                color: ThemeCustom.primaryColor,
                                fontSize: 24.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            SharedPreferencesHelper().nameUser,
                            textAlign: TextAlign.center,
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 22.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
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
                      title: translate.about,
                      icon: Icons.info_outline_rounded,
                      onTap: () {
                        widget.toAboutPage();
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
