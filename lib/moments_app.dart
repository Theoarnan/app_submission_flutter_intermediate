import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/flavor/flavor_config.dart';
import 'package:app_submission_flutter_intermediate/src/common/routers/page_manager.dart';
import 'package:app_submission_flutter_intermediate/src/common/routers/route_information_parser.dart';
import 'package:app_submission_flutter_intermediate/src/common/routers/router_delegate_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/repository/auth_repository.dart';
import 'package:app_submission_flutter_intermediate/src/features/settings/presentation/bloc/setting_bloc_cubit.dart';
import 'package:app_submission_flutter_intermediate/src/features/settings/presentation/bloc/setting_state_cubit.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/camera_bloc/camera_bloc_cubit.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/stories_bloc/stories_bloc.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/repository/stories_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MomentsApp extends StatefulWidget {
  const MomentsApp({super.key});

  @override
  State<MomentsApp> createState() => _MomentsAppState();
}

class _MomentsAppState extends State<MomentsApp> {
  late RouterDelegateCustom routerDelegateCustom;
  late PageManager pageManager;
  late RouteInformationParserCustom routeInformationParserCustom;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();
    routerDelegateCustom = RouterDelegateCustom(authRepository);
    routeInformationParserCustom = RouteInformationParserCustom();
    pageManager = PageManager();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: AuthRepository(),
          )..add(IsLoggedIn()),
        ),
        BlocProvider(
          create: (context) => StoriesBloc(
            storiesRepository: StoriesRepository(),
          ),
        ),
        BlocProvider(create: (context) => CameraBlocCubit()),
        BlocProvider(create: (context) => SettingBlocCubit()),
        ChangeNotifierProvider<PageManager>(
          create: (context) => pageManager,
        ),
      ],
      child: BlocBuilder<SettingBlocCubit, SettingStateCubit>(
        builder: (context, state) {
          return MaterialApp.router(
            title: FlavorConfig.instance.values.titleApp,
            debugShowCheckedModeBanner: false,
            locale: BlocProvider.of<SettingBlocCubit>(context).locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerDelegate: routerDelegateCustom,
            routeInformationParser: routeInformationParserCustom,
            backButtonDispatcher: RootBackButtonDispatcher(),
            builder: (context, child) {
              ScreenUtil.init(context, minTextAdapt: true);
              return Theme(data: ThemeCustom.themeData(), child: child!);
            },
          );
        },
      ),
    );
  }
}
