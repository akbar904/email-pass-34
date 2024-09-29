
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:simple_cubit_app/main.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('Main App Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		testWidgets('App starts with LoginScreen', (WidgetTester tester) async {
			await tester.pumpWidget(
				BlocProvider<AuthCubit>.value(
					value: authCubit,
					child: MyApp(),
				)
			);

			expect(find.text('Login'), findsOneWidget);
			expect(find.byType(LoginScreen), findsOneWidget);
		});

		testWidgets('Navigates to HomeScreen on successful login', (WidgetTester tester) async {
			// Assume the LoginCubit and AuthCubit are properly set up
			await tester.pumpWidget(
				BlocProvider<AuthCubit>.value(
					value: authCubit,
					child: MyApp(),
				)
			);

			when(() => authCubit.state).thenReturn(Authenticated());

			authCubit.emit(Authenticated());
			await tester.pumpAndSettle();

			expect(find.text('Logout'), findsOneWidget);
			expect(find.byType(HomeScreen), findsOneWidget);
		});

		testWidgets('Displays Logout button on HomeScreen', (WidgetTester tester) async {
			await tester.pumpWidget(
				BlocProvider<AuthCubit>.value(
					value: authCubit,
					child: MyApp(),
				)
			);

			when(() => authCubit.state).thenReturn(Authenticated());

			authCubit.emit(Authenticated());
			await tester.pumpAndSettle();

			expect(find.text('Logout'), findsOneWidget);
		});
	});
}
