import 'package:hive/hive.dart';
import 'package:subspace/subspace/features/Blog%20Article/models/blog_model.dart';

class LocalStorageService {
  static void storeDataLocally({required Blog blog, required Box<Blog> box}) {
    box.put(blog.id, blog);
  }

  static List<Blog> getBlogList({required Box<Blog> box}) {
    return box.values.toList();
  }

  static void updateBlog({required Box<Blog> box, required Blog blog}) async {
    await box.put(blog.id, blog);
  }
}