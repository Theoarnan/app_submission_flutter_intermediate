import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Image.asset(
            ConstantsName.imgLogo1,
            width: 0.8.sw,
            height: 0.5.sh,
          ),
        ),
      ),
    );
  }
}
