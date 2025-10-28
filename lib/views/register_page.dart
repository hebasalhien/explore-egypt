import 'package:explore_egypt/services/auth_services.dart';
import 'package:explore_egypt/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(controller: nameController, validator: (value) {}),
            CustomTextField(controller: emailController, validator: (value) {}),

            CustomTextField(controller: passController, validator: (value) {}),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    final message = await AuthServices().createUser(
                      email: emailController.text,
                      password: passController.text,
                      username: nameController.text,
                    );

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message)));
                    //need to handle email already exist
                    Navigator.pop(context);
                  } catch (e) {
                 
                
                  }
                }
              },
              child: Text('sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
