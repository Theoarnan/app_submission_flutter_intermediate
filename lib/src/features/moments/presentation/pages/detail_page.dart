import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.h),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 0.4.sh,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Hero(
                      tag: 'sjasajds',
                      child: WidgetCustom.fadeInImageCustom(
                        isUrl: true,
                        image:
                            'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16.h,
                    left: 16.w,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.maybePop(context);
                      },
                      child: Container(
                        height: 40.sp,
                        width: 40.sp,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
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
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          '${20} minutes ago',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SizedBox(
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur tempus eros nec imperdiet molestie. Nulla ultricies nisl nibh, id iaculis risus mattis vitae. Praesent mollis maximus posuere. Fusce ligula leo, ullamcorper fermentum enim eu, fringilla scelerisque dui. Ut quis sapien arcu. Aliquam ut quam vel nunc posuere porta. Vestibulum ut vestibulum dolor, at maximus urna. Morbi eget lectus sit amet nibh accumsan ornare. Nulla enim odio, pulvinar vel cursus et, lobortis at nibh. Nulla facilisi. Nulla ex turpis, tempus a.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ThemeCustom.darkColor.withOpacity(0.6),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
