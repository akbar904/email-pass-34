
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

// Define the states for the AuthCubit
@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

// AuthCubit class definition
class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void login(String email, String password) {
		// For simplicity, we assume the login is always successful
		emit(Authenticated());
	}

	void logout() {
		emit(Unauthenticated());
	}
}
