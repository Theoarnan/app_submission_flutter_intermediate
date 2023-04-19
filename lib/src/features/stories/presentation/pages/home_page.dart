import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/settings/presentation/pages/setting_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/camera_bloc/camera_bloc_cubit.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/stories_bloc/stories_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/pages/camera_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/pages/detail_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/pages/post_story_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/widgets/widget_moments_custom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StoriesBloc>(context).add(GetAllStories());
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final bloc = BlocProvider.of<StoriesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 58.h,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: SizedBox(
            height: 38.h,
            child: Image.asset(
              ConstantsName.imgLogo3,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingPage(),
                  ),
                );
              },
              iconSize: 24.sp,
              icon: const Icon(
                Icons.settings,
                color: ThemeCustom.darkColor,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 0.88.sh,
            child: BlocConsumer<StoriesBloc, StoriesState>(
              listener: (context, state) {
                if (state is GetImageGallerySuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostStoryPage(
                        imagePost: state.fileImage,
                        isFromCamera: false,
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is StoriesLoadingState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator.adaptive(),
                        SizedBox(height: 12.h),
                        Text(
                          translate.loading,
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  );
                }
                if (state is NoInternetState) {
                  return WidgetCustom.stateError(
                    context,
                    isError: false,
                    onPressed: () => bloc.add(GetAllStories()),
                  );
                }
                if (state is StoriesErrorState) {
                  if (UtilHelper.checkUnauthorized(state.error)) {
                    BlocProvider.of<AuthBloc>(context)
                        .add(const LogoutAccountEvent());
                  } else {
                    return WidgetCustom.stateError(
                      context,
                      isError: true,
                      message: translate.failed('stories'),
                      onPressed: () => bloc.add(GetAllStories()),
                    );
                  }
                }
                if (state is GetAllStoriesSuccessState) {
                  return ListView.separated(
                    itemCount: state.dataStories.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final data = state.dataStories[index];
                      return GestureDetector(
                        onTap: () {
                          bloc.add(GetDetailStories(id: data.id));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(),
                            ),
                          );
                        },
                        child: WidgetMomentsCustom.cardStory(
                          context,
                          stories: data,
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 5,
        child: Image.asset(
          ConstantsName.imgLogo4,
          fit: BoxFit.fill,
          height: 38.h,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
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
                      style: Theme.of(context).textTheme.bodyLarge,
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
              );
            },
          );
        },
      ),
    );
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
    BlocProvider.of<StoriesBloc>(context).add(GetAllStories());
  }
}
