import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/UI/Products/comment/bloc/comment_list_bloc_bloc.dart';
import 'package:nike_store/UI/widgets/error.dart';
import 'package:nike_store/common/exepction.dart';
import 'package:nike_store/data/comments.dart';
import 'package:nike_store/data/repo/comment_repository.dart';
import 'package:nike_store/data/source/comment_data_sorce.dart';

class CommentList extends StatelessWidget {
  final int productId;

  const CommentList({super.key, required this.productId});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final CommentListBloc bloc = CommentListBloc(
          productId: productId,
          repository: commentRepository,
        );
        bloc.add(CommentListStarted());

        return bloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListState>(
          builder: (context, state) {
        if (state is CommentListSucsses) {
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return CommentItem(
                data: state.comments[index],
              );
            }, childCount: state.comments.length),
          );
        } else if (state is CommentListLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is CommentListError) {
          return SliverToBoxAdapter(
              child: AppErorrWidget(
                  exeption: state.exeption,
                  onPressed: () {
                    BlocProvider.of<CommentListBloc>(context)
                        .add(CommentListStarted());
                  }));
        } else {
          throw Exception('state is not suported');
        }
      }),
    );
  }
}

class CommentItem extends StatelessWidget {
  final CommentEntity data;
  const CommentItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(
        width: 1,
        color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(12)
        ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child:
      
       Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                  ),
                  Text(
                    data.email,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(height: 4,)
                ],
              ),
              Text(
                data.date,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
          SizedBox(height: 16,),
          Text(data.content),
        ],
      ),
    );
  }
}
