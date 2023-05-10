import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/routers/page_manager.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/validate_form_util.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/stories_bloc/stories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class PostStoryPage extends StatefulWidget {
  final Function() toCamera;
  final Function() toHome;
  final Function() onCloseMedia;
  final Function() toChooseMedia;
  final Function() toChooseLocation;
  const PostStoryPage({
    super.key,
    required this.toCamera,
    required this.toHome,
    required this.toChooseMedia,
    required this.onCloseMedia,
    required this.toChooseLocation,
  });

  @override
  State<PostStoryPage> createState() => _PostStoryPageState();
}

class _PostStoryPageState extends State<PostStoryPage>
    with SingleTickerProviderStateMixin {
  final _formGlobalKey = GlobalKey<FormState>();
  final _descriptionField = TextEditingController();
  late StoriesBloc blocStories;
  XFile? fileImage;
  String? address;
  LatLng? location;

  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Offset> fromTop;
  late Animation<Offset> fromLeft;

  @override
  void initState() {
    super.initState();
    blocStories = BlocProvider.of<StoriesBloc>(context);
    controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..forward();
    animation = UtilHelper.initializeCurvedAnimation(controller);
    fromTop = UtilHelper.initializePositioned(controller, isFromTop: true);
    fromLeft = UtilHelper.initializePositioned(controller, isFromLeft: true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _descriptionField.dispose();
  }

  bool get isProccesPostStories =>
      location != null && blocStories.imageFile != null;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final translate = AppLocalizations.of(context)!;
    return BlocConsumer<StoriesBloc, StoriesState>(
      listener: (context, state) async {
        if (state is PostStoriesSuccessState) {
          await WidgetCustom.toastSuccessPostState(context);
          blocStories.add(const GetAllStories(isRefresh: true));
          widget.toHome();
        } else if (state is NoInternetState) {
          WidgetCustom.toastNoInternetState(context);
        } else if (state is StoriesErrorState) {
          if (UtilHelper.checkUnauthorized(state.error)) {
            BlocProvider.of<AuthBloc>(context).add(const LogoutAccountEvent());
          } else {
            WidgetCustom.toastErrorState(context, error: state.error);
          }
        } else if (state is SetLocationSuccess) {
          address = state.address;
          location = state.location;
        } else if (state is SetImageSuccess) {
          fileImage = state.fileImage;
        }
      },
      builder: (context, state) {
        final postStoryLoading = state is PostStoriesLoadingState;
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
                  onPressed: () => _handlePostStories(),
                  child: onPostButton(postStoryLoading, translate, textTheme),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: FadeTransition(
              opacity: animation,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    SlideTransition(
                      position: fromTop,
                      child: Center(
                        child: Text(
                          translate.subtitlePostStory,
                          textAlign: TextAlign.center,
                          style: textTheme.bodyMedium?.copyWith(
                            color: ThemeCustom.secondaryColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    SlideTransition(
                      position: fromTop,
                      child: Center(
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
                            imageData: fileImage,
                            isFile: fileImage != null,
                            image: ConstantsName.gifLoadingImg,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    SlideTransition(
                      position: fromTop,
                      child: Center(
                        child: TextButton(
                          onPressed: () => widget.toChooseMedia(),
                          child: Text(
                            (fileImage != null)
                                ? translate.change
                                : translate.choosePhoto,
                            textAlign: TextAlign.left,
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ThemeCustom.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    SlideTransition(
                      position: fromLeft,
                      child: SizedBox(
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
                    ),
                    SizedBox(height: 6.h),
                    if (location == null)
                      SlideTransition(
                        position: fromLeft,
                        child: TextButton(
                          onPressed: () async {
                            final pageManager = context.read<PageManager>();
                            widget.toChooseLocation();
                            final resultLocation =
                                await pageManager.waitForResultLocation();
                            if (resultLocation != null) {
                              blocStories.add(
                                SetLocationData(location: resultLocation),
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20.sp,
                                color: ThemeCustom.primaryColor,
                              ),
                              SizedBox(width: 8.w),
                              SizedBox(
                                width: 1.sw - 100.w,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      translate.addLocation,
                                      style: textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: ThemeCustom.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 6.h),
                    if (location != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8.w)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 12,
                              offset: Offset.zero,
                              color:
                                  ThemeCustom.secondaryColor.withOpacity(0.5),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 24.sp,
                              color: ThemeCustom.primaryColor,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                address ?? '-',
                                style: textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                blocStories.add(
                                  const SetLocationData(location: null),
                                );
                              },
                              icon: const Icon(
                                Icons.remove_circle,
                                color: ThemeCustom.redColor,
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onPostStories() {
    if (_formGlobalKey.currentState!.validate()) {
      final storiesBloc = context.read<StoriesBloc>();
      storiesBloc.add(PostStories(description: _descriptionField.text));
    }
  }

  _handlePostStories() {
    if (isProccesPostStories) {
      return _onPostStories();
    }
    return null;
  }

  Widget onPostButton(
    bool postStoryLoading,
    AppLocalizations translate,
    TextTheme textTheme,
  ) {
    if (postStoryLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 14.h,
            width: 14.w,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            translate.loading,
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }
    return Text(
      translate.post,
      textAlign: TextAlign.left,
      style: textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: (isProccesPostStories)
            ? ThemeCustom.primaryColor
            : ThemeCustom.secondaryColor,
      ),
    );
  }
}
