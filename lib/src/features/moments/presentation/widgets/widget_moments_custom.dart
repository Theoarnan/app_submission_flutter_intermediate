import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class WidgetMomentsCustom {
  /// Card Story
  static Widget cardStory(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h)
                .copyWith(top: 8.h),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 18.sp,
                  backgroundImage: AssetImage(ConstantsName.imgLogo1),
                ),
                SizedBox(width: 14.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wawan Supriyatna',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      '${20} minutes ago',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 10.sp,
                            color: ThemeCustom.secondaryColor,
                          ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 1.sw,
            height: 1.sw,
            child: WidgetCustom.fadeInImageCustom(
                isUrl: true,
                image:
                    'https://images.unsplash.com/photo-1498598457418-36ef20772bb9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wawan Supriyatna ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ReadMoreText(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce luctus sem eget tincidunt aliquet. Aenean nec lorem id felis gravida commodo. Nulla eget cursus felis, eu congue ipsum. Nunc faucibus.',
                    trimLines: 2,
                    colorClickableText: ThemeCustom.primaryColor,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    lessStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: ThemeCustom.primaryColor,
                        ),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                    moreStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
