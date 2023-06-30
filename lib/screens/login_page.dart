import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:study_better/provider/jwt_provider.dart';
import 'package:study_better/screens/main_page.dart';
import 'package:study_better/screens/register_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late JwtProvider jwtProvider =
      Provider.of<JwtProvider>(context, listen: false);

  static const urlPrefix = 'http://192.168.1.20:8080/studybetter-api/v0/user';

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('$urlPrefix/login');
      final headers = {"Content-type": "application/json"};
      var username = _usernameController.text;
      var password = _passwordController.text;
      final json = '{"username": "$username", "password": "$password"}';
      Response response = await post(url, headers: headers, body: json);
      print('Status code: ${response.statusCode}');
      print('Body: ${response.body}');
      if (response.statusCode == 200 && response.body.isNotEmpty && context.mounted) {
        Map<String, dynamic> data = jsonDecode(response.body);
        String token = data['token'];
        jwtProvider.setJwt(token);
        Navigator.of(context).pushReplacementNamed(MainPage.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome to Study Better!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Ready to start?",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Username',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username!';
                            } else if (value.length < 4) {
                              return 'Username is too short. Should be at least 4 characters!';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password!';
                            } else if (value.length < 8) {
                              return 'Password is too short. Should be at least 8 characters!';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.deepPurple),
                      onPressed: _signIn,
                      child: const Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(RegisterPage.routeName);
                        },
                        child: const Text(
                          ' Register now',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
