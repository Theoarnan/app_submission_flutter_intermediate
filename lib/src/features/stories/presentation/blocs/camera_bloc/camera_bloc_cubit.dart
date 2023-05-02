import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/presentation/blocs/camera_bloc/camera_state_cubit.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraBlocCubit extends Cubit<CameraStateCubit> {
  final ResolutionPreset resolutionPreset;
  CameraLensDirection cameraLensDirection;

  CameraBlocCubit({
    this.resolutionPreset = ResolutionPreset.max,
    this.cameraLensDirection = CameraLensDirection.front,
  }) : super(CameraInitial());

  CameraController? _controller;
  CameraController? getController() => _controller;
  bool isInitialized() => _controller?.value.isInitialized ?? false;

  void cameraInitialize() async {
    try {
      final previousCameraController = _controller;
      _controller = await UtilHelper.getCameraController(
        resolutionPreset,
      );
      await previousCameraController?.dispose();
      await _controller!.initialize();
      emit(CameraReady());
    } on CameraException catch (error) {
      _controller?.dispose();
      emit(CameraFailure(error: error.description.toString()));
    } catch (error) {
      emit(CameraFailure(error: error.toString()));
    }
  }

  void cameraCapture() async {
    if (state is CameraReady) {
      emit(CameraCaptureInProgress());
      try {
        final image = await _controller?.takePicture();
        emit(CameraCaptureSuccess(image: image ?? XFile('')));
      } on CameraException catch (error) {
        emit(CameraCaptureFailure(error: error.description ?? ''));
      }
    }
  }

  void switchCamera() async {
    cameraLensDirection =
        (_controller!.description.lensDirection == CameraLensDirection.back)
            ? CameraLensDirection.front
            : CameraLensDirection.back;
    cameraStopped();
    cameraInitialize();
  }

  void cameraStopped() async {
    _controller?.dispose();
    emit(CameraInitial());
  }

  @override
  Future<void> close() {
    _controller?.dispose();
    return super.close();
  }
}
