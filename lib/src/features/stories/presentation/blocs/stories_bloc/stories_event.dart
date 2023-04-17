part of 'stories_bloc.dart';

abstract class StoriesEvent extends Equatable {
  const StoriesEvent();
  @override
  List<Object?> get props => [];
}

class GetAllStories extends StoriesEvent {}

class GetDetailStories extends StoriesEvent {
  final String id;
  const GetDetailStories({required this.id});
  @override
  List<Object> get props => [id];
}

class PostStories extends StoriesEvent {
  final XFile image;
  final String description;
  const PostStories({
    required this.image,
    required this.description,
  });
  @override
  List<Object> get props => [image, description];
}

class SelectImageGallery extends StoriesEvent {}
