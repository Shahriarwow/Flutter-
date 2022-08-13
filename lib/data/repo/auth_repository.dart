import 'package:flutter/cupertino.dart';
import 'package:nike_store/data/auth_info.dart';
import 'package:nike_store/data/common/http_client.dart';
import 'package:nike_store/data/source/auth_data_sorce.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authrepository = AuthRepository(AuthDataSorce(httpclient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> signUp(String username, String password);
  Future<void> refreshToken();
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthInfo?> authChangeNotifier =
      ValueNotifier(null);
  final IAuthRemoteDataSorce dataSorce;
 
  AuthRepository(this.dataSorce, );

  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSorce.login(username, password);
    _persistAuthToken(authInfo);
  }

  @override
  Future<void> signUp(String username, String password) async {
    final AuthInfo authInfo = await dataSorce.login(username, password);
    _persistAuthToken(authInfo);
  }

  @override
  Future<void> refreshToken() async {
    final AuthInfo authInfo = await dataSorce.resfreshToken(
        "def5020093ed34969995a0a6a145be8b9b1c945ba4f7e2e68c1133805bac3789fb43f2a4ad82a82cfd8a4733835d8616b73f0ea66fa8bade079d4687ed026aead03f43c42ca922972b8cc6a866719c6183715917fb31ebeb4f6eced63934ed78a19511307c7963d98bb3222d3d6a4e941b6c3ebd64cb0942d223bbe602553b0e04095180eda17c2d23167e581d75945c759ee9b9f512935053035e7127995b7e76e345ee4556dca168458f9eebc9f0fc8a4983f0829ea8a2d4ebedaf8226dc07ea29069bf093b525b19257eeb1de5f3103c9cba0eb8a231f81a5504659aca18efb14c7f1ff36714356f425235f602371a2343b3a0471d9ceaabc00115870d8ac84fc5d0a1c86564fba85be6faa31861d79f8f1a4ed35d62c89005d3656196400e29eae3c8020ca333af13dadcbb9315b17100fc1de248b80e16a782fb73a3fe6c04957eabf0a21af09fddaf9ceff851e58aa77bd99b5ae34a9482a9d83a09c1d");
    _persistAuthToken(authInfo);
  }

  Future<void> _persistAuthToken(AuthInfo authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    sharedPreferences.setString("access_token", authInfo.accessToken);
    sharedPreferences.setString("refresh_token", authInfo.refreshToken);
  }

  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String access_token =
        sharedPreferences.getString("access_token") ?? "";

    final String refresh_token =
        sharedPreferences.getString("refresh_token") ?? "";
    if (access_token.isNotEmpty && refresh_token.isNotEmpty) {
      authChangeNotifier.value = AuthInfo(access_token, refresh_token);
    }
  }
}
