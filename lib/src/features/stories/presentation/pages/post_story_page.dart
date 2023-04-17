import 'dart:io';

import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/validate_form_util.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/camera_bloc/camera_bloc_cubit.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/stories_bloc/stories_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/pages/camera_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/pages/home_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class PostStoryPage extends StatefulWidget {
  final XFile imagePost;
  final bool isFromCamera;

  const PostStoryPage({
    super.key,
    required this.imagePost,
    required this.isFromCamera,
  });

  @override
  State<PostStoryPage> createState() => _PostStoryPageState();
}

class _PostStoryPageState extends State<PostStoryPage> {
  final _formGlobalKey = GlobalKey<FormState>();
  final _descriptionField = TextEditingController();
  late XFile fileImage;

  @override
  void initState() {
    super.initState();
    fileImage = widget.imagePost;
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(58.h),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              if (widget.isFromCamera) {
                BlocProvider.of<CameraBlocCubit>(context).cameraInitialize();
              } else {
                BlocProvider.of<StoriesBloc>(context).add(GetAllStories());
              }
              Navigator.pop(context);
            },
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
              onPressed: () => _onPostStory(),
              child: Text(
                'Post',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ThemeCustom.primaryColor,
                    ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<StoriesBloc, StoriesState>(
          listener: (context, state) {
            if (state is StoriesLoadingState) {
              WidgetCustom.dialogLoadingState(context);
              Navigator.pop(context);
            } else if (state is NoInternetState) {
              WidgetCustom.toastNoInternetState(context);
            } else if (state is StoriesErrorState) {
              if (UtilHelper.checkUnauthorized(state.error)) {
                BlocProvider.of<AuthBloc>(context)
                    .add(const LogoutAccountEvent());
              } else {
                WidgetCustom.toastErrorState(context, error: state.error);
              }
            } else if (state is PostStoriesSuccessState) {
              BlocProvider.of<StoriesBloc>(context).add(GetAllStories());
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
                (route) => false,
              );
              WidgetCustom.toastSuccessPostState(context);
            } else if (state is GetImageGallerySuccess) {
              fileImage = state.fileImage;
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
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
                        isFile: true,
                        file: File(fileImage.path.toString()),
                        image: widget.imagePost.toString(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
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
                                        'Pilih yang akan digunakan',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                    WidgetCustom.listTileCustom(
                                      context,
                                      title: 'Kamera',
                                      icon: Icons.photo_camera_rounded,
                                      onTap: () => _onCameraView(),
                                    ),
                                    WidgetCustom.listTileCustom(
                                      context,
                                      title: 'Galeri',
                                      icon: Icons.photo_rounded,
                                      onTap: () => _onGalleryView(),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
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
                    child: Form(
                      key: _formGlobalKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Keterangan',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          TextFormField(
                            controller: _descriptionField,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: 'Tulis keterangan...',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: ThemeCustom.secondaryColor,
                                  ),
                            ),
                            validator: (value) =>
                                ValidationFormUtil.validateNotNull(
                              value,
                              'keterangan',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// On Post Story
  void _onPostStory() {
    if (_formGlobalKey.currentState!.validate()) {
      BlocProvider.of<StoriesBloc>(context).add(
        PostStories(
          image: widget.imagePost,
          description: _descriptionField.text,
        ),
      );
    }
  }

  _onCameraView() {
    Navigator.pop(context);
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;
    BlocProvider.of<CameraBlocCubit>(context).cameraInitialize();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CameraPage(),
      ),
    );
  }

  _onGalleryView() async {
    Navigator.pop(context);
    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;
    BlocProvider.of<StoriesBloc>(context).add(SelectImageGallery());
  }
}
