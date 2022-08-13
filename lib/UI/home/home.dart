import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/UI/Products/product.dart';
import 'package:nike_store/UI/home/bloc/home_bloc.dart';
import 'package:nike_store/UI/widgets/banners_Slider.dart';
import 'package:nike_store/UI/widgets/error.dart';
import 'package:nike_store/common/exepction.dart';

import 'package:nike_store/data/common/utils.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/data/repo/banner_repository.dart';
import 'package:nike_store/data/repo/product_repositoy.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homebloc = HomeBloc(
            bannerRepository: bannerRepository,
            productRepository: productRepository);
        homebloc.add(HomeStarted());
        return homebloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                  physics: defultScrollPhysics,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Container(
                          height: 56,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/img/nike_logo.png',
                            fit: BoxFit.fitHeight,
                            height: 35,
                          ),
                        );
                      case 2:
                        return BannerSlider(
                          banners: state.banners,
                        );
                      case 3:
                        return _HorizontalProductList(
                          title: 'جدیدترین',
                          onTap: () {},
                          products: state.latestProducts,
                        );
                      case 4:
                        return _HorizontalProductList(
                          title: 'پربازدیدترین',
                          onTap: () {},
                          products: state.popularProducts,
                        );
                      default:
                        return Container();
                    }
                  },
                );
              } else if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeErorre) {
                return AppErorrWidget(
                  exeption: state.exeption,
                  onPressed:(() {
                    BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                  })
                      
                );
              } else {
                throw Exception('state is not support');
              }
            },
          ),
        ),
      ),
    );
  }
}



class _HorizontalProductList extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final List<ProductEntity> products;
  const _HorizontalProductList({
    Key? key,
    required this.title,
    required this.onTap,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              TextButton(onPressed: () {}, child: const Text('مشاهده همه')),
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
            physics: defultScrollPhysics,
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 8, right: 8),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductItems(
                product: product,
                borderRadius: BorderRadius.circular(12),
              );
            },
          ),
        ),
      ],
    );
  }
}
