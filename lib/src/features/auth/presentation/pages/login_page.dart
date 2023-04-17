import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/validate_form_util.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/models/login/login_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formGlobalKey = GlobalKey<FormState>();
  final _emailField = TextEditingController();
  final _passswordField = TextEditingController();

  bool isObscurePass = true;

  @override
  void dispose() {
    super.dispose();
    _emailField.dispose();
    _passswordField.dispose();
  }

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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            WidgetCustom.dialogLoadingState(context);
          } else if (state is LoginSuccessState) {
            Navigator.of(context).pop();
            WidgetCustom.toastSuccessPostState(context);
          } else if (state is AuthErrorState) {
            Navigator.of(context).pop();
            WidgetCustom.toastErrorState(context, error: state.error);
          }
        },
        child: SafeArea(
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
                          'Selamat datang',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontSize: 28.sp,
                                  ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          'Mohon login untuk melanjutkan.',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                      key: _formGlobalKey,
                      child: Column(
                        children: [
                          WidgetCustom.textFormField(
                            context,
                            controller: _emailField,
                            hintText: 'Email',
                            validator: (value) {
                              return ValidationFormUtil.validateEmail(value!);
                            },
                          ),
                          SizedBox(
                            height: 0.02.sh,
                          ),
                          WidgetCustom.textFormField(
                            context,
                            controller: _passswordField,
                            suffixIcon: Icon(
                              isObscurePass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onTapSuffixIcon: () {
                              setState(() {
                                isObscurePass = !isObscurePass;
                              });
                            },
                            hintText: 'Kata sandi',
                            obscureText: isObscurePass,
                            validator: (value) {
                              return ValidationFormUtil.validatePassword(
                                  value!);
                            },
                          ),
                          SizedBox(
                            height: 0.02.sh,
                          ),
                          WidgetCustom.elevatedButtonCustom(
                            context,
                            textButton: 'Masuk',
                            onPressed: () => _onLogin(),
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
                          'Tidak punya akun? ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              )),
                          child: Text(
                            "Daftar",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
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
                      'Copyright ©️ 2023 TheoDev',
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
      ),
    );
  }

  /// On Register Form
  void _onLogin() {
    if (_formGlobalKey.currentState!.validate()) {
      final data = LoginModel(
        email: _emailField.text,
        password: _passswordField.text,
      );
      BlocProvider.of<AuthBloc>(context).add(
        LoginAccountEvent(loginModel: data),
      );
    }
  }
}
