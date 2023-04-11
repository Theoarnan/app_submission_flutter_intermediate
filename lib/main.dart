import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/pages/login_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/pages/register_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/pages/splash_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/moments/presentation/pages/detail_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/moments/presentation/pages/home_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/moments/presentation/pages/post_story_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/settings/presentation/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moments',
      builder: (context, child) {
        ScreenUtil.init(context);
        return Theme(
          data: ThemeCustom.themeData(),
          child: child!,
        );
      },
      home: const RegisterPage(),
    );
  }
}
