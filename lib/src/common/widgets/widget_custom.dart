import 'package:another_flushbar/flushbar.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetCustom {
  /// FadeInImage Custom
  static FadeInImage fadeInImageCustom({
    bool isUrl = false,
    required String image,
  }) {
    /// Check Network or Asset Image
    ImageProvider<Object> checkUrl() {
      if (isUrl) {
        return NetworkImage(
          image,
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
      fit: BoxFit.cover,
      placeholderFit: BoxFit.cover,
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(
          ConstantsName.gifErrorImg,
        );
      },
    );
  }

  /// Elevated Button
  static ElevatedButton elevatedButtonCustom(
    BuildContext context, {
    required String textButton,
    required void Function()? onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 58.w,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        textButton,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  /// TextFormField
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: 10.h,
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 16.sp,
            ),
            fillColor: ThemeCustom.secondaryColor,
            alignLabelWithHint: true,
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ThemeCustom.redColor,
                style: BorderStyle.solid,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(5.sp),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.sp),
              borderSide: const BorderSide(
                color: ThemeCustom.secondaryColor,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.sp),
              borderSide: const BorderSide(
                color: ThemeCustom.yellowColor,
                width: 2,
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
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ThemeCustom.secondaryColor,
                ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  /// List Tile Custom
  static ListTile listTileCustom(
    BuildContext context, {
    required String title,
    required IconData icon,
    Widget? trailing,
    required void Function() onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w400),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  /// Dialog Loading
  static dialogLoadingState(BuildContext context) {
    return showGeneralDialog(
      context: context,
      useRootNavigator: true,
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
                padding: EdgeInsets.symmetric(vertical: 10.sp).copyWith(
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
                        'Loading',
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

  /// Base toast
  static Future toastState(
    BuildContext context, {
    required IconData iconToast,
    required Color backgroundColor,
    required String titleText,
    required String messageText,
  }) {
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
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Colors.white, fontSize: 18.sp),
      ),
      messageText: Text(
        messageText,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.white, fontSize: 14.sp),
      ),
    ).show(context);
  }

  /// Toast No Internet
  static Future toastNoInternetState(BuildContext context) {
    return WidgetCustom.toastState(
      context,
      iconToast: Icons.warning_rounded,
      backgroundColor: ThemeCustom.redColor,
      titleText: "Oops,",
      messageText: "Kamu tidak terkoneksi internet, coba cek internet mu.",
    );
  }

  /// Toast Register Success
  static Future toastSuccessRegisterState(BuildContext context) {
    return WidgetCustom.toastState(
      context,
      iconToast: Icons.check_circle,
      backgroundColor: ThemeCustom.greenColor,
      titleText: "Yeyy,",
      messageText:
          "Kamu berhasil mendaftarkan akunmu, silahkan melakukan login.",
    );
  }

  /// Toast Post Story Success
  static Future toastSuccessPostState(BuildContext context) {
    return WidgetCustom.toastState(
      context,
      iconToast: Icons.check_circle,
      backgroundColor: ThemeCustom.greenColor,
      titleText: "Yeyy,",
      messageText: "Cerita terbarumu sudah terunggah.",
    );
  }

  /// Toast On Error
  static Future toastErrorState(BuildContext context, {required String error}) {
    return WidgetCustom.toastState(
      context,
      iconToast: Icons.warning_rounded,
      backgroundColor: ThemeCustom.redColor,
      titleText: "Oops,",
      messageText: error,
    );
  }
}
