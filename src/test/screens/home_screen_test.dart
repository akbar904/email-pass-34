
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cubit_app/screens/home_screen.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart';

class MockAuthCubit extends MockCubit<void> implements AuthCubit {}

void main() {
	group('HomeScreen', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		testWidgets('displays logout button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => authCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('calls logout on AuthCubit when logout button is pressed', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => authCubit,
						child: HomeScreen(),
					),
				),
			);

			final logoutButton = find.text('Logout');
			expect(logoutButton, findsOneWidget);

			await tester.tap(logoutButton);
			await tester.pump();

			verify(() => authCubit.logout()).called(1);
		});
	});
}
