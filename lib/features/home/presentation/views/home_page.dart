import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:explore_egypt/features/home/presentation/cubit/home_cubit.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/active_plan_widget.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/custom_row.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/home_card_widget.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/horizontal_section.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/landmark_card.dart';
import 'package:explore_egypt/core/widgets/custom_app_bar_background.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/plan_card.dart';
import 'package:explore_egypt/routes/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final double appBarHeight =
        AppBar().preferredSize.height + MediaQuery.of(context).padding.top;
    final double expandedHeight = screenHeight * .28;

    final double scrollOffset = _scrollController.hasClients
        ? _scrollController.offset
        : 0;
    final double gradientHeight = (expandedHeight - scrollOffset).clamp(
      appBarHeight,
      expandedHeight,
    );

    return Scaffold(
      backgroundColor: AppColors.kHBGColor,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, homeState) {
          return BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, favState) {
              if (homeState is HomeError || favState is FavoritesError) {
                return HomeBaseWidget(
                  scrollController: _scrollController,
                  appBarHeight: appBarHeight,
                  gradientHeight: gradientHeight,
                  child: Column(
                    spacing: 20,
                    children: [
                      SizedBox(height: 24),
                      HomeCardWidget(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                      Center(
                        child: Text(
                          homeState is HomeError
                              ? 'Home Error'
                              : favState is FavoritesError
                              ? favState.message
                              : 'Error',
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (homeState is HomeLoaded && favState is FavoritesLoaded) {
                return HomeBaseWidget(
                  gradientHeight: gradientHeight,
                  appBarHeight: appBarHeight,
                  scrollController: _scrollController,
                  child: HomeLoadedWidget(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    homeState: homeState,
                  ),
                );
              }
              return HomeBaseWidget(
                scrollController: _scrollController,
                appBarHeight: appBarHeight,
                gradientHeight: gradientHeight,
                child: Column(
                  spacing: 20,
                  children: [
                    SizedBox(height: 24),
                    HomeCardWidget(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      period: Duration(seconds: 2),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .9,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 20,
                                  width: 150,
                                  color: Colors.grey[300],
                                ),

                                Container(
                                  height: 16,
                                  width: 60,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 225,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 2,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 220,
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 6,
                                    ), // Added horizontal gap between blocks
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(
                                        16,
                                      ), // Matches your app's smooth card style
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class HomeBaseWidget extends StatelessWidget {
  const HomeBaseWidget({
    super.key,
    required this.gradientHeight,
    required this.appBarHeight,
    required ScrollController scrollController,
    required this.child,
  }) : _scrollController = scrollController;

  final double gradientHeight;
  final double appBarHeight;
  final ScrollController _scrollController;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ── ONLY CHANGE: height now shrinks with scroll ──
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: gradientHeight,
            child: AppBarBackground(
              colors: [AppColors.kPrimaryColor, AppColors.kSecondary],
              r1: 0,
            ),
          ),
        ),

        // ── EXACTLY AS YOUR ORIGINAL ──
        Positioned.fill(
          top: appBarHeight,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}

class HomeLoadedWidget extends StatelessWidget {
  const HomeLoadedWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.homeState,
  });

  final double screenHeight;
  final double screenWidth;
  final HomeLoaded homeState;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        const SizedBox(height: 24),
        HomeCardWidget(screenHeight: screenHeight, screenWidth: screenWidth),
        if (homeState.activePlanModel != null &&
            homeState.activePlanModel!.isNotEmpty)
          Column(
            children: [
              CustomRow(
                onPressed: () {},
                header: 'Your Active Plan ',
                label: 'Live Now',
              ),
              ActivePlanWidget(activePlanModel: homeState.activePlanModel!),
            ],
          ),
        HorizontalSection(
          header: 'Trending Expeditions',
          label: 'view all',
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.trendingPage,
              arguments: homeState.landmarks,
            );
          },
          itemCount: homeState.landmarks.length.clamp(0, 5),
          itemHeight: screenHeight * .25,
          itemBuilder: (context, index) => LandmarkCard(
            screenHeight: screenHeight * .25,
            screenWidth: screenWidth,
            landmark: homeState.landmarks[index],
          ),
        ),
        HorizontalSection(
          header: 'Suggested Plans',
          label: 'view all',
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.suggestedPlansPage,
              arguments: homeState.planCardModel,
            );
          },
          itemCount: homeState.planCardModel.length.clamp(0, 5),
          itemHeight: screenHeight * .25,
          itemBuilder: (context, index) => PlanCard(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            planCardModel: homeState.planCardModel[index],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
      ],
    );
  }
}
