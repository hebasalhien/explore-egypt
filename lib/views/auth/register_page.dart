import 'package:explore_egypt/utils/validators.dart';
import 'package:explore_egypt/view_models/cubits/auth_cubit/auth_cubit.dart';
import 'package:explore_egypt/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.data['message'])));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: nameController,
                  validator: Validators.validateName,
                ),
                CustomTextField(
                  controller: emailController,
                  validator: Validators.emailValidator,
                ),

                CustomTextField(
                  controller: passController,
                  validator: Validators.passwordValidatore,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthCubit>().register(
                        email: emailController.text,
                        username: nameController.text,
                        password: passController.text,
                      );
                    }
                  },
                  child: Text('sign up'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
