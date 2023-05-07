part of 'stories_bloc.dart';

class StoriesState extends Equatable {
  final List<StoriesModel> stories;

  const StoriesState({
    this.stories = const [],
  });

  StoriesState copyWith({
    List<StoriesModel>? stories,
  }) {
    return StoriesState(
      stories: stories ?? this.stories,
    );
  }

  @override
  List<Object?> get props => [stories];
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

class PostStoriesLoadingState extends StoriesState {}

class StoriesErrorState extends StoriesState {
  final String error;
  const StoriesErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}

class NoInternetState extends StoriesState {}

class GetImageGallerySuccess extends StoriesState {
  final XFile? fileImage;
  const GetImageGallerySuccess({required this.fileImage});
  @override
  List<Object?> get props => [fileImage];
}
