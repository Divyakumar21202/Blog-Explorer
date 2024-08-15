part of 'blog_bloc.dart';

sealed class BlogState {}

final class BlogInitialState extends BlogState {}

final class BlogSuccessState extends BlogState {
  final List<Blog> blogList;

  BlogSuccessState({
    required this.blogList,
  });
}

final class BlogLoadingState extends BlogState {}

final class BlogFailureState extends BlogState {
  final String failure;

  BlogFailureState({
    required this.failure,
  });
  
}
