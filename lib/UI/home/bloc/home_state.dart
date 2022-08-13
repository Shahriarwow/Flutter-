part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}


class HomeErorre extends HomeState{

  final AppExeption exeption;

  const HomeErorre({required this.exeption});
  

List<Object> get props => [exeption];

}



class HomeSuccess extends HomeState{

 final List<BannerEntity> banners;
 final List<ProductEntity> latestProducts;
 final List<ProductEntity> popularProducts;

  const HomeSuccess({required this.banners,required this.latestProducts,required this.popularProducts});

}