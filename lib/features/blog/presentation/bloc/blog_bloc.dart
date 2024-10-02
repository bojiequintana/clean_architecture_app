import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lending_app/features/blog/domain/usecases/upload_blog_usecase.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUsecase uploadBlogUsecase;
  BlogBloc(this.uploadBlogUsecase) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>((event, emit) {});
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {}
}
