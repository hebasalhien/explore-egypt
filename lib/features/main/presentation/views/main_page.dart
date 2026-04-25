import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/features/chat/model/data_sources/chat_remote_data_source.dart';
import 'package:explore_egypt/features/chat/model/repos/chat_repository.dart';
import 'package:explore_egypt/features/chat/presentation/views/chat_page.dart';
import 'package:explore_egypt/features/home/presentation/views/home_page.dart';
import 'package:explore_egypt/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:explore_egypt/features/main/presentation/views/widgets/custom_navigation_destination.dart';
import 'package:explore_egypt/features/map/presentation/views/main_map_page.dart';
import 'package:explore_egypt/features/users/model/data_sources/user_remote_data_source.dart';
import 'package:explore_egypt/features/users/model/repos/user_repository.dart';
import 'package:explore_egypt/features/users/presentation/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<bool> _initialized = [
    true,
    false,
    false,
    false,
  ]; // Home is shown first
  final List<Widget> _pages = [
    HomePage(),
    RepositoryProvider(
      create: (context) => ChatRepository(ChatRemoteDataSource()),
      child: ChatPage(),
    ),
    MainMapPage(),
    RepositoryProvider(
      create: (context) => UserRepository(UserRemoteDataSource()),
      child: ProfilePage(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocConsumer<NavigationCubit, int>(
        listener: (context, selectedIndex) {
          setState(() {
            _initialized[selectedIndex] = true;
          });
        },
        builder: (context, selectedIndex) {
          return Scaffold(
            body: IndexedStack(
              index: selectedIndex,
              children: List.generate(_pages.length, (index) {
                if (!_initialized[index]) {
                  return const SizedBox.shrink();
                }
                return _pages[index];
              }),
            ),
            bottomNavigationBar: NavigationBar(
              destinations: [
                CustomNavigationDestination(
                  label: 'Home',
                  icon: AppConstants.homeIcon,
                ),
                CustomNavigationDestination(
                  label: 'Chatbot',
                  icon: AppConstants.chatIcon,
                ),
                CustomNavigationDestination(
                  label: 'Map',
                  icon: AppConstants.mapIcon,
                ),
                CustomNavigationDestination(
                  label: 'Profile',
                  icon: AppConstants.profileIcon,
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                context.read<NavigationCubit>().switchTab(index);
              },
            ),
          );
        },
      ),
    );
  }
}
