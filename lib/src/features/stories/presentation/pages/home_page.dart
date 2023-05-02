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

class _HomePageState extends State<HomePage> {
  late StoriesBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<StoriesBloc>(context);
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
          child: SizedBox(
            height: 0.88.sh,
            child: BlocBuilder<StoriesBloc, StoriesState>(
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
                      message: translate.failed(translate.story.toLowerCase()),
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
                        onTap: () => widget.toDetailStory(data.id),
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
        onPressed: () => widget.toPostStory(),
      ),
    );
  }
}
