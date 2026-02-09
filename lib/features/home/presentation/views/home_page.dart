import 'package:explore_egypt/core/session/cubit/session_cubit.dart';
import 'package:explore_egypt/routes/app_routes.dart';
import 'package:explore_egypt/features/widgets/custom_button.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(onPressed: () {
        context.read<SessionCubit>().endSession();
        Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
      }, label: 'logout'),
    );
  }
}
