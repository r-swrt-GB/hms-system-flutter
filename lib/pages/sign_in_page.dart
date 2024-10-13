import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hms_system_application/components/input_password_field.dart';
import 'package:hms_system_application/components/input_textfield_component.dart';
import 'package:hms_system_application/methods/validation_methods.dart';
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
      await authProvider
          .login(_emailController.text, _passwordController.text)
          .then((value) async {
        String? token = authProvider.token;

        if (token != null) {
          Response userResponse = await authProvider.refreshUser();

          User user = User.fromJson(userResponse.data);
          userProvider.storeUserDetails(user);

          Navigator.of(context, rootNavigator: true)
              .pushReplacementNamed('/central');
          print('Want to go to central page instace 2');
        }
      });
    }
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      title: const Text('Sign In'),
      elevation: 0,
      backgroundColor: Colors.grey[100],
    );
  }

  Widget buildEmailField() {
    return InputTextField(
      inputControllerEmail: _emailController,
      hintText: "Email",
      onTap: null,
      readOnly: false,
      icon: Icons.person,
      validator: (value) => emailValidator(value),
    );
  }

  Widget buildPasswordField() {
    return InputPasswordTextField(
      hintText: "Password",
      inputControllerPassword: _passwordController,
      icon: Icons.lock,
      validator: (value) => passwordValidator(value),
    );
  }

  Widget BuildSignInButton() {
    return ElevatedButton(
      onPressed: _signIn,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        minimumSize: const Size(40, 50),
      ),
      child: const Text('Sign In'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              buildEmailField(),
              const SizedBox(height: 30),
              buildPasswordField(),
              const Spacer(),
              BuildSignInButton(),
            ],
          ),
        ),
      ),
    );
  }
}
