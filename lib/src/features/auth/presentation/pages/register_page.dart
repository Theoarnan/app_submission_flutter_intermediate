import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
            'Register',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 24.sp,
                ),
          ),
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 10.h,
          ),
          child: SizedBox(
            height: 0.84.sh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Greetings
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 2.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        'Silahkan masukkan nama, email, dan password kamu untuk mendaftarkan akun.',
                        textAlign: TextAlign.center,
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
                  margin: EdgeInsets.symmetric(vertical: 0.02.sh),
                  child: Form(
                    child: Column(
                      children: [
                        WidgetCustom.textFormField(
                          context,
                          controller: TextEditingController(),
                          hintText: 'Nama',
                        ),
                        SizedBox(
                          height: 0.02.sh,
                        ),
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
                        WidgetCustom.textFormField(
                          context,
                          controller: TextEditingController(),
                          suffixIcon: const Icon(Icons.visibility),
                          hintText: 'Konfirmasi Kata sandi',
                        ),
                        SizedBox(
                          height: 0.04.sh,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
