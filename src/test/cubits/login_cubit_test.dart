
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_cubit_app/cubits/login_cubit.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginCubit Tests', () {
		late LoginCubit loginCubit;

		setUp(() {
			loginCubit = MockLoginCubit();
		});

		blocTest<LoginCubit, LoginState>(
			'emit [LoginLoading, LoginSuccess] when login is successful',
			build: () => loginCubit,
			act: (cubit) => cubit.login('email@example.com', 'password123'),
			expect: () => [isA<LoginLoading>(), isA<LoginSuccess>()],
		);

		blocTest<LoginCubit, LoginState>(
			'emit [LoginLoading, LoginFailure] when login fails',
			build: () => loginCubit,
			act: (cubit) => cubit.login('email@example.com', 'wrongpassword'),
			expect: () => [isA<LoginLoading>(), isA<LoginFailure>()],
		);
	});
}
