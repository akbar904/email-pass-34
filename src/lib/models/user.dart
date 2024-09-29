
import 'dart:convert';

class User {
	final String id;
	final String email;
	final String name;

	User({
		required this.id,
		required this.email,
		required this.name,
	});

	factory User.fromJson(Map<String, dynamic> json) {
		return User(
			id: json['id'] as String,
			email: json['email'] as String,
			name: json['name'] as String,
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'id': id,
			'email': email,
			'name': name,
		};
	}

	@override
	bool operator ==(Object other) {
		if (identical(this, other)) return true;

		return other is User &&
			other.id == id &&
			other.email == email &&
			other.name == name;
	}

	@override
	int get hashCode => id.hashCode ^ email.hashCode ^ name.hashCode;
}
