import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 10.h,
          ),
          child: SizedBox(
            height: 0.92.sh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Logo
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  child: Image.asset(
                    ConstantsName.imgLogo2,
                    width: 0.8.sw,
                  ),
                ),

                /// Greetings
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat datang!',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 28.sp,
                            ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        'Mohon login untuk melanjutkan.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ThemeCustom.secondaryColor,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ],
                  ),
                ),

                /// Form
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0.03.sh),
                  child: Form(
                    child: Column(
                      children: [
                        WidgetCustom.textFormField(
                          context,
                          controller: TextEditingController(),
                          hintText: 'Email',
                        ),
                        SizedBox(
                          height: 0.02.sh,
                        ),
                        WidgetCustom.textFormField(
                          context,
                          controller: TextEditingController(),
                          suffixIcon: const Icon(Icons.visibility),
                          hintText: 'Kata sandi',
                        ),
                        SizedBox(
                          height: 0.02.sh,
                        ),
                        WidgetCustom.elevatedButtonCustom(
                          context,
                          textButton: 'Masuk',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),

                /// REGISTER
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account? ",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Register",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ThemeCustom.yellowColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Center(
                  child: Text(
                    'Copyright ©️ 2023 . TheoDev . v1.0.0+1',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ThemeCustom.secondaryColor,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
