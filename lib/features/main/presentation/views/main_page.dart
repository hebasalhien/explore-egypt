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
  // _pages is removed as we will construct them dynamically in the builder
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocConsumer<NavigationCubit, NavigationState>(
        listener: (context, state) {
          setState(() {
            _initialized[state.index] = true;
          });
        },
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.index,
              children: [
                _initialized[0] ? HomePage() : const SizedBox.shrink(),
                _initialized[1]
                    ? RepositoryProvider(
                        create: (context) => ChatRepository(ChatRemoteDataSource()),
                        child: ChatPage(),
                      )
                    : const SizedBox.shrink(),
                _initialized[2] ? MainMapPage(trip: state.trip) : const SizedBox.shrink(),
                _initialized[3]
                    ? RepositoryProvider(
                        create: (context) => UserRepository(UserRemoteDataSource()),
                        child: ProfilePage(),
                      )
                    : const SizedBox.shrink(),
              ],
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
              selectedIndex: state.index,
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
