import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostStoryPage extends StatefulWidget {
  const PostStoryPage({super.key});

  @override
  State<PostStoryPage> createState() => _PostStoryPageState();
}

class _PostStoryPageState extends State<PostStoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(58.h),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: ThemeCustom.darkColor,
            ),
          ),
          title: Text(
            'Post Cerita',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 24.sp,
                ),
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  'Post',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ThemeCustom.primaryColor,
                      ),
                ))
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 10.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 14.h,
              ),
              Text(
                'Silahkan masukkan keterangan tentang perasaan untuk unggahan cerita anda',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ThemeCustom.secondaryColor,
                      fontWeight: FontWeight.normal,
                    ),
              ),
              SizedBox(
                height: 18.h,
              ),
              Center(
                child: Container(
                  height: 0.3.sh,
                  width: 0.5.sw,
                  padding: const EdgeInsets.all(2),
                  color: Colors.grey,
                  child: WidgetCustom.fadeInImageCustom(
                    image: ConstantsName.gifErrorImg,
                  ),
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Ganti',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ThemeCustom.primaryColor,
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Keterangan',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    TextFormField(
                      controller: TextEditingController(),
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Tulis keterangan...',
                        hintStyle:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: ThemeCustom.secondaryColor,
                                ),
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                    const Divider()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
