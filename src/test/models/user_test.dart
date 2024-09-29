
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_cubit_app/models/user.dart';

void main() {
	group('User Model Tests', () {
		test('User model should serialize from JSON correctly', () {
			final userJson = {
				'id': '123',
				'email': 'test@example.com',
				'name': 'Test User'
			};

			final user = User.fromJson(userJson);

			expect(user.id, '123');
			expect(user.email, 'test@example.com');
			expect(user.name, 'Test User');
		});

		test('User model should serialize to JSON correctly', () {
			final user = User(id: '123', email: 'test@example.com', name: 'Test User');

			final userJson = user.toJson();

			expect(userJson, {
				'id': '123',
				'email': 'test@example.com',
				'name': 'Test User'
			});
		});

		test('User model should have correct props for equality', () {
			final user1 = User(id: '123', email: 'test@example.com', name: 'Test User');
			final user2 = User(id: '123', email: 'test@example.com', name: 'Test User');

			expect(user1, equals(user2));
		});
	});
}
