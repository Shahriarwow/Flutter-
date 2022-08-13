import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/UI/home/bloc/home_bloc.dart';
import 'package:nike_store/common/exepction.dart';

class AppErorrWidget extends StatelessWidget {
  final AppExeption exeption;
  final GestureTapCallback onPressed;

  const AppErorrWidget({
    Key? key,
    required this.exeption,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(exeption.massage),
          ElevatedButton.icon(
              onPressed: () {
                BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
              },
              icon: const Icon(CupertinoIcons.refresh_circled_solid),
              label: const Text('تلاش مجدد'))
        ],
      ),
    );
  }
}