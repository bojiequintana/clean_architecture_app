import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lending_app/core/usecase/usecase.dart';
import 'package:lending_app/features/blog/domain/entities/blog.dart';
import 'package:lending_app/features/blog/domain/usecases/get_all_blogs_usecase.dart';
import 'package:lending_app/features/blog/domain/usecases/upload_blog_usecase.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUsecase _uploadBlogUsecase;
  final GetAllBlogsUsecase _getAllBlogsUsecase;
  BlogBloc({
    required UploadBlogUsecase uploadBlogUsecase,
    required GetAllBlogsUsecase getAllBlogUsecase,
  })  : _uploadBlogUsecase = uploadBlogUsecase,
        _getAllBlogsUsecase = getAllBlogUsecase,
        super(BlogInitial()) {
    // on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogGetAllBlogsEvent>(_onGetAllBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final res = await _uploadBlogUsecase(
      UploadBlogParams(
        postedId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );
    res.fold(
        (l) => emit(BlogFailure(l.message)), (r) => emit(BlogUploadSuccess()));
  }

  void _onGetAllBlogs(
      BlogGetAllBlogsEvent event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final res = await _getAllBlogsUsecase(NoParams());
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) {
        emit(BlogDisplaySuccess(r));
      },
    );
  }
}
