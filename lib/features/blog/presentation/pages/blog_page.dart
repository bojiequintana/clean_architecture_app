import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lending_app/core/common/widgets/loader.dart';
import 'package:lending_app/core/theme/app_pallete.dart';
import 'package:lending_app/core/utils/show_snackbar.dart';
import 'package:lending_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lending_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:lending_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:lending_app/features/blog/presentation/widgets/blog_card.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const BlogPage(),
      );
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogGetAllBlogsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton(
          backgroundColor: AppPallete.backgroundColor,
          onPressed: () {
            Navigator.push(context, AddNewBlogPage.route());
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add), // Ensures the button is circular
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(title: const Text('Blog App'), actions: [
        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                      AuthSignOut(),
                    );
                setState(() {});
              },
              icon: const Icon(Icons.logout),
            );
          },
        )
      ]),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogDisplaySuccess) {
            return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return BlogCard(
                    blog: blog,
                    color: AppPallete.gadient1,
                  );
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
