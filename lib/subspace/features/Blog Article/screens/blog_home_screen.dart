import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subspace/subspace/bloc/blog_bloc.dart';
import 'package:subspace/subspace/features/Blog%20Article/widgets/blog_card_widget.dart';
import 'package:subspace/subspace/features/Blog%20Article/widgets/shimmer_widget.dart';

class BlogHomeScreen extends StatelessWidget {
  const BlogHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BlogBloc>().add(FetchingBlogEvent());
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 14),
            Image.asset('asset/images/subspace.png', height: 60),
            const SizedBox(height: 14),
            Expanded(
              child: BlocConsumer<BlogBloc, BlogState>(
                builder: (context, state) {
                  if (state is BlogSuccessState) {
                    final list = state.blogList;
                    final count = list.length;
                    return ListView.builder(
                        itemCount: count,
                        itemBuilder: (context, index) {
                          final blog = list[index];
                          return BlogCard(blog: blog);
                        });
                  } else if (state is BlogFailureState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.failure,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              context.read<BlogBloc>().add(FetchingBlogEvent());
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              'Tap To Refresh',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(children: [
                        for (int i = 0; i < 5; i++)
                          const ShimmerEffect(
                            child: BlogCardShimmer(),
                          )
                      ]),
                    );
                  }
                },
                listener: (context, state) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
