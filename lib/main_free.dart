import 'package:app_submission_flutter_intermediate/moments_app.dart';
import 'package:app_submission_flutter_intermediate/src/common/flavor/flavor_config.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/shared_preference_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/web/url_strategy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  FlavorConfig(
    flavor: FlavorType.free,
    values: const FlavorValues(
      titleApp: "Moments Free",
    ),
  );
  usePathUrlStrategy();
  if (!kIsWeb) {
    await ScreenUtil.ensureScreenSize();
  }
  await SharedPreferencesHelper().init();
  runApp(const MomentsApp());
}
