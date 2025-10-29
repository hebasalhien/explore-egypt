import 'package:explore_egypt/services/auth_services.dart';
import 'package:explore_egypt/services/token_storage_services.dart';
import 'package:explore_egypt/views/home_page.dart';
import 'package:explore_egypt/views/register_page.dart';
import 'package:explore_egypt/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 40,
          children: [
            CustomTextField(
              controller: emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'required field';
                }
                return null;
              },
            ),
            CustomTextField(
              controller: passController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'required field ';
                }
                return null;
              },
              isObscure: true,
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    Map<String, dynamic> data = await AuthServices().login(
                      email: emailController.text,
                      password: passController.text,
                    );
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(data['message'])));

                  
                  } catch (e) {
                      throw Exception('Exception $e.');

                  }
                }
              },
              child: Text('Login'),
            ),
            Row(
              children: [
                Text('don\'t have account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return RegisterPage();
                        },
                      ),
                    );
                  },
                  child: Text('Sign up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
