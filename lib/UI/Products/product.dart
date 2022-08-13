






import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/UI/Products/detail.dart';
import 'package:nike_store/UI/widgets/image.dart';
import 'package:nike_store/data/common/utils.dart';
import 'package:nike_store/data/product.dart';

class ProductItems extends StatelessWidget {
  const ProductItems({
    Key? key,
    required this.product, required this.borderRadius,
  }) : super(key: key);

  final ProductEntity product;
  final BorderRadius borderRadius;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        borderRadius: borderRadius ,
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product,) )),
        child: SizedBox(
          width: 176,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 176,
                    height: 168,
                    child: ImageUrlService(
                      
                      imageUrl: product.imageURL,
                      borderRadius:borderRadius,
                      
                    ),
                  ),
                  Positioned(
                    right:8,
                    top: 8,
                    child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: const Icon(
                        CupertinoIcons.heart,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(product.title,maxLines: 1,overflow: TextOverflow.ellipsis,),
              ),
              const SizedBox( 
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(product.price.withPricelable(),
                style: Theme.of(context).textTheme.caption?.copyWith(decoration: TextDecoration.lineThrough),
                ),
              ),
             
              
              Padding(
                padding: const EdgeInsets.only(right: 8,left: 8),
                child: Text(product.previousPrice.withPricelable()),
              ),
            ],
          ),
        ),
      )
      ,
    );
  }
}
