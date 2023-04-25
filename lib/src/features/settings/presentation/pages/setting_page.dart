import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/settings/presentation/bloc/setting_bloc_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            iconSize: 24.sp,
            icon: const Icon(
              Icons.arrow_back,
              color: ThemeCustom.darkColor,
            ),
          ),
        ),
        title: Text(
          translate.setting,
          style: textTheme.labelLarge?.copyWith(
            fontSize: 24.sp,
          ),
        ),
        toolbarHeight: 58.h,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5.h,
            horizontal: 4.w,
          ),
          child: Column(
            children: [
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
                      final bloc = BlocProvider.of<SettingBlocCubit>(context);
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
                      final bloc = BlocProvider.of<SettingBlocCubit>(context);
                      return bloc.setLocale(const Locale('en'));
                    },
                  )
                ],
              ),
              WidgetCustom.listTileCustom(
                context,
                title: translate.logout,
                icon: Icons.logout,
                onTap: () {
                  WidgetCustom.dialogLoadingState(context);
                  context.read<AuthBloc>().add(const LogoutAccountEvent());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
