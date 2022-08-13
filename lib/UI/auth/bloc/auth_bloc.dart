import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exepction.dart';
import 'package:nike_store/data/repo/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool isLoginMode;
  final IAuthRepository authRepository;
  AuthBloc(this.authRepository, {this.isLoginMode = true})
      : super(AuthInitial(isLoginMode)) {
    on<AuthEvent>((event, emit) async {
     try{
 if (event is AuthButtonIsClicked) {
        emit(AuthLoading(isLoginMode));
        if (isLoginMode) {
          await authRepository.login(event.username, event.password);
          emit(AuthSucces(isLoginMode));
        } else {
          await authRepository.signUp(event.username, event.password);
          emit(AuthSucces(isLoginMode));
        }
      }else if(event is AuthModeButtonIsClicked){

        isLoginMode =! isLoginMode;
        emit(AuthInitial(isLoginMode));

      }
     }catch (e) {

      emit(AuthError(isLoginMode,AppExeption()));

     }
    });
  }
}
