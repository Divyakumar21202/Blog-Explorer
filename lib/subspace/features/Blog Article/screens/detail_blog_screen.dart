import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:subspace/subspace/features/Blog%20Article/widgets/shimmer_widget.dart';

import '../models/blog_model.dart';

class BlogDetailView extends StatelessWidget {
  final Blog blog;

  final CachedNetworkImageProvider? cachedImageProvider;
  const BlogDetailView({
    required this.blog,
    super.key,
    required this.cachedImageProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  Hero(
                    tag: 'blog_image_${blog.id}',
                    child: cachedImageProvider != null
                        ? Image(
                            image: cachedImageProvider!,
                            fit: BoxFit.fill,
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: double.infinity,
                          )
                        : CachedNetworkImage(
                            imageUrl: blog.imageUrl,
                            fit: BoxFit.fill,
                            // errorBuilder: imageErrorBuilder,
                            cacheManager: CacheManager(
                              Config(
                                blog.imageUrl,
                                stalePeriod:
                                    const Duration(days: 7), // Cache for 7 days
                                maxNrOfCacheObjects:
                                    500, // Limit to 100 cached objects
                              ),
                            ),
                            imageBuilder: (context, _) => ShimmerEffect(
                              child: Card(
                                color: Colors.grey[
                                    850], // Darker background for the card
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[
                                        900], // Even darker color for the shimmer base
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                },
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () {
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            //   child: Padding(
            //     // padding: const EdgeInsets.all(16.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            // const SizedBox(height: 16),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     IconButton(
            //       icon: Icon(
            //         Icons.favorite_border,
            //         color: Theme.of(context).primaryColor,
            //       ),
            //       onPressed: () {
            //         // Implement like/unlike functionality
            //       },
            //     ),
            //     IconButton(
            //       icon: Icon(
            //         Icons.share,
            //         color: Theme.of(context).primaryColor,
            //       ),
            //       onPressed: () {
            //         // Implement share functionality
            //       },
            //     ),
            //   ],
            // ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                blog.title,
                style: GoogleFonts.merriweather(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            //     ],
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
