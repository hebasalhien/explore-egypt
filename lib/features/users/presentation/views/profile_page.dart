import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/users/model/repos/user_repository.dart';
import 'package:explore_egypt/features/users/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:explore_egypt/features/users/presentation/views/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBGColor,
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return CircularProgressIndicator();
          } else if (state is ProfileLoaded  ) {
            return ProfileWidget(userModel: state.user);
          } else if (state is ProfileLoadedFaild) {
            return Center(child: Text(state.errorMessage));
          }
          return Center(child: Text('welcome'));
        },
      ),
    );
  }
}
