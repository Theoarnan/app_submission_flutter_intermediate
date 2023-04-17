import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

abstract class CameraStateCubit extends Equatable {
  const CameraStateCubit();
  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraStateCubit {}

class CameraReady extends CameraStateCubit {}

class CameraFailure extends CameraStateCubit {
  final String error;
  const CameraFailure({this.error = "CameraFailure"});
  @override
  List<Object> get props => [error];
}

class CameraCaptureInProgress extends CameraStateCubit {}

class CameraCaptureSuccess extends CameraStateCubit {
  final XFile image;
  const CameraCaptureSuccess({required this.image});
  @override
  List<Object> get props => [image];
}

class CameraCaptureFailure extends CameraReady {
  final String error;
  CameraCaptureFailure({this.error = "CameraFailure"});
  @override
  List<Object> get props => [error];
}
