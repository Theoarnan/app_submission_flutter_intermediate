import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/stories_bloc/stories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: BlocBuilder<StoriesBloc, StoriesState>(
        builder: (context, state) {
          if (state is StoriesLoadingState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator.adaptive(),
                  SizedBox(height: 12.h),
                  Text(
                    'Loading',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            );
          }
          if (state is NoInternetState) {
            return WidgetCustom.stateError(
              context,
              isError: false,
              onPressed: () => BlocProvider.of<StoriesBloc>(context).add(
                GetAllStories(),
              ),
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
                message: 'Kami gagal memuat data detail stories.',
                onPressed: () => BlocProvider.of<StoriesBloc>(context).add(
                  GetAllStories(),
                ),
              );
            }
          }
          if (state is GetDetailStoriesSuccessState) {
            final data = state.dataStories;
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 0.4.sh,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Hero(
                            tag: data.id,
                            child: WidgetCustom.fadeInImageCustom(
                              isUrl: true,
                              image: data.photoUrl,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16.h,
                          left: 16.w,
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<StoriesBloc>(context).add(
                                GetAllStories(),
                              );
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 40.sp,
                              width: 40.sp,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.arrow_back_ios_new,
                                  size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h)
                              .copyWith(top: 8.h),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 18.sp,
                            backgroundColor: ThemeCustom.secondaryColor,
                            child: Text(
                              UtilHelper.generateInitialText(data.name),
                              style: const TextStyle(
                                color: ThemeCustom.darkColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 14.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                UtilHelper.convertToAgo(data.createdAt),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
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
                    SizedBox(
                      height: 4.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'Deskripsi',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: ThemeCustom.darkColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: SizedBox(
                        child: Text(
                          data.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: ThemeCustom.darkColor.withOpacity(0.6),
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}