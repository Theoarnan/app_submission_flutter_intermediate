import 'dart:developer';

import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/pages/splash_page.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/repository/auth_repository.dart';
import 'package:app_submission_flutter_intermediate/src/features/settings/presentation/bloc/setting_bloc_cubit.dart';
import 'package:app_submission_flutter_intermediate/src/features/settings/presentation/bloc/setting_state_cubit.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/camera_bloc/camera_bloc_cubit.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/stories_bloc/stories_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/repository/stories_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  // usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: AuthRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => StoriesBloc(
            storiesRepository: StoriesRepository(),
          ),
        ),
        BlocProvider(create: (context) => CameraBlocCubit()),
        BlocProvider(create: (context) => SettingBlocCubit()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) => log('Test state auth: $state'),
        child: BlocBuilder<SettingBlocCubit, SettingStateCubit>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Moments',
              debugShowCheckedModeBanner: false,
              locale: BlocProvider.of<SettingBlocCubit>(context).locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              builder: (context, child) {
                ScreenUtil.init(context);
                return Theme(
                  data: ThemeCustom.themeData(),
                  child: child!,
                );
              },
              home: const SplashPage(),
            );
          },
        ),
      ),
    );
  }
}
