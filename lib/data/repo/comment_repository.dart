import 'package:nike_store/data/comments.dart';
import 'package:nike_store/data/common/http_client.dart';
import 'package:nike_store/data/source/comment_data_sorce.dart';

final commentRepository = CommentRepository(CommentDataSorce(httpclient));

abstract class ICommentRepository {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSorce dataSorce;

  CommentRepository(this.dataSorce);

  @override
  Future<List<CommentEntity>> getAll({required int productId}) =>
      dataSorce.getAll(productId: productId);
}
