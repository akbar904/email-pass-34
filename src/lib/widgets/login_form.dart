
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_cubit_app/cubits/login_cubit.dart';

class LoginForm extends StatefulWidget {
	@override
	_LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
	final _emailController = TextEditingController();
	final _passwordController = TextEditingController();

	@override
	Widget build(BuildContext context) {
		return BlocListener<LoginCubit, LoginState>(
			listener: (context, state) {
				if (state is LoginError) {
					ScaffoldMessenger.of(context).showSnackBar(
						SnackBar(content: Text(state.message)),
					);
				}
			},
			child: Column(
				children: [
					TextField(
						key: Key('emailField'),
						controller: _emailController,
						decoration: InputDecoration(labelText: 'Email'),
					),
					TextField(
						key: Key('passwordField'),
						controller: _passwordController,
						decoration: InputDecoration(labelText: 'Password'),
						obscureText: true,
					),
					ElevatedButton(
						onPressed: () {
							final email = _emailController.text;
							final password = _passwordController.text;
							context.read<LoginCubit>().login(email, password);
						},
						child: Text('Login'),
					),
				],
			),
		);
	}

	@override
	void dispose() {
		_emailController.dispose();
		_passwordController.dispose();
		super.dispose();
	}
}
