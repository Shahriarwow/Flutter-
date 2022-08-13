import 'package:flutter/material.dart';
import 'package:nike_store/UI/auth/authscreen.dart';
import 'package:nike_store/UI/home/home.dart';
import 'package:nike_store/UI/root.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/banner_repository.dart';
import 'package:nike_store/data/repo/product_repositoy.dart';
import 'package:nike_store/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  authrepository.loadAuthInfo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    productRepository.getAll(0).then((value) {
      debugPrint(value.toString());
    }).catchError((e){
        debugPrint(e.toString());

    })
    ;
    
    bannerRepository.getAll().then((value) {
      debugPrint(value.toString());
    }).catchError((e){
      debugPrint(e.toString());

    });


    const defultTextStyle = TextStyle(fontFamily: 'IranYekan');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
      colorScheme: const ColorScheme.light(
        primary: LightThemeColors.primarycolor,
        secondary: LightThemeColors.secendrycolor,
        onSecondary: Colors.white
      ),
        textTheme: TextTheme(
          subtitle1: defultTextStyle.apply(color: LightThemeColors.secendryTextColor ),
          button: defultTextStyle,
          bodyText2: defultTextStyle,
          caption: defultTextStyle.apply(color: LightThemeColors.secendryTextColor),
          headline6: defultTextStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 18)
          
        ),
    
      ),
      
      home: const Directionality(textDirection: TextDirection.rtl,
      child:AuthScreen()),
    );
  }
}

