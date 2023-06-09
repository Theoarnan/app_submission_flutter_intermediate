import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/stories_bloc/stories_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/widgets/widget_moments_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  final Function() toSetting;
  final Function() toPostStory;
  final Function(String) toDetailStory;

  const HomePage({
    super.key,
    required this.toSetting,
    required this.toPostStory,
    required this.toDetailStory,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late StoriesBloc bloc;
  final ScrollController scrollController = ScrollController();

  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Offset> fromBottom;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<StoriesBloc>(context);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (bloc.pageItems != null) {
          bloc.add(const GetAllStories());
        }
      }
    });
    controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..forward();
    animation = UtilHelper.initializeCurvedAnimation(controller);
    fromBottom = UtilHelper.initializePositioned(
      controller,
      isFromBottom: true,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
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
              onPressed: () => widget.toSetting(),
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
          child: FadeTransition(
            opacity: animation,
            child: SizedBox(
              height: 0.88.sh,
              child: BlocBuilder<StoriesBloc, StoriesState>(
                builder: (context, state) {
                  final dataBloc = context.watch<StoriesBloc>();
                  if (state is StoriesLoadingState && dataBloc.pageItems == 1) {
                    return SlideTransition(
                      position: fromBottom,
                      child: Center(
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
                      ),
                    );
                  } else if (state is NoInternetState) {
                    return SlideTransition(
                      position: fromBottom,
                      child: WidgetCustom.stateError(
                        context,
                        isError: false,
                        onPressed: () =>
                            bloc.add(const GetAllStories(isRefresh: true)),
                      ),
                    );
                  } else if (state is StoriesErrorState) {
                    if (UtilHelper.checkUnauthorized(state.error)) {
                      BlocProvider.of<AuthBloc>(context)
                          .add(const LogoutAccountEvent());
                    } else {
                      return SlideTransition(
                        position: fromBottom,
                        child: WidgetCustom.stateError(
                          context,
                          isError: true,
                          message:
                              translate.failed(translate.story.toLowerCase()),
                          onPressed: () => bloc.add(
                            const GetAllStories(isRefresh: true),
                          ),
                        ),
                      );
                    }
                  }
                  final dataState = dataBloc.dataStories;
                  if (dataState.isEmpty) {
                    return SlideTransition(
                      position: fromBottom,
                      child: WidgetCustom.stateError(
                        context,
                        isError: false,
                        isEmpty: true,
                        isWithButton: false,
                      ),
                    );
                  }
                  final itemCountStories = (dataBloc.pageItems != null ? 1 : 0);
                  return RefreshIndicator(
                    onRefresh: () async => bloc.add(
                      const GetAllStories(isRefresh: true),
                    ),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: dataState.length + (itemCountStories),
                      itemBuilder: (context, index) {
                        final isShowLoading = (index == dataState.length &&
                            dataBloc.pageItems != null);
                        if (isShowLoading) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: WidgetCustom.loadingSecond(context),
                            ),
                          );
                        }
                        final dataStories = dataState[index];
                        return GestureDetector(
                          onTap: () => widget.toDetailStory(dataStories.id),
                          child: WidgetMomentsCustom.cardStory(
                            context,
                            stories: dataStories,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: SlideTransition(
        position: fromBottom,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 5,
          child: Image.asset(
            ConstantsName.imgLogo4,
            fit: BoxFit.fill,
            height: 38.h,
          ),
          onPressed: () => widget.toPostStory(),
        ),
      ),
    );
  }
}
