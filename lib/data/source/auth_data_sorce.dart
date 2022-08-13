import 'package:dio/dio.dart';
import 'package:nike_store/data/auth_info.dart';
import 'package:nike_store/data/common/constans.dart';
import 'package:nike_store/data/common/http_respe_validaror.dart';

abstract class IAuthRemoteDataSorce {
  Future<AuthInfo> login(String username, String password);
  Future<AuthInfo> signUp(String username, String password);
  Future<AuthInfo> resfreshToken(String token);
}

class AuthDataSorce with HttpValidator implements IAuthRemoteDataSorce {
  final Dio httpClient;

  AuthDataSorce(this.httpClient);
  @override
  Future<AuthInfo> login(String username, String password) async {
    final response = await httpClient.post('auth/token', data: {
      "grant_type": "password",
      "client_id": 2,
      "client_secret": Constans.clientsecret,
      "username": username,
      "password": password,
    });

    validateResponse(response);
    return AuthInfo(
        response.data["access_token"], response.data["refresh_token"]);
  }

  @override
  Future<AuthInfo> signUp(String username, String password) async {
    final respons = await httpClient
        .post("user/register", data: {"email": username, "password": password});

    validateResponse(respons);
    return login(username, password);
  }

  @override
  Future<AuthInfo> resfreshToken(String token) async {
    final respons = await httpClient.post("auth/token", data: {
      "grant_type": "refresh_token",
      "refresh_token": token,
      "client_id":2,
      "client_secret":Constans.clientsecret
  
    });

  validateResponse(respons);
  return AuthInfo(respons.data["access_token"], respons.data["refresh_token"]);

  }
}
