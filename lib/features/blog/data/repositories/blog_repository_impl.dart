import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:lending_app/core/error/exceptions.dart';
import 'package:lending_app/core/error/failure.dart';
import 'package:lending_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:lending_app/features/blog/data/model/blog_model.dart';
import 'package:lending_app/features/blog/domain/entities/blog.dart';
import 'package:lending_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl(this.blogRemoteDataSource);
  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required File image,
      required String title,
      required String content,
      required String posterId,
      required List<String> topics}) async {
    try {
      BlogModel blogModel = BlogModel(
          id: const Uuid().v1(),
          posterId: posterId,
          title: title,
          content: content,
          imageUrl: 'imageUrl',
          topics: topics,
          updatedAt: DateTime.now());

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
          image: image, blog: blogModel);
      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      await blogRemoteDataSource.uploadBlog(blogModel);
      return right(blogModel);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}