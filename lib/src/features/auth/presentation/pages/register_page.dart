import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/validate_form_util.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/models/register/register_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatefulWidget {
  final Function() onBackLogin;
  const RegisterPage({
    super.key,
    required this.onBackLogin,
  });
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final _formGlobalKey = GlobalKey<FormState>();
  final _nameField = TextEditingController();
  final _emailField = TextEditingController();
  final _passswordField = TextEditingController();
  final _passswordConfirmField = TextEditingController();

  bool isObscurePass = true;
  bool isObscureConfirmPass = true;

  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Offset> fromTop;
  late Animation<Offset> fromLeft;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 600),
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
    _nameField.dispose();
    _emailField.dispose();
    _passswordField.dispose();
    _passswordConfirmField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        titleSpacing: 0,
        automaticallyImplyLeading: true,
        leading: Container(
          margin: EdgeInsets.only(left: 16.w),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => widget.onBackLogin(),
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
            translate.register,
            style: textTheme.labelLarge?.copyWith(
              fontSize: 24.sp,
            ),
          ),
        ),
        toolbarHeight: 58.h,
        centerTitle: true,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is RegisterSuccessState) {
            _nameField.clear();
            _emailField.clear();
            _passswordField.clear();
            _passswordConfirmField.clear();
            await WidgetCustom.toastSuccessRegisterState(context);
            widget.onBackLogin();
          }
        },
        builder: (context, state) {
          final stateLoading = state is AuthLoadingState;
          return SafeArea(
            child: FadeTransition(
              opacity: animation,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
                child: SizedBox(
                  height: 0.93.sh,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SlideTransition(
                        position: fromTop,
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 2.h),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                translate.subtitleRegister,
                                textAlign: TextAlign.center,
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
                        child: SlideTransition(
                          position: fromLeft,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 0.02.sh),
                            child: Form(
                              key: _formGlobalKey,
                              child: Column(
                                children: [
                                  WidgetCustom.textFormField(
                                    context,
                                    controller: _nameField,
                                    hintText: translate.name,
                                    validator: (value) {
                                      return ValidationFormUtil.validateNotNull(
                                        context,
                                        value,
                                        translate.name.toLowerCase(),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 0.02.sh,
                                  ),
                                  WidgetCustom.textFormField(
                                    context,
                                    controller: _emailField,
                                    keyboardType: TextInputType.emailAddress,
                                    hintText: translate.email,
                                    validator: (value) {
                                      return ValidationFormUtil.validateEmail(
                                        context,
                                        value!,
                                      );
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
                                    hintText: translate.password,
                                    obscureText: isObscurePass,
                                    validator: (value) {
                                      return ValidationFormUtil
                                          .validatePassword(
                                        context,
                                        value!,
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 0.02.sh,
                                  ),
                                  WidgetCustom.textFormField(
                                    context,
                                    controller: _passswordConfirmField,
                                    suffixIcon: Icon(
                                      isObscureConfirmPass
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onTapSuffixIcon: () {
                                      setState(() {
                                        isObscureConfirmPass =
                                            !isObscureConfirmPass;
                                      });
                                    },
                                    hintText: translate.confirm_password,
                                    obscureText: isObscureConfirmPass,
                                    validator: (value) {
                                      if (_passswordField.text == value) {
                                        return ValidationFormUtil
                                            .validatePassword(
                                          context,
                                          value!,
                                        );
                                      } else {
                                        return translate
                                            .validateConfirmPassword;
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 0.04.sh,
                                  ),
                                  AnimatedCrossFade(
                                    alignment: Alignment.center,
                                    sizeCurve: Curves.easeInToLinear,
                                    duration: const Duration(milliseconds: 160),
                                    crossFadeState: stateLoading
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                    firstChild:
                                        WidgetCustom.elevatedButtonCustom(
                                      context,
                                      textButton: translate.register,
                                      onPressed: () => _onRegister(),
                                    ),
                                    secondChild: Padding(
                                      padding: EdgeInsets.all(12.sp),
                                      child:
                                          WidgetCustom.loadingSecond(context),
                                    ),
                                  ),
                                ],
                              ),
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

  /// On Register Form
  void _onRegister() {
    if (_formGlobalKey.currentState!.validate()) {
      final data = RegisterModel(
        name: _nameField.text,
        email: _emailField.text,
        password: _passswordConfirmField.text,
      );
      final blocAuth = context.read<AuthBloc>();
      blocAuth.add(RegisterAccountEvent(registerModel: data));
    }
  }
}
