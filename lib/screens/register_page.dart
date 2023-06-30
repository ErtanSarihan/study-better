import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:study_better/screens/login_page.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = 'register';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  static const urlPrefix = 'http://192.168.1.20:8080/studybetter-api/v0/user';

  Future<void> _register() async {
    if(_formKey.currentState!.validate()){
      final url = Uri.parse('$urlPrefix/register');
      final headers = {"Content-type": "application/json"};
      var username = _usernameController.text;
      var password = _passwordController.text;
      final json = '{"username": "$username", "password": "$password"}';
      Response response = await post(url, headers: headers, body: json);
      print('Status code: ${response.statusCode}');
      print('Body: ${response.body}');
      if(response.body == 'true' && response.statusCode == 200 && context.mounted){
        Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
      }
      // geçiş yumuşatılabilir mi ?
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
                    "Haven't registered yet?",
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                            controller: _repeatPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirm Password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please re-enter your password!';
                              } else if (value != _passwordController.text) {
                                return "Password does not match!";
                              }
                              return null;
                            }),
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
                        onPressed: _register,
                        child: const Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
