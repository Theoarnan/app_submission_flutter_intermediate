import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/models/stories_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/repository/stories_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

part 'stories_event.dart';
part 'stories_state.dart';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  final StoriesRepository storiesRepository;

  StoriesBloc({
    required this.storiesRepository,
  }) : super(StoriesInitialState()) {
    on<GetAllStories>((event, emit) => _getAllStories(event, emit));
    on<GetDetailStories>((event, emit) => _getDetailStories(event, emit));
    on<PostStories>((event, emit) => _postStories(event, emit));
    on<SetImageFile>((event, emit) => _setImageFile(event, emit));
    on<SetLocationData>((event, emit) => _setLocationData(event, emit));
  }

  XFile? imageFile;
  LatLng? locationData;
  int? pageItems = 1;
  int sizeItems = 10;
  List<StoriesModel> dataStories = [];

  void _getAllStories(
    GetAllStories event,
    Emitter<StoriesState> emit,
  ) async {
    imageFile = null;
    locationData = null;
    if (!(await UtilHelper.isConnected())) return emit(NoInternetState());
    if (event.isRefresh) {
      pageItems = 1;
      dataStories.clear();
    }
    try {
      if (pageItems == 1) emit(StoriesLoadingState());
      final dataResponse = await storiesRepository.getAllStory(pageItems!);
      if (dataResponse.error != true) {
        if (dataResponse.dataStory.length < sizeItems) {
          pageItems = null;
        } else {
          pageItems = pageItems! + 1;
        }
        final dataStoriesMap =
            await Future.wait(dataResponse.dataStory.map((e) async {
          final latitude = e.lat;
          final longitude = e.lon;
          String address = '';
          if (latitude != null && longitude != null) {
            address = await UtilHelper.getLocationByAddress(
              lat: latitude,
              lon: longitude,
              isSimpleAddress: true,
            );
          }
          return e.copyWith(address: address);
        }));
        dataStories.addAll(dataStoriesMap);
        emit(state.copyWith(
          stories: List.of(state.stories)..addAll(dataStoriesMap),
        ));
      } else {
        emit(StoriesErrorState(error: dataResponse.error.toString()));
      }
    } catch (e) {
      emit(StoriesErrorState(error: e.toString()));
    }
  }

  void _getDetailStories(
    GetDetailStories event,
    Emitter<StoriesState> emit,
  ) async {
    try {
      emit(StoriesLoadingState());
      if (await UtilHelper.isConnected() == false) {
        return emit(NoInternetState());
      }
      final data = await storiesRepository.getDetailStory(id: event.id);
      if (data.error != true) {
        emit(GetDetailStoriesSuccessState(dataStories: data.dataStory));
      } else {
        emit(StoriesErrorState(error: data.message));
      }
    } catch (e) {
      emit(StoriesErrorState(error: e.toString()));
    }
  }

  void _postStories(
    PostStories event,
    Emitter<StoriesState> emit,
  ) async {
    try {
      emit(PostStoriesLoadingState());
      await Future.delayed(const Duration(milliseconds: 300));
      if (await UtilHelper.isConnected() == false) {
        return emit(NoInternetState());
      }
      final fileName = imageFile!.name;
      final bytes = await imageFile!.readAsBytes();
      final newBytes = await UtilHelper.compressImage(bytes);
      final data = await storiesRepository.postStory(
        bytes: newBytes,
        fileName: fileName,
        description: event.description,
        latLng: locationData!,
      );
      if (data.error != true) {
        emit(PostStoriesSuccessState());
        locationData = null;
      } else {
        emit(StoriesErrorState(error: data.message));
      }
    } catch (e) {
      emit(StoriesErrorState(error: e.toString()));
    }
  }

  void _setImageFile(
    SetImageFile event,
    Emitter<StoriesState> emit,
  ) async {
    imageFile = event.image;
    emit(SetImageSuccess(fileImage: imageFile));
  }

  void _setLocationData(
    SetLocationData event,
    Emitter<StoriesState> emit,
  ) async {
    String address = '';
    try {
      locationData = event.location;
      if (locationData != null) {
        address = await UtilHelper.getLocationByAddress(
          lat: locationData!.latitude,
          lon: locationData!.longitude,
        );
      }
      emit(SetLocationSuccess(address: address, location: locationData));
    } catch (e) {
      emit(StoriesErrorState(error: e.toString()));
    }
  }
}
