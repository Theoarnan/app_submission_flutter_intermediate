import 'dart:developer';

import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/routers/page_manager.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/validate_form_util.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/stories_bloc/stories_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class PostStoryPage extends StatefulWidget {
  final Function() toCamera;
  final Function() toHome;
  const PostStoryPage({
    super.key,
    required this.toCamera,
    required this.toHome,
  });

  @override
  State<PostStoryPage> createState() => _PostStoryPageState();
}

class _PostStoryPageState extends State<PostStoryPage> {
  final _formGlobalKey = GlobalKey<FormState>();
  final _descriptionField = TextEditingController();
  XFile? fileImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final blocStories = BlocProvider.of<StoriesBloc>(context);
    final translate = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        titleSpacing: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: IconButton(
            onPressed: () => widget.toHome(),
            iconSize: 24.sp,
            icon: const Icon(
              Icons.arrow_back,
              color: ThemeCustom.darkColor,
            ),
          ),
        ),
        title: Text(
          translate.postStory,
          style: textTheme.labelLarge?.copyWith(fontSize: 24.sp),
        ),
        toolbarHeight: 58.h,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: TextButton(
              onPressed: () =>
                  blocStories.imageFile == null ? null : _onPostStory(),
              child: Text(
                translate.post,
                textAlign: TextAlign.left,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: blocStories.imageFile != null
                      ? ThemeCustom.primaryColor
                      : ThemeCustom.secondaryColor,
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: BlocListener<StoriesBloc, StoriesState>(
          listener: (context, state) async {
            if (state is PostStoriesLoadingState) {
              await WidgetCustom.dialogLoadingState(context);
            } else if (state is PostStoriesSuccessState) {
              await WidgetCustom.toastSuccessPostState(context);
              blocStories.add(GetAllStories());
              widget.toHome();
            } else if (state is NoInternetState) {
              Navigator.pop(context);
              WidgetCustom.toastNoInternetState(context);
            } else if (state is StoriesErrorState) {
              if (UtilHelper.checkUnauthorized(state.error)) {
                BlocProvider.of<AuthBloc>(context)
                    .add(const LogoutAccountEvent());
              } else {
                Navigator.pop(context);
                WidgetCustom.toastErrorState(context, error: state.error);
              }
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 10.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    translate.subtitlePostStory,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: ThemeCustom.secondaryColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: 18.h),
                Center(
                  child: Container(
                    height: 0.3.sh,
                    width: 0.5.sw,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.sp),
                      ),
                    ),
                    child: WidgetCustom.fadeInImageCustom(
                      imageData: context.watch<StoriesBloc>().imageFile,
                      isFile: context.watch<StoriesBloc>().imageFile != null,
                      image: ConstantsName.gifLoadingImg,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Center(
                  child: TextButton(
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
                                    translate.chooseMedia,
                                    style: textTheme.bodyLarge,
                                  ),
                                ),
                                WidgetCustom.listTileCustom(
                                  context,
                                  title: translate.camera,
                                  icon: Icons.photo_camera_rounded,
                                  onTap: () => _onCameraView(),
                                ),
                                WidgetCustom.listTileCustom(
                                  context,
                                  title: translate.gallery,
                                  icon: Icons.photo_rounded,
                                  onTap: () => _onGalleryView(),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      blocStories.imageFile != null
                          ? translate.change
                          : translate.choose_photo,
                      textAlign: TextAlign.left,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ThemeCustom.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                SizedBox(
                  child: Form(
                    key: _formGlobalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translate.description,
                          textAlign: TextAlign.left,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        TextFormField(
                          controller: _descriptionField,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: translate.fieldDescription,
                            hintStyle: textTheme.bodyLarge?.copyWith(
                              color: ThemeCustom.secondaryColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          validator: (value) {
                            return ValidationFormUtil.validateNotNull(
                              context,
                              value,
                              translate.description.toLowerCase(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPostStory() {
    if (_formGlobalKey.currentState!.validate()) {
      final storiesBloc = context.read<StoriesBloc>();
      storiesBloc.add(PostStories(description: _descriptionField.text));
    }
  }

  _onCameraView() async {
    Navigator.pop(context);
    final storiesBloc = BlocProvider.of<StoriesBloc>(context);
    final pageManager = context.read<PageManager>();
    widget.toCamera();
    final resultImageFile = await pageManager.waitForResultImage();
    if (resultImageFile != null) {
      storiesBloc.add(SetImageFile(image: resultImageFile));
    }
  }

  _onGalleryView() async {
    Navigator.of(context).pop();
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
    }
  }
}
