import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/UI/Products/comment/comment_list.dart';
import 'package:nike_store/UI/widgets/image.dart';
import 'package:nike_store/data/comments.dart';
import 'package:nike_store/data/common/utils.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/theme.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width-48,
          child: FloatingActionButton.extended(onPressed: (){}, label: Text('افزودن سبد خرید'))),

        body: CustomScrollView(
          physics: defultScrollPhysics,
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.width * 0.8,
              flexibleSpace: ImageUrlService(imageUrl: product.imageURL),
              foregroundColor: LightThemeColors.primaryTextColor,
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.heart))
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          product.title,
                          style: theme.textTheme.headline6,
                        )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              product.price.withPricelable(),
                              style: theme.textTheme.caption!.apply(
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(product.price.withPricelable())
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    const Text(
                        'این کتونی شدیدا برای دویدن مناسب میباشد و تقریبا هیچ فشار مخربی به پا و زانوان شما انتقال داده نمیشود'),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('نظرات کاربران',style: theme.textTheme.subtitle1,),
                        TextButton(onPressed: () {}, child: Text('ثبت نظر'))
                      ],
                    ),
                   
                  ],
                ),
              ),
            ),
            CommentList(productId: product.id)
          ],
        ),
      ),
    );
  }
}
