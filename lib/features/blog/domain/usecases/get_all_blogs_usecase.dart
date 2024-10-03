import 'package:fpdart/fpdart.dart';
import 'package:lending_app/core/error/failure.dart';
import 'package:lending_app/core/usecase/usecase.dart';
import 'package:lending_app/features/blog/domain/entities/blog.dart';
import 'package:lending_app/features/blog/domain/repositories/blog_repository.dart';

class GetAllBlogsUsecase implements Usecase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogsUsecase(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
