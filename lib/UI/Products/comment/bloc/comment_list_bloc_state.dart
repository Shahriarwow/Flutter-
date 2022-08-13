part of 'comment_list_bloc_bloc.dart';

abstract class CommentListState extends Equatable {
  const CommentListState();
  
  @override
  List<Object> get props => [];
}

class CommentListLoading extends CommentListState {}


class CommentListSucsses extends CommentListState{

  final List<CommentEntity> comments;

  const CommentListSucsses(this.comments);

 @override

  List<Object> get props => (comments);
}


class CommentListError extends CommentListState{

  final AppExeption exeption;

  const CommentListError(this.exeption);

  @override
 
  List<Object> get props => [exeption];

}