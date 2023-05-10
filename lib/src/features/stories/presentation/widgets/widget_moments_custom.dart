import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/models/stories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class WidgetMomentsCustom {
  static Widget cardStory(
    BuildContext context, {
    required StoriesModel stories,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 24.sp,
                  backgroundColor: ThemeCustom.secondaryColor.withOpacity(
                    0.4,
                  ),
                  child: Text(
                    UtilHelper.generateInitialText(stories.name),
                    style: textTheme.bodyLarge,
                  ),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stories.name,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    if (stories.address!.isNotEmpty)
                      SizedBox(
                        width: 1.sw - 100.w,
                        child: Text(
                          stories.address!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: ThemeCustom.primaryColor,
                          ),
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 1.sw,
            height: 0.6.sw,
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            ),
            child: WidgetCustom.fadeInImageCustom(
              isUrl: true,
              image: stories.photoUrl.toString(),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${stories.name} ',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 3.h),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ReadMoreText(
                    stories.description,
                    trimLines: 2,
                    colorClickableText: ThemeCustom.primaryColor,
                    trimMode: TrimMode.Line,
                    trimCollapsedText:
                        ' ${AppLocalizations.of(context)!.showMore}',
                    trimExpandedText:
                        ' ${AppLocalizations.of(context)!.showLess}',
                    lessStyle: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: ThemeCustom.primaryColor,
                    ),
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                    moreStyle: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  UtilHelper.convertToAgo(context, stories.createdAt),
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: ThemeCustom.secondaryColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
