
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
	LoginCubit() : super(LoginInitial());

	void login(String email, String password) async {
		try {
			emit(LoginLoading());
			// Simulate login delay
			await Future.delayed(Duration(seconds: 1));
			if (email == 'email@example.com' && password == 'password123') {
				emit(LoginSuccess());
			} else {
				emit(LoginFailure(error: 'Invalid credentials'));
			}
		} catch (e) {
			emit(LoginFailure(error: e.toString()));
		}
	}
}

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
	final String error;
	LoginFailure({required this.error});
}
