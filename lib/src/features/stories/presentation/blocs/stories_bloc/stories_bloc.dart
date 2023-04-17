import 'package:app_submission_flutter_intermediate/src/common/connection/connection_helper.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/util_helper.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/models/stories_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/stories/repository/stories_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<SelectImageGallery>((event, emit) => _selectImageGallery(event, emit));
  }

  void _getAllStories(
    GetAllStories event,
    Emitter<StoriesState> emit,
  ) async {
    try {
      emit(StoriesLoadingState());
      if (await ConnectionHelper.isConnected() == false) {
        return emit(NoInternetState());
      }
      await Future.delayed(const Duration(seconds: 3));
      final data = await storiesRepository.getAllStory();
      if (data.error != true) {
        emit(GetAllStoriesSuccessState(dataStories: data.dataStory));
      } else {
        emit(StoriesErrorState(error: data.message));
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
      if (await ConnectionHelper.isConnected() == false) {
        return emit(NoInternetState());
      }
      await Future.delayed(const Duration(seconds: 3));
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
      emit(StoriesLoadingState());
      if (await ConnectionHelper.isConnected() == false) {
        return emit(NoInternetState());
      }
      final fileName = event.image.name;
      final bytes = await event.image.readAsBytes();
      final newBytes = await UtilHelper.compressImage(bytes);
      await Future.delayed(const Duration(seconds: 3));
      final data = await storiesRepository.postStory(
        bytes: newBytes,
        fileName: fileName,
        description: event.description,
      );
      if (data.error != true) {
        emit(PostStoriesSuccessState());
      } else {
        emit(StoriesErrorState(error: data.message));
      }
    } catch (e) {
      emit(StoriesErrorState(error: e.toString()));
    }
  }

  void _selectImageGallery(
    SelectImageGallery event,
    Emitter<StoriesState> emit,
  ) async {
    emit(StoriesLoadingState());
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        emit(GetImageGallerySuccess(fileImage: pickedFile));
      }
    } catch (error) {
      emit(StoriesErrorState(error: error.toString()));
    }
  }
}