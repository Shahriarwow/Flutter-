import 'package:flutter/cupertino.dart';

const defultScrollPhysics= BouncingScrollPhysics();




extension PriceLabale on int{

  String withPricelable()=> '$this تومان';

}