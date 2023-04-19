import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/validate_form_util.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/models/register/register_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formGlobalKey = GlobalKey<FormState>();
  final _nameField = TextEditingController();
  final _emailField = TextEditingController();
  final _passswordField = TextEditingController();
  final _passswordConfirmField = TextEditingController();

  bool isObscurePass = true;
  bool isObscureConfirmPass = true;

  @override
  void dispose() {
    super.dispose();
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
          translate.register,
          style: textTheme.labelLarge?.copyWith(
            fontSize: 24.sp,
          ),
        ),
        toolbarHeight: 58.h,
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            WidgetCustom.dialogLoadingState(context);
            Navigator.of(context).pop();
          } else if (state is RegisterSuccessState) {
            Navigator.of(context)
              ..pop()
              ..pop();
            WidgetCustom.toastSuccessRegisterState(context);
          } else if (state is AuthErrorState) {
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
              height: 0.93.sh,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                  Expanded(
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
                                return ValidationFormUtil.validatePassword(
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
                                  isObscureConfirmPass = !isObscureConfirmPass;
                                });
                              },
                              hintText: translate.confirm_password,
                              obscureText: isObscureConfirmPass,
                              validator: (value) {
                                if (_passswordField.text == value) {
                                  return ValidationFormUtil.validatePassword(
                                    context,
                                    value!,
                                  );
                                } else {
                                  return translate.validateConfirmPassword;
                                }
                              },
                            ),
                            SizedBox(
                              height: 0.04.sh,
                            ),
                            WidgetCustom.elevatedButtonCustom(
                              context,
                              textButton: translate.register,
                              onPressed: () => _onRegister(),
                            ),
                          ],
                        ),
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
  void _onRegister() {
    if (_formGlobalKey.currentState!.validate()) {
      final data = RegisterModel(
        name: _nameField.text,
        email: _emailField.text,
        password: _passswordConfirmField.text,
      );
      BlocProvider.of<AuthBloc>(context).add(
        RegisterAccountEvent(registerModel: data),
      );
    }
  }
}
