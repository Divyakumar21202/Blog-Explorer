part of 'blog_bloc.dart';

sealed class BlogEvent {}

final class FetchingBlogEvent extends BlogEvent {}

final class LikingBlogEvent extends BlogEvent {
  final String blogId;

  LikingBlogEvent({
    required this.blogId,
  });
}