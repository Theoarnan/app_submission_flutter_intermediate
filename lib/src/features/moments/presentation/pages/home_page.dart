import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/moments/presentation/widgets/widget_moments_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(58.h),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Image.asset(
            ConstantsName.imgLogo3,
            height: 38.h,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                color: ThemeCustom.darkColor,
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 0.88.sh,
            child: ListView.separated(
              itemCount: 5,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return WidgetMomentsCustom.cardStory(context);
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 244, 244, 244),
        elevation: 2,
        child: Image.asset(
          ConstantsName.imgLogo4,
          fit: BoxFit.fill,
          width: 40.w,
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 20.h,
                        ),
                        child: Text(
                          'Pilih yang akan digunakan',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      WidgetCustom.listTileCustom(
                        context,
                        title: 'Kamera',
                        icon: Icons.photo_camera_rounded,
                        onTap: () => Navigator.pop(context),
                      ),
                      WidgetCustom.listTileCustom(
                        context,
                        title: 'Galeri',
                        icon: Icons.photo_rounded,
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
