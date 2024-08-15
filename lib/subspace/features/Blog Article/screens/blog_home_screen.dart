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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        // backgroundColor: Colors.white,
        title: const Text(
          'Blogs and Articles',
          style: TextStyle(
              // color: Colors.black,
              // fontWeight: FontWeight.bold,
              // fontSize: 24,
              ),
        ),
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogLoadingState) {
            return SingleChildScrollView(
              child: Column(children: [
                for (int i = 0; i < 5; i++)
                  const ShimmerEffect(
                    child: BlogCardShimmer(),
                  )
              ]),
            );
          }
          if (state is BlogSuccessState) {
            final list = state.blogList;
            final count = list.length;
            return ListView.builder(
                itemCount: count,
                itemBuilder: (context, index) {
                  final blog = list[index];
                  return BlogCard(blog: blog);
                });
          }
          if (state is BlogFailureState) {
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
          }
          return const Center(
            child: Text('Blog Home Page'),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
