import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(58.h),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: ThemeCustom.darkColor,
            ),
          ),
          title: Text(
            'Pengaturan',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 24.sp,
                ),
          ),
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          child: Column(
            children: [
              WidgetCustom.listTileCustom(
                context,
                title: 'Ganti Bahasa',
                icon: Icons.translate_rounded,
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {},
              ),
              WidgetCustom.listTileCustom(
                context,
                title: 'Logout',
                icon: Icons.logout,
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  WidgetCustom.dialogLoadingState(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
