import 'package:dio/dio.dart';
import 'package:nike_store/common/exepction.dart';
import 'package:nike_store/data/common/http_respe_validaror.dart';
import 'package:nike_store/data/product.dart';

abstract class IProductDataSource{

    Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String serchTerm);

}

class ProductRemoteDataSorce with HttpValidator implements IProductDataSource{
  final Dio httpClient;

  ProductRemoteDataSorce(this.httpClient);


  @override
  Future<List<ProductEntity>> getAll(int sort) async{
   final response=await httpClient.get('product/list?sort=$sort');
    validateResponse(response);
    final products= <ProductEntity>[];
    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
     });
    return products;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async{
      final response=await httpClient.get('product/search?q=$searchTerm');
    validateResponse(response);
    final products= <ProductEntity>[];
    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
     });
    return products;
  }
  }

  

 



