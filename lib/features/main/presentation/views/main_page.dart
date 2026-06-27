import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';
import 'package:explore_egypt/core/session/cubit/session_cubit.dart';
import 'package:explore_egypt/features/chat/model/data_sources/chat_remote_data_source.dart';
import 'package:explore_egypt/features/chat/model/repos/chat_repository.dart';
import 'package:explore_egypt/features/chat/presentation/views/chat_page.dart';
import 'package:explore_egypt/features/favorites/model/data_source/favorites_remote_data_source.dart';
import 'package:explore_egypt/features/favorites/model/repo/favorites_repo.dart';
import 'package:explore_egypt/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:explore_egypt/features/home/model/data_sources/home_remote_data_source.dart';
import 'package:explore_egypt/features/home/model/repos/home_repository.dart';
import 'package:explore_egypt/features/home/presentation/cubit/home_cubit.dart';
import 'package:explore_egypt/features/home/presentation/views/home_page.dart';
import 'package:explore_egypt/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:explore_egypt/features/main/presentation/views/widgets/custom_navigation_destination.dart';
import 'package:explore_egypt/features/map/model/data_source/map_remote_data_source.dart';
import 'package:explore_egypt/features/map/model/repo/map_repository.dart';
import 'package:explore_egypt/features/map/presentation/views/main_map_page.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/cubit/plan_cubit.dart';
import 'package:explore_egypt/features/plans/model/data_source/suggested_plans_remote_data_source.dart';
import 'package:explore_egypt/features/plans/model/repo/suggested_plans_repo.dart';
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

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  // ✅ PlanCubit lives here so MainPage can read its state for back handling
  late final PlanCubit _planCubit;

  @override
  void initState() {
    super.initState();
    final mapRepository = MapRepository(MapRemoteDataSource(ApiService.instance));
    final suggestedPlansRepo = SuggestedPlansRepo(SuggestedPlansRemoteDataSource(ApiService.instance));
    _planCubit = PlanCubit(mapRepository, suggestedPlansRepo)..getActivePlan();
  }

  @override
  void dispose() {
    _planCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(
          create: (context) => FavoritesCubit(
            FavoritesRepo(FavoritesRemoteDataSource(ApiService.instance)),
          )..loadFavorites(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(
            HomeRepository(HomeRemoteDataSource(ApiService.instance)),
          )..getHome(),
        ),
        // ✅ Provide PlanCubit at this level so both MainPage and MainMapPage share it
        BlocProvider.value(value: _planCubit),
      ],
      child: BlocConsumer<NavigationCubit, NavigationState>(
        listener: (context, state) {
          setState(() {
            _initialized[state.index] = true;
          });

          if (state.trip != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _navigatorKeys[2].currentState?.push(
                MaterialPageRoute(
                  builder: (_) => MainMapPage(trip: state.trip),
                ),
              );
              context.read<NavigationCubit>().clearTrip();
            });
          }
        },
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              // ✅ If on map tab and cubit is in PlanLoaded, intercept and go back
              if (state.index == 2 && _planCubit.state is PlanLoaded) {
                _planCubit.goBackToPlans();
                return;
              }
              // Otherwise default behaviour: pop within the tab's navigator
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
                      if (settings.name == Navigator.defaultRouteName) {
                        return MaterialPageRoute(
                          builder: (_) => _initialized[0]
                              ? const HomePage()
                              : const SizedBox.shrink(),
                        );
                      }
                      return AppRoutes.onGenerateRoute(settings);
                    },
                  ),

                  // Tab 1 - Chat
                  Navigator(
                    key: _navigatorKeys[1],
                    onGenerateRoute: (_) => MaterialPageRoute(
                      builder: (_) => _initialized[1]
                          ? RepositoryProvider(
                              create: (context) => ChatRepository(
                                ChatRemoteDataSource(ApiService.instance),
                              ),
                              child: ChatPage(),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),

                  // Tab 2 - Map
                  // ✅ PlanCubit is already provided above via BlocProvider.value
                  //    MainMapPage no longer creates its own PlanCubit
                  Navigator(
                    key: _navigatorKeys[2],
                    onGenerateRoute: (_) => MaterialPageRoute(
                      builder: (_) => _initialized[2]
                          ? const MainMapPage()
                          : const SizedBox.shrink(),
                    ),
                  ),

                  // Tab 3 - Profile
                  RepositoryProvider(
                    create: (_) => UserRepository(
                      UserRemoteDataSource(ApiService.instance),
                    ),
                    child: BlocProvider(
                      create: (context) => ProfileCubit(
                        context.read<UserRepository>(),
                        context.read<SessionCubit>(),
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