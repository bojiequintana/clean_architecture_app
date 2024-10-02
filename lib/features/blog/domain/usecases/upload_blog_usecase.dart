import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:lending_app/core/error/failure.dart';
import 'package:lending_app/core/usecase/usecase.dart';
import 'package:lending_app/features/blog/domain/entities/blog.dart';
import 'package:lending_app/features/blog/domain/repositories/blog_repository.dart';

class UploadBlogUsecase implements Usecase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlogUsecase(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
        image: params.image,
        title: params.title,
        content: params.content,
        posterId: params.postedId,
        topics: params.topics);
  }
}

class UploadBlogParams {
  final String postedId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams(
      {required this.postedId,
      required this.title,
      required this.content,
      required this.image,
      required this.topics});
}
