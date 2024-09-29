
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_cubit_app/widgets/login_form.dart';
import 'package:com.example.simple_cubit_app/cubits/login_cubit.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginForm Widget Tests', () {
		late MockLoginCubit mockLoginCubit;

		setUp(() {
			mockLoginCubit = MockLoginCubit();
		});

		testWidgets('should display email and password TextFields', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<LoginCubit>.value(
							value: mockLoginCubit,
							child: LoginForm(),
						),
					),
				),
			);

			expect(find.byType(TextField), findsNWidgets(2));
			expect(find.byType(ElevatedButton), findsOneWidget);
		});

		testWidgets('should display error message when state is LoginError', (WidgetTester tester) async {
			const errorMessage = 'Invalid credentials';

			whenListen(
				mockLoginCubit,
				Stream.fromIterable([LoginError(errorMessage)]),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<LoginCubit>.value(
							value: mockLoginCubit,
							child: LoginForm(),
						),
					),
				),
			);

			await tester.pump();

			expect(find.text(errorMessage), findsOneWidget);
		});

		testWidgets('should call login method when button is pressed', (WidgetTester tester) async {
			when(() => mockLoginCubit.login(any(), any())).thenAnswer((_) async {});

			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<LoginCubit>.value(
							value: mockLoginCubit,
							child: LoginForm(),
						),
					),
				),
			);

			final emailField = find.byKey(Key('emailField'));
			final passwordField = find.byKey(Key('passwordField'));
			final loginButton = find.byType(ElevatedButton);

			await tester.enterText(emailField, 'test@example.com');
			await tester.enterText(passwordField, 'password');
			await tester.tap(loginButton);

			verify(() => mockLoginCubit.login('test@example.com', 'password')).called(1);
		});
	});
}
