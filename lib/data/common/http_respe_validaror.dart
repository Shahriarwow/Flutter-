
  import 'package:dio/dio.dart';
import 'package:nike_store/common/exepction.dart';

mixin HttpValidator {

    validateResponse(Response response){
    if(response.statusCode !=200){
      throw AppExeption();
    }

  }}