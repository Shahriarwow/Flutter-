part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState(this.isLoginMode);
  
  final bool isLoginMode;
  
  @override
  List<Object> get props => [isLoginMode];
}

class AuthInitial extends AuthState {
  const AuthInitial(bool isLoginMode) : super(isLoginMode);
}

class AuthLoading extends AuthState{
  const AuthLoading(bool isLoginMode): super(isLoginMode);
}

class AuthError extends AuthState{
  final AppExeption exeption;
  const AuthError(bool isLoginMode, this.exeption, ): super(isLoginMode);
}

class AuthSucces extends AuthState{
  const AuthSucces(bool isLoginMode): super(isLoginMode);
}