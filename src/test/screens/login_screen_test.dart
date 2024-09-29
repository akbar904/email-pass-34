
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:simple_cubit_app/screens/login_screen.dart';
import 'package:simple_cubit_app/cubits/login_cubit.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('renders email and password fields', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));

			expect(find.byType(TextFormField), findsNWidgets(2));
			expect(find.text('Email'), findsOneWidget);
			expect(find.text('Password'), findsOneWidget);
		});

		testWidgets('renders login button', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));

			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.text('Login'), findsOneWidget);
		});
	});

	group('LoginCubit Tests', () {
		late MockLoginCubit mockLoginCubit;

		setUp(() {
			mockLoginCubit = MockLoginCubit();
		});

		blocTest<MockLoginCubit, LoginState>(
			'emits [LoginLoading, LoginSuccess] when login is successful',
			build: () => mockLoginCubit,
			act: (cubit) => cubit.login('test@example.com', 'password123'),
			expect: () => [isA<LoginLoading>(), isA<LoginSuccess>()]
		);

		blocTest<MockLoginCubit, LoginState>(
			'emits [LoginLoading, LoginFailure] when login fails',
			build: () => mockLoginCubit,
			act: (cubit) => cubit.login('test@example.com', 'wrongpassword'),
			expect: () => [isA<LoginLoading>(), isA<LoginFailure>()]
		);
	});
}
