import 'package:flutter/material.dart';
import 'package:nike_store/UI/widgets/image.dart';
import 'package:nike_store/data/banner.dart';
import 'package:nike_store/data/common/utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  final List<BannerEntity> banners;
  final PageController _controller=PageController();
   BannerSlider({
    Key? key, required this.banners,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            PageView.builder(
              physics: defultScrollPhysics,
              controller: _controller,
              
              itemCount: banners.length,
              itemBuilder: (context, index) => ImageUrlService(
                  imageUrl: banners[index].imageURL,
                  borderRadius: BorderRadius.circular(12),
                  
                  ),
            ),
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(  
                 controller: _controller,  
                 count:  banners.length,  
                 axisDirection: Axis.horizontal,  
                 effect:  WormEffect(  
                    spacing:  8.0,  
                    radius:  4.0,  
                    dotWidth:  20.0,  
                    dotHeight:  3.0,  
                    paintStyle:  PaintingStyle.fill,  
                    strokeWidth:  1.5,  
                    dotColor:  Colors.grey.shade400,  
                    activeDotColor:  Theme.of(context).colorScheme.onBackground
            ),
              ),
            )
            
          )  ],
        ),
      ),
    );
  }
}
