import 'dart:developer';

import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/repository/auth_repository.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/camera_bloc/camera_bloc_cubit.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/stories_bloc/stories_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/pages/home_page.dart';
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
        BlocProvider(
          create: (context) => CameraBlocCubit(),
        )
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) => log('Test state auth: $state'),
        child: MaterialApp(
          title: 'Moments',
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            ScreenUtil.init(context);
            return Theme(
              data: ThemeCustom.themeData(),
              child: child!,
            );
          },
          home: const HomePage(),
        ),
      ),
    );
  }
}
