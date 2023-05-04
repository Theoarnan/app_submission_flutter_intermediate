import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/routers/page_manager.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/stories_bloc/stories_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ChooseMedia extends Page {
  final Function() onCloseChoose;
  final Function() toCamera;
  const ChooseMedia({
    required this.onCloseChoose,
    required this.toCamera,
  }) : super(key: const ValueKey('ChooseMedia'));

  @override
  Route createRoute(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    onCameraView() async {
      final storiesBloc = BlocProvider.of<StoriesBloc>(context);
      final pageManager = context.read<PageManager>();
      toCamera();
      final resultImageFile = await pageManager.waitForResultImage();
      if (resultImageFile != null) {
        storiesBloc.add(SetImageFile(image: resultImageFile));
        onCloseChoose();
      }
    }

    onGalleryView() async {
      final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
      final isLinux = defaultTargetPlatform == TargetPlatform.linux;
      if (isMacOS || isLinux) return;
      final storiesBloc = BlocProvider.of<StoriesBloc>(context);
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        storiesBloc.add(SetImageFile(image: pickedFile));
        onCloseChoose();
      }
    }

    return DialogRoute(
      settings: this,
      barrierDismissible: false,
      barrierColor: Colors.black87,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 20.h,
                      ),
                      child: Row(
                        children: [
                          Text(
                            translate.chooseMedia,
                            style: textTheme.bodyLarge,
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => onCloseChoose(),
                            child: Text(
                              'Tutup',
                              style: textTheme.bodyMedium?.copyWith(
                                color: ThemeCustom.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    WidgetCustom.listTileCustom(
                      context,
                      title: translate.camera,
                      icon: Icons.photo_camera_rounded,
                      onTap: () => onCameraView(),
                    ),
                    WidgetCustom.listTileCustom(
                      context,
                      title: translate.gallery,
                      icon: Icons.photo_rounded,
                      onTap: () => onGalleryView(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      context: context,
    );
  }
}
