import 'package:nike_store/data/banner.dart';
import 'package:nike_store/data/common/http_client.dart';
import 'package:nike_store/data/source/banner_data_sorce.dart';


 final bannerRepository=BannerRepository(BannerRemoteDataSoce(httpclient));

abstract class IBannerRepository {
   
  Future<List<BannerEntity>> getAll();
   


} 

class BannerRepository implements IBannerRepository{
  final IBannerDataSorce dataSorce;

  BannerRepository(this.dataSorce);

  @override
  Future<List<BannerEntity>> getAll() => dataSorce.getAll();



}