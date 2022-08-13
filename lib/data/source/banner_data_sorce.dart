import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nike_store/data/banner.dart';
import 'package:nike_store/data/common/http_client.dart';
import 'package:nike_store/data/common/http_respe_validaror.dart';
import 'package:nike_store/data/repo/product_repositoy.dart';

abstract class IBannerDataSorce {

  Future<List<BannerEntity>> getAll();



}


class BannerRemoteDataSoce with HttpValidator implements IBannerDataSorce{

    final Dio httpClient;

  BannerRemoteDataSoce(this.httpClient);

  @override
  Future<List<BannerEntity>> getAll() async{
    
   final List<BannerEntity> banners=[];
    final response=await httpclient.get('banner/slider');
    validateResponse(response);
( response.data as List).forEach((jsonObject) {
  banners.add(BannerEntity.fromjson(jsonObject));
});
  return banners;




  }



}