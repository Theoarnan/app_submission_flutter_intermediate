part of 'stories_bloc.dart';

abstract class StoriesEvent extends Equatable {
  const StoriesEvent();
  @override
  List<Object?> get props => [];
}

class GetAllStories extends StoriesEvent {
  final bool isRefresh;
  const GetAllStories({this.isRefresh = false});
  @override
  List<Object> get props => [isRefresh];
}

class GetDetailStories extends StoriesEvent {
  final String id;
  const GetDetailStories({required this.id});
  @override
  List<Object> get props => [id];
}

class PostStories extends StoriesEvent {
  final String description;
  const PostStories({
    required this.description,
  });
  @override
  List<Object> get props => [description];
}

class SelectImageGallery extends StoriesEvent {}

class SetImageFile extends StoriesEvent {
  final XFile image;
  const SetImageFile({required this.image});
  @override
  List<Object> get props => [image];
}
