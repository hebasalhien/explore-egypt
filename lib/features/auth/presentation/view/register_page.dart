import 'package:explore_egypt/core/services/auth_services.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/utils/validators.dart';
import 'package:explore_egypt/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:explore_egypt/features/widgets/background.dart';
import 'package:explore_egypt/features/widgets/custom_button.dart';
import 'package:explore_egypt/features/widgets/custom_password_text_field.dart';
import 'package:explore_egypt/features/widgets/custom_text_field.dart';
import 'package:explore_egypt/features/widgets/custom_wave_shape.dart';
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
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    confirmPassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: BlocProvider(
        create: (context) => AuthCubit(AuthServices()),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthRegisterSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.data['message'])));
        
              Navigator.pop(context);
            } else if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                BackGround(),
                CustomWaveShape(),
                SingleChildScrollView(
                  child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
              ),
                                  child: Form(
                      key: formKey,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 20,
                          children: [
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 30,
                                color: AppColors.kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CustomTextField(
                              controller: nameController,
                              validator: Validators.validateName,
                              label: 'User name',
                            ),
                            CustomTextField(
                              controller: emailController,
                              validator: Validators.emailValidator,
                              label: 'Email',
                            ),
                                
                            CustomPasswordTextField(controller: passController),
                            CustomPasswordTextField(
                              controller: confirmPassController,
                              validator: (value) =>
                                  Validators.validatePassConfirm(
                                    value,
                                    passController.text,
                                  ),
                              label: 'Confirm Password',
                            ),
                                
                            CustomButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await context.read<AuthCubit>().register(
                                    email: emailController.text,
                                    username: nameController.text,
                                    password: passController.text,
                                  );
                                }
                              },
                              label: 'Sign Up',
                            ),
                                
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('I already have an account?'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: AppColors.kPrimaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
