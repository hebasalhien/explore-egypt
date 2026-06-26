import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/widgets/gradient_app_bar.dart';
import 'package:explore_egypt/features/map/presentation/views/map/map_page.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/cubit/plan_cubit.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/plan_page.dart';
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
  bool _mapGestureActive = false;
  int _selectedDay = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // ✅ If opened with a trip (from home/suggestions), save it via the
    //    shared PlanCubit that was provided by MainPage.
    if (widget.trip != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<PlanCubit>().savePlan(trip: widget.trip!);
      });
    }
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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.kPlanPageBgColor,
        appBar: GradientAppBar(
          bottom: CustomTabBar(controller: _tabController),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: _mapGestureActive
              ? const NeverScrollableScrollPhysics()
              : const ScrollPhysics(),
          children: [
            PlanPage(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              selectedDay: _selectedDay,
              onDayChanged: (index) {
                setState(() => _selectedDay = index);
              },
            ),
            Listener(
              onPointerDown: (event) {
                setState(() => _mapGestureActive = true);
              },
              onPointerUp: (event) {
                setState(() => _mapGestureActive = false);
              },
              onPointerCancel: (event) {
                setState(() => _mapGestureActive = false);
              },
              child: BlocBuilder<PlanCubit, PlanState>(
                buildWhen: (previous, current) =>
                    current is GetActivePlanSuccess ||
                    current is PlanLoaded ||
                    current is NoActivePlan,
                builder: (context, state) {
                  TripModel? activeTripForMap;
                  if (state is GetActivePlanSuccess) {
                    activeTripForMap = state.activePlan;
                  } else if (state is PlanLoaded) {
                    activeTripForMap = state.trip;
                  } else {
                    activeTripForMap = context.read<PlanCubit>().currentTrip;
                  }
                  return activeTripForMap != null
                      ? MapPage(
                          activityModel:
                              activeTripForMap.dayModel[_selectedDay].activity,
                          dayNumber: _selectedDay + 1,
                          planTitle: activeTripForMap.title,
                        )
                      : MapPage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
