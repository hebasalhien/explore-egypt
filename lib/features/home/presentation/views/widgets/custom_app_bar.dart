import 'package:explore_egypt/core/session/cubit/session_cubit.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        final username = state is SessionAuthenticated ? state.username : '...';
        final imageUrl = state is SessionAuthenticated ? state.imageUrl : null;
        return AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          scrolledUnderElevation: 0,
          leadingWidth: 70,
          leading: UserAvatar(imageUrl: imageUrl,),
          titleSpacing: 0,
          title: Text(
            'Welcome back, $username!',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontFamily: GoogleFonts.notoSerif().fontFamily,
              color: AppColors.kWhite,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_none, color: AppColors.kWhite),
            ),
          ],
        );
      },
    );
  }
}
