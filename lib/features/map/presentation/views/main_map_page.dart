import 'package:explore_egypt/core/services/api_service.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/widgets/gradient_app_bar.dart';
import 'package:explore_egypt/features/map/model/data_source/map_remote_data_source.dart';
import 'package:explore_egypt/features/map/model/entities/activity_model.dart';
import 'package:explore_egypt/features/map/model/repo/map_repository.dart';
import 'package:explore_egypt/features/map/presentation/views/map/map_page.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/cubit/plan_cubit.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/plan_page.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/no_active_plan.dart';
import 'package:explore_egypt/features/map/presentation/views/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainMapPage extends StatefulWidget {
  final TripModel? trip;

  const MainMapPage({super.key, this.trip});

  @override
  State<MainMapPage> createState() => _MainMapPageState();
}

class _MainMapPageState extends State<MainMapPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late MapRepository mapRepository;
  bool _mapGestureActive = false; // tracks if 2 fingers are on screen

  // Tracks the day currently displayed in the Plan page (0-indexed).
  int _selectedDay = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    mapRepository = MapRepository(MapRemoteDataSource(ApiService.instance));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => MapCubit()),
        BlocProvider(
          create: (context) => PlanCubit(mapRepository)..getActivePlan(),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.kPlanPageBgColor,
          appBar: GradientAppBar(
            bottom: CustomTabBar(controller: _tabController),
          ),
          body: TabBarView(
            controller: _tabController,
            // Disable swipe only when 2 fingers are on the map
            physics: _mapGestureActive
                ? const NeverScrollableScrollPhysics()
                : const ScrollPhysics(),
            children: [
              PlanPage(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                onDayChanged: (index) {
                  setState(() => _selectedDay = index);
                },
              ),
              // Wrap map in Listener to detect finger count
              Listener(
                onPointerDown: (event) {
                  // when any touch happens, check active pointers
                  setState(() => _mapGestureActive = true);
                },
                onPointerUp: (event) {
                  setState(() => _mapGestureActive = false);
                },
                onPointerCancel: (event) {
                  setState(() => _mapGestureActive = false);
                },
                child: widget.trip != null
                    ? MapPage(
                        activityModel:
                            widget.trip!.dayModel[_selectedDay].activity,
                        dayNumber: _selectedDay + 1,
                        planTitle: widget.trip!.title,
                      )
                    : MapPage(
                        activityModel: const <ActivityModel>[],
                        dayNumber: 1,
                        planTitle: '',
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
