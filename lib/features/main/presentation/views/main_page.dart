import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';
import 'package:explore_egypt/features/chat/model/data_sources/chat_remote_data_source.dart';
import 'package:explore_egypt/features/chat/model/repos/chat_repository.dart';
import 'package:explore_egypt/features/chat/presentation/views/chat_page.dart';
import 'package:explore_egypt/features/home/presentation/views/home_page.dart';
import 'package:explore_egypt/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:explore_egypt/features/main/presentation/views/widgets/custom_navigation_destination.dart';
import 'package:explore_egypt/features/map/presentation/views/main_map_page.dart';
import 'package:explore_egypt/features/users/model/data_sources/user_remote_data_source.dart';
import 'package:explore_egypt/features/users/model/repos/user_repository.dart';
import 'package:explore_egypt/features/users/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:explore_egypt/features/users/presentation/views/profile_page.dart';
import 'package:explore_egypt/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<bool> _initialized = [true, false, false, false];

  // Add navigator keys for each tab
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

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
          return PopScope(
            // Handle back button: pop within tab instead of exiting
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              final navState = _navigatorKeys[state.index].currentState;
              if (navState != null && navState.canPop()) {
                navState.pop();
              }
            },
            child: Scaffold(
              body: IndexedStack(
                index: state.index,
                children: [
                  // Tab 0 - Home
                  Navigator(
                    key: _navigatorKeys[0],
                    onGenerateRoute: (settings) {
                      // Initial route: always show HomePage
                      if (settings.name == Navigator.defaultRouteName) {
                        return MaterialPageRoute(
                          builder: (_) => _initialized[0]
                              ? const HomePage()
                              : const SizedBox.shrink(),
                        );
                      }
                      // Any other named route (e.g. trendingPage) → AppRoutes
                      // This keeps the bottom nav bar visible
                      return AppRoutes.onGenerateRoute(settings);
                    },
                  ),

                  // Tab 1 - Chat
                  Navigator(
                    key: _navigatorKeys[1],
                    onGenerateRoute: (_) => MaterialPageRoute(
                      builder: (_) => _initialized[1]
                          ? RepositoryProvider(
                              create: (context) =>
                                  ChatRepository(ChatRemoteDataSource(ApiService.instance)),
                              child: ChatPage(),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),

                  // Tab 2 - Map
                  Navigator(
                    key: _navigatorKeys[2],
                    onGenerateRoute: (_) => MaterialPageRoute(
                      builder: (routeContext) =>
                          BlocBuilder<NavigationCubit, NavigationState>(
                            builder: (context, navState) {
                              return _initialized[2]
                                  ? MainMapPage(trip: navState.trip)
                                  : const SizedBox.shrink();
                            },
                          ),
                    ),
                  ),

                  // Tab 3 - Profile
                  // Navigator(
                  //   key: _navigatorKeys[3],
                  //   onGenerateRoute: (settings) {
                  //     if (settings.name == Navigator.defaultRouteName) {
                  //       return MaterialPageRoute(
                  //         builder: (_) => _initialized[3]
                  //             ? RepositoryProvider(
                  //                 create: (context) =>
                  //                     UserRepository(UserRemoteDataSource()),
                  //                 child: BlocProvider(
                  //                   create: (context) => ProfileCubit(
                  //                      context.read<UserRepository>(),
                  //                   )..getUserData(),
                  //                   child: ProfilePage(),
                  //                 ),
                  //               )
                  //             : const SizedBox.shrink(),
                  //       );
                  //     }
                  //     // Any other named route (e.g. trendingPage) → AppRoutes
                  //     // This keeps the bottom nav bar visible
                  //     return AppRoutes.onGenerateRoute(settings);
                  //   },
                  // ),
                  // Tab 3 - Profile
RepositoryProvider(
  create: (_) => UserRepository(UserRemoteDataSource(ApiService.instance)),
  child: BlocProvider(
    create: (context) => ProfileCubit(
      context.read<UserRepository>(),
    )..getUserData(),
    child: Navigator(
      key: _navigatorKeys[3],
      onGenerateRoute: (settings) {
        if (settings.name == Navigator.defaultRouteName) {
          return MaterialPageRoute(
            builder: (_) => _initialized[3]
                ? const ProfilePage()
                : const SizedBox.shrink(),
          );
        }

        return AppRoutes.onGenerateRoute(settings);
      },
    ),
  ),
),
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
            ),
          );
        },
      ),
    );
  }
}
