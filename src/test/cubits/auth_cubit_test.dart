
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('AuthCubit', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = AuthCubit();
		});

		tearDown(() {
			authCubit.close();
		});

		test('initial state is AuthInitial', () {
			expect(authCubit.state, AuthInitial());
		});

		blocTest<AuthCubit, AuthState>(
			'emits [AuthInitial, Authenticated] when login is successful',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password'),
			expect: () => [AuthInitial(), Authenticated()],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthInitial, Unauthenticated] when logout is called',
			build: () => authCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [AuthInitial(), Unauthenticated()],
		);
	});
}
