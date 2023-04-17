import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/models/stories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class WidgetMomentsCustom {
  /// Card Story
  static Widget cardStory(
    BuildContext context, {
    required StoriesModel stories,
  }) {
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
                  backgroundColor: ThemeCustom.secondaryColor,
                  child: Text(
                    UtilHelper.generateInitialText(stories.name),
                    style: const TextStyle(
                      color: ThemeCustom.darkColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stories.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      UtilHelper.convertToAgo(stories.createdAt),
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
                isUrl: true, image: stories.photoUrl.toString()),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${stories.name} ',
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
                    stories.description,
                    trimLines: 2,
                    colorClickableText: ThemeCustom.primaryColor,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Show less',
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
