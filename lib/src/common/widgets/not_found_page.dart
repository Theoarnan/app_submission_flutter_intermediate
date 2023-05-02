import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ConstantsName.gifNotFoundIlustrationImg,
              ),
              Text(
                translate.notFound,
                style: textTheme.labelLarge?.copyWith(
                  fontSize: 22.sp,
                ),
              ),
              Text(
                translate.subtitleNotFound,
                style: textTheme.labelMedium?.copyWith(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              WidgetCustom.elevatedButtonCustom(
                context,
                textButton: translate.back,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
