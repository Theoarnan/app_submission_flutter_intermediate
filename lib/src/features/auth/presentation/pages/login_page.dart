import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/validate_form_util.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/models/login/login_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  final Function() onRegister;
  const LoginPage({
    super.key,
    required this.onRegister,
  });
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formGlobalKey = GlobalKey<FormState>();
  final _emailField = TextEditingController();
  final _passswordField = TextEditingController();

  bool isObscurePass = true;
  bool isValueAnimated = false;

  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Offset> fromTop;
  late Animation<Offset> fromLeft;
  late Animation<Offset> fromBottom;

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
    fromBottom = UtilHelper.initializePositioned(
      controller,
      isFromBottom: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _emailField.dispose();
    _passswordField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            WidgetCustom.toastErrorState(context, error: state.error);
          }
        },
        builder: (context, state) {
          final stateLoading = state is AuthLoadingState;
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 10.h,
              ),
              child: SizedBox(
                height: size.height - 44,
                child: FadeTransition(
                  opacity: animation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SlideTransition(
                          position: fromTop,
                          child: Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              ConstantsName.imgLogo2,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SlideTransition(
                          position: fromLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                translate.welcome,
                                style: textTheme.labelLarge?.copyWith(
                                  fontSize: 28.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                translate.subtitleLogin,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: ThemeCustom.secondaryColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: SlideTransition(
                          position: fromLeft,
                          child: SizedBox(
                            child: Form(
                              key: _formGlobalKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  WidgetCustom.textFormField(
                                    context,
                                    controller: _emailField,
                                    hintText: translate.email,
                                    validator: (value) {
                                      return ValidationFormUtil.validateEmail(
                                        context,
                                        value!,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 12.h),
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
                                    hintText: translate.password,
                                    obscureText: isObscurePass,
                                    validator: (value) {
                                      return ValidationFormUtil.validateNotNull(
                                        context,
                                        value!,
                                        translate.password.toLowerCase(),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 12.h),
                                  Center(
                                    child: stateLoading
                                        ? Padding(
                                            padding: EdgeInsets.all(12.sp),
                                            child: WidgetCustom.loadingSecond(
                                                context))
                                        : WidgetCustom.elevatedButtonCustom(
                                            context,
                                            textButton: translate.login,
                                            onPressed: () => _onLogin(),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: SlideTransition(
                          position: fromBottom,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                translate.dontHaveAccount,
                                style: textTheme.bodyMedium,
                              ),
                              GestureDetector(
                                onTap: () => widget.onRegister(),
                                child: Text(
                                  translate.register,
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: ThemeCustom.yellowColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: SlideTransition(
                          position: fromBottom,
                          child: Text(
                            translate.copyright,
                            style: textTheme.bodySmall?.copyWith(
                              color: ThemeCustom.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onLogin() {
    if (_formGlobalKey.currentState!.validate()) {
      final data = LoginModel(
        email: _emailField.text,
        password: _passswordField.text,
      );
      final blocAuth = context.read<AuthBloc>();
      blocAuth.add(LoginAccountEvent(loginModel: data));
    }
  }
}
