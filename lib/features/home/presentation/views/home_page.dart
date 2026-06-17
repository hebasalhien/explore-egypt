import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/home/model/data_sources/home_remote_data_source.dart';
import 'package:explore_egypt/features/home/model/entities/active_plan_model.dart';
import 'package:explore_egypt/features/home/model/repos/home_repository.dart';
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

    final ActivePlanModel activePlanModel = ActivePlanModel(
      planName: 'voyage To Luxor',
      theCurrentDay: 2,
      planDays: 5,
      nextDestination: '14:00 - Karnak Temple',
    );

    return Scaffold(
      backgroundColor: AppColors.kHBGColor,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      body: BlocProvider(
        create: (context) =>
            HomeCubit(HomeRepository(HomeRemoteDataSource()))..getHome(),
        child: Stack(
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
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoaded) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          spacing: 20,
                          children: [
                            const SizedBox(height: 24),
                            HomeCardWidget(
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                            ),
                            CustomRow(
                              onPressed: () {},
                              header: 'Your Active Plan ',
                              label: 'Live Now',
                            ),
                            ActivePlanWidget(activePlanModel: activePlanModel),
                            HorizontalSection(
                              header: 'Trending Expeditions',
                              label: 'view all',
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.trendingPage,
                                  arguments: state.landmarks,
                                );
                              },
                              itemCount: state.landmarks.length.clamp(0, 5),
                              itemHeight: screenHeight * .25,
                              itemBuilder: (context, index) => LandmarkCard(
                                screenHeight: screenHeight * .25,
                                screenWidth: screenWidth,
                                landmark: state.landmarks[index],
                              ),
                            ),
                            HorizontalSection(
                              header: 'Suggested Plans',
                              label: 'view all',
                              onPressed: () {
                                  final homeCubit = context.read<HomeCubit>();

                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.suggestedPlansPage,
                                  arguments: homeCubit.plans,
                                );
                              },
                              itemCount: state.planCardModel.length.clamp(0, 5),
                              itemHeight: screenHeight * .25,
                              itemBuilder: (context, index) => PlanCard(
                                screenHeight: screenHeight,
                                screenWidth: screenWidth,
                                planCardModel: state.planCardModel[index],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).padding.bottom + 20,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
