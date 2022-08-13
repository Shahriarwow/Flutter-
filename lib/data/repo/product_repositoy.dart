import 'package:dio/dio.dart';
import 'package:nike_store/data/common/http_client.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/data/source/product_data_source.dart';

  

  final productRepository= ProductRepository(ProductRemoteDataSorce(httpclient));


abstract class IProductRepository{

  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String serchTerm);
  
}


class ProductRepository implements IProductRepository{

  final IProductDataSource dataSource;

  ProductRepository(this.dataSource);

  @override
  Future<List<ProductEntity>> getAll(int sort)  => dataSource.getAll(sort);

  @override
  Future<List<ProductEntity>> search(String serchTerm) => dataSource.search(serchTerm);



}