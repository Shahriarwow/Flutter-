import 'package:dio/dio.dart';
import 'package:nike_store/data/comments.dart';
import 'package:nike_store/data/common/http_respe_validaror.dart';

abstract class ICommentDataSorce {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentDataSorce with HttpValidator implements ICommentDataSorce {
  final Dio httpClient;

  CommentDataSorce(this.httpClient);

  @override
  Future<List<CommentEntity>> getAll({required int productId}) async {
    final response = await httpClient.get('comment/list?product_id=$productId');

    validateResponse(response);

    final List<CommentEntity> comments = [];
    (response.data as List).forEach((element) {
      comments.add(CommentEntity.fromjson(element));
    });
    return comments;
  }
}
