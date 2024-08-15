import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:subspace/subspace/core/services/local_storage_service.dart';
import 'package:subspace/subspace/features/Blog%20Article/models/blog_model.dart';
import 'package:subspace/subspace/features/Blog%20Article/repository/blog_repo.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc() : super(BlogInitialState()) {
    on<FetchingBlogEvent>((event, emit) async {
      emit(BlogLoadingState());
      final b = await Hive.openBox<Blog>(LocalStorageService.blogBox);

      final blogList = LocalStorageService.getBlogList(box: b);
      if (blogList.isNotEmpty) {
        return emit(BlogSuccessState(blogList: blogList));
      } else {
        try {
          final response = await fetchBlogs();
          if (response.statusCode == 200) {
            final box = await Hive.openBox<Blog>(LocalStorageService.blogBox);
            final list = jsonDecode(response.body)['blogs'];
            for (final model in list) {
              final blog = Blog.fromMap(model);
              blogList.add(blog);
              LocalStorageService.storeDataLocally(blog: blog, box: box);
            }
            emit(BlogSuccessState(blogList: blogList));
            return;
          } else {
            emit(BlogFailureState(
                failure:
                    "We encountered an issue while fetching the data.\nPlease try again later."));
          }
        } on SocketException {
          return emit(BlogFailureState(
              failure:
                  "Connection error.\nPlease check your network and try again."));
        } on ClientException {
          return emit(BlogFailureState(
              failure:
                  "Connection error.\nPlease check your network and try again."));
        } catch (e) {
          return emit(BlogFailureState(
              failure: "An unexpected error occurred.\nPlease try again."));
        }
      }
    });
    on<LikingBlogEvent>((event, emit) async {
      final box = Hive.box<Blog>(LocalStorageService.blogBox);

      Blog? blog = box.get(event.blogId);
      if (blog != null) {
        if (blog.isLiked) {
          blog = blog.copyWith(isLiked: false);
        } else {
          blog = blog.copyWith(isLiked: true);
        }
        await LocalStorageService.updateBlog(box: box, blog: blog);
        emit(BlogSuccessState(
            blogList: LocalStorageService.getBlogList(box: box)));
        return;
      }
    });
  }
}
