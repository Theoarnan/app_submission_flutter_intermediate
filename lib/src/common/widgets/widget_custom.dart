import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetCustom {
  static FadeInImage fadeInImageCustom({
    bool isUrl = false,
    bool isFile = false,
    File? file,
    required String image,
  }) {
    ImageProvider<Object> checkUrl() {
      if (isUrl) {
        return NetworkImage(
          image,
        );
      }
      if (isFile) {
        return FileImage(
          file!,
        );
      }
      return AssetImage(
        image,
      );
    }

    return FadeInImage(
      image: checkUrl(),
      placeholder: AssetImage(
        ConstantsName.gifLoadingImg,
      ),
      filterQuality: FilterQuality.high,
      fit: BoxFit.cover,
      placeholderFit: BoxFit.cover,
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(
          ConstantsName.gifErrorImg,
          filterQuality: FilterQuality.high,
        );
      },
    );
  }

  static ElevatedButton elevatedButtonCustom(
    BuildContext context, {
    required String textButton,
    required void Function()? onPressed,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 54.w,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        textButton,
        style: textTheme.bodyMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget textFormField(
    BuildContext context, {
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Icon? suffixIcon,
    void Function()? onTapSuffixIcon,
    Icon? prefixIcon,
    required String hintText,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 0.h,
              horizontal: 16.sp,
            ),
            fillColor: ThemeCustom.secondaryColor,
            alignLabelWithHint: true,
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ThemeCustom.redColor,
                style: BorderStyle.solid,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5.sp),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.sp),
              borderSide: const BorderSide(
                color: ThemeCustom.secondaryColor,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.sp),
              borderSide: const BorderSide(
                color: ThemeCustom.yellowColor,
                width: 1,
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: prefixIcon,
            suffixIcon: IconButton(
              onPressed: onTapSuffixIcon,
              color: ThemeCustom.primaryColor,
              icon: suffixIcon ?? const SizedBox.shrink(),
            ),
            hintText: hintText,
            hintStyle: textTheme.bodyMedium?.copyWith(
              color: ThemeCustom.secondaryColor,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  static ListTile listTileCustom(
    BuildContext context, {
    required String title,
    required IconData icon,
    Widget? trailing,
    required void Function() onTap,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 10.h,
      ),
      leading: Icon(icon),
      title: Text(
        title,
        style: textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  static ExpansionTile expansionListLite(
    BuildContext context, {
    required String title,
    required IconData icon,
    Widget? trailing,
    required List<Widget> children,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 10.h,
      ),
      leading: Icon(icon),
      title: Text(
        title,
        style: textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w400,
        ),
      ),
      childrenPadding: EdgeInsets.only(left: 16.w),
      children: children,
    );
  }

  static dialogLoadingState(BuildContext context) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, __, ___) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                ).copyWith(
                  top: 12.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                width: 74.w,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const CircularProgressIndicator.adaptive(),
                      SizedBox(height: 12.h),
                      Text(
                        AppLocalizations.of(context)!.loading,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static Future toastState(
    BuildContext context, {
    required IconData iconToast,
    required Color backgroundColor,
    required String titleText,
    required String messageText,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Flushbar(
      isDismissible: true,
      flushbarStyle: FlushbarStyle.GROUNDED,
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 3),
      icon: Icon(
        iconToast,
        color: Colors.white,
      ),
      backgroundColor: backgroundColor,
      titleText: Text(
        titleText,
        style: textTheme.bodyLarge?.copyWith(
          color: Colors.white,
          fontSize: 18.sp,
        ),
      ),
      messageText: Text(
        messageText,
        style: textTheme.bodyMedium?.copyWith(
          color: Colors.white,
          fontSize: 14.sp,
        ),
      ),
    ).show(context);
  }

  static Future toastNoInternetState(BuildContext context) {
    return WidgetCustom.toastState(
      context,
      iconToast: Icons.warning_rounded,
      backgroundColor: ThemeCustom.redColor,
      titleText: AppLocalizations.of(context)!.oops,
      messageText: AppLocalizations.of(context)!.noConnectionAlert,
    );
  }

  static Future toastSuccessRegisterState(BuildContext context) {
    return WidgetCustom.toastState(
      context,
      iconToast: Icons.check_circle,
      backgroundColor: ThemeCustom.greenColor,
      titleText: AppLocalizations.of(context)!.yey,
      messageText: AppLocalizations.of(context)!.successRegistration,
    );
  }

  static Future toastSuccessPostState(BuildContext context) {
    return WidgetCustom.toastState(
      context,
      iconToast: Icons.check_circle,
      backgroundColor: ThemeCustom.greenColor,
      titleText: AppLocalizations.of(context)!.yey,
      messageText: AppLocalizations.of(context)!.successPostStory,
    );
  }

  static Future toastErrorState(BuildContext context, {required String error}) {
    return WidgetCustom.toastState(
      context,
      iconToast: Icons.warning_rounded,
      backgroundColor: ThemeCustom.redColor,
      titleText: AppLocalizations.of(context)!.oops,
      messageText: error,
    );
  }

  static Widget stateError(
    BuildContext context, {
    bool isError = true,
    String? message,
    required void Function()? onPressed,
  }) {
    final translate = AppLocalizations.of(context)!;
    final ilustrationImg = isError
        ? ConstantsName.gifErrorIlustrationImg
        : ConstantsName.gifNoConnectionImg;
    final title = isError ? translate.sorry : translate.oops;
    final messageText = isError ? message : translate.noConnectionDialog;
    return Center(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ilustrationImg,
              fit: BoxFit.fill,
              height: 0.5.sh,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(
              width: 0.8.sw,
              child: Text(
                messageText ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            WidgetCustom.elevatedButtonCustom(
              context,
              textButton: translate.tryAgain,
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }
}
