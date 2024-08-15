import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:subspace/subspace/bloc/blog_bloc.dart';
import 'package:subspace/subspace/features/Blog%20Article/widgets/heart_button.dart';
import 'package:subspace/subspace/features/Blog%20Article/widgets/shimmer_widget.dart';
import 'package:subspace/subspace/global/functions/image_error_handling.dart';

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
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                imageErrorBuilder(context, 'error', stackTrace),
                          )
                        : CachedNetworkImage(
                            imageUrl: blog.imageUrl,
                            fit: BoxFit.fill,
                            cacheManager: CacheManager(
                              Config(
                                blog.imageUrl,
                                stalePeriod: const Duration(days: 7),
                                maxNrOfCacheObjects: 500,
                              ),
                            ),
                            imageBuilder: (context, _) => ShimmerEffect(
                              child: Card(
                                color: Colors.grey[850],
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[900],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),
                            errorWidget: imageErrorBuilder,
                            // errorWidget: (context, url, stk) {
                            //   return const SizedBox();
                            // },
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
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
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
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<BlogBloc, BlogState>(builder: (context, state) {
              bool isLike = blog.isLiked;
              if (state is BlogSuccessState) {
                isLike =
                    state.blogList.firstWhere((b) => b.id == blog.id).isLiked;
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: HeartButton(
                    isSelected: isLike,
                    onPressed: () {
                      context
                          .read<BlogBloc>()
                          .add(LikingBlogEvent(blogId: blog.id));
                    }),
              );
            }),
          )
        ],
      ),
    );
  }
}
