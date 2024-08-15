import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:subspace/subspace/features/Blog%20Article/models/blog_model.dart';
import 'package:subspace/subspace/features/Blog%20Article/screens/detail_blog_screen.dart';
import 'package:subspace/subspace/global/functions/image_error_handling.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;

  const BlogCard({
    required this.blog,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     final cachedImageProvider = CachedNetworkImageProvider(blog.imageUrl);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlogDetailView(
              blog: blog,
              cachedImageProvider: cachedImageProvider,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: Stack(
          children: [
            Hero(
              tag: 'blog_image_${blog.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: blog.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorListener: (value) {} ,
                  errorWidget: imageErrorBuilder,
                  // errorBuilder: (_, st, s) => const SizedBox(height: 200),
                  cacheManager: CacheManager(
                    Config(
                      blog.imageUrl,
                      stalePeriod: const Duration(days: 7), 
                      maxNrOfCacheObjects: 500, 
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                  ),
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  blog.title,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
