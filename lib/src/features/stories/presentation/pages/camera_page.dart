import 'package:app_submission_flutter_intermediate/src/common/constants/export_localization.dart';
import 'package:app_submission_flutter_intermediate/src/common/constants/theme/theme_custom.dart';
import 'package:app_submission_flutter_intermediate/src/common/routers/page_manager.dart';
import 'package:app_submission_flutter_intermediate/src/common/widgets/widget_custom.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/camera_bloc/camera_bloc_cubit.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/camera_bloc/camera_state_cubit.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CameraPage extends StatefulWidget {
  final Function() toBackPostStory;
  const CameraPage({
    super.key,
    required this.toBackPostStory,
  });
  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    context.read<CameraBlocCubit>().cameraInitialize();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final bloc = BlocProvider.of<CameraBlocCubit>(context);
    if (!bloc.isInitialized()) return;
    if (state == AppLifecycleState.inactive) {
      bloc.cameraStopped();
    } else if (state == AppLifecycleState.resumed) {
      bloc.cameraInitialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final bloc = BlocProvider.of<CameraBlocCubit>(context);
    return BlocConsumer<CameraBlocCubit, CameraStateCubit>(
      listener: (context, state) {
        if (state is CameraCaptureSuccess) {
          context.read<PageManager>().returnDataImage(state.image);
          bloc.cameraStopped();
          widget.toBackPostStory();
        } else if (state is CameraCaptureFailure) {
          WidgetCustom.toastErrorState(context, error: state.error);
        }
      },
      builder: (context, state) {
        return Theme(
          data: ThemeData.dark(),
          child: Scaffold(
            appBar: AppBar(
              title: Text(translate.takePicture),
              centerTitle: true,
              leading: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: IconButton(
                  onPressed: () {
                    bloc.cameraStopped();
                    widget.toBackPostStory();
                  },
                  iconSize: 24.sp,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => _onCameraSwitch(),
                  icon: const Icon(Icons.cameraswitch),
                ),
              ],
            ),
            body: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  state is CameraReady
                      ? CameraPreview(bloc.getController()!)
                      : state is CameraFailure
                          ? Column(children: [Text(state.error)])
                          : const Center(child: CircularProgressIndicator()),
                  Align(
                    alignment: const Alignment(0, 0.95),
                    child: state is CameraReady
                        ? _actionWidget(context)
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _actionWidget(BuildContext context) {
    final bloc = BlocProvider.of<CameraBlocCubit>(context);
    return FloatingActionButton(
      backgroundColor: ThemeCustom.primaryColor,
      tooltip: AppLocalizations.of(context)!.takePicture,
      onPressed: () => bloc.cameraCapture(),
      child: const Icon(
        Icons.camera_alt,
        color: Colors.white,
      ),
    );
  }

  void _onCameraSwitch() {
    BlocProvider.of<CameraBlocCubit>(context).switchCamera();
  }
}
