part of 'stories_bloc.dart';

abstract class StoriesState extends Equatable {
  const StoriesState();
  @override
  List<Object?> get props => [];
}

class StoriesInitialState extends StoriesState {}

class StoriesLoadingState extends StoriesState {}

class GetAllStoriesSuccessState extends StoriesState {
  final List<StoriesModel> dataStories;
  const GetAllStoriesSuccessState({required this.dataStories});
  @override
  List<Object?> get props => [dataStories];
}

class GetDetailStoriesSuccessState extends StoriesState {
  final StoriesModel dataStories;
  const GetDetailStoriesSuccessState({required this.dataStories});
  @override
  List<Object?> get props => [dataStories];
}

class PostStoriesSuccessState extends StoriesState {}

class StoriesErrorState extends StoriesState {
  final String error;
  const StoriesErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}

class NoInternetState extends StoriesState {}

class GetImageGallerySuccess extends StoriesState {
  final XFile fileImage;
  const GetImageGallerySuccess({required this.fileImage});
  @override
  List<Object?> get props => [fileImage];
}
