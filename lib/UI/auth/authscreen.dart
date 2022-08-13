import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/UI/auth/bloc/auth_bloc.dart';
import 'package:nike_store/data/repo/auth_repository.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
 
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextEditingController usernameController=TextEditingController(text: 'test@gmail.com');
    final TextEditingController passwordController=TextEditingController(text: '123456');
    // ignore: prefer_const_declarations
    final Color onbackground = Colors.white;

    return Theme(
      data: themeData.copyWith(
        colorScheme: themeData.colorScheme.copyWith(onSurface: onbackground),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size.fromHeight(54)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
              backgroundColor: MaterialStateProperty.all(onbackground),
              foregroundColor:
                  MaterialStateProperty.all(themeData.colorScheme.secondary)),
        ),
        inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: onbackground),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white, width: 1))),
      ),
      child: Scaffold(
        backgroundColor: themeData.colorScheme.secondary,
        body: BlocProvider<AuthBloc>(
          create: (context) {
            final bloc = AuthBloc(authrepository);
            bloc.add(AuthStarted());
            return bloc;

          },
          child: Padding(
            padding: const EdgeInsets.only(left: 28, right: 28),
            child: BlocBuilder<AuthBloc,AuthState>(
              builder: (context, state) {
                return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/nike_logo.png',
                    color: onbackground,
                    width: 100,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'خوش آمدید',
                    style: TextStyle(color: onbackground, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    state.isLoginMode
                        ? 'لطفا وارد حساب کاربری خود شوید'
                        : 'لظفا ادرس ایمیل و رمز عبور خود را وارد کنید',
                    style: TextStyle(color: onbackground, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                   TextField(
                    controller: usernameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      label: Text('ایمیل'),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PasswordTextFild(onbackground: onbackground,passwordController: passwordController,),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: ()  {
                        
                        authrepository.login(usernameController.text, passwordController.text);
                        
                       
                      },
                      child: Text(state.isLoginMode ? 'ورود' : 'ثبت نام')),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                       BlocProvider.of<AuthBloc>(context).add(AuthModeButtonIsClicked());
                    },
                    child: Row(
                      children: [
                        Text(
                          state.isLoginMode ? 'حساب کاربری ندارید؟' : 'حساب کاربری دارید؟',
                          style: TextStyle(color: onbackground),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          state.isLoginMode ? 'ثبت نام' : 'ورود',
                          style: TextStyle(
                              color: themeData.colorScheme.primary,
                              decoration: TextDecoration.underline),
                        )
                      ],
                    ),
                  )
                ],
              );
              },
             
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordTextFild extends StatefulWidget {
  const PasswordTextFild({
    Key? key,
    required this.onbackground, required this.passwordController,
  }) : super(key: key);

  final Color onbackground;
  final TextEditingController passwordController;
  @override
  State<PasswordTextFild> createState() => _PasswordTextFildState();
}

class _PasswordTextFildState extends State<PasswordTextFild> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          splashRadius: 16,
          icon: obscureText
              ? Icon(Icons.visibility_outlined)
              : Icon(Icons.visibility_off_outlined),
          color: widget.onbackground.withOpacity(0.6),
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
        ),
        label: const Text('رمز عبور'),
      ),
    );
  }
}
