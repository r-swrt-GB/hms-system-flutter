import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hms_system_application/models/user.dart';
import 'package:hms_system_application/providers/auth_provider.dart';
import 'package:hms_system_application/providers/user_provider.dart';
import 'package:hms_system_application/services/api_service.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthProvider get authProvider => context.read<AuthProvider>();
  ApiService apiService = ApiService();
  UserProvider userProvider = UserProvider();

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      authProvider.login(_emailController.text, _passwordController.text);
      String? token = authProvider.token;

      if (token != null) {
        Response userResponse = await authProvider.refreshUser();

        User user = User.fromJson(userResponse.data['data']);
        userProvider.storeUserDetails(user);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _signIn,
                child: Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
