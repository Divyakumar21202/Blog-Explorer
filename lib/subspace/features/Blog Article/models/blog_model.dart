import 'package:hive/hive.dart';

part 'blog_model.g.dart';

@HiveType(typeId: 0)
class Blog {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  bool isLiked = false;

  Blog({
    required this.title,
    required this.id,
    required this.imageUrl,
    this.isLiked =false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'id': id,
      'imageUrl': imageUrl,
    };
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      title: map['title'] as String,
      id: map['id'] as String,
      imageUrl: map['image_url'] as String,
    );
  }

  Blog copyWith({
    String? id,
    String? title,
    String? imageUrl,
    bool? isLiked,
  }) {
    return Blog(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
