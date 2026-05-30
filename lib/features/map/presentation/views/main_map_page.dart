import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/widgets/gradient_app_bar.dart';
import 'package:explore_egypt/features/home/model/entities/landmark_model.dart';
import 'package:explore_egypt/features/map/presentation/views/map/map_page.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/map/widgets/map_bottom_sheet.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/plan_page.dart';
import 'package:explore_egypt/features/map/presentation/views/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';

class MainMapPage extends StatefulWidget {
  final TripModel? trip;
  const MainMapPage({super.key, this.trip});

  @override
  State<MainMapPage> createState() => _MainMapPageState();
}

class _MainMapPageState extends State<MainMapPage>
    with SingleTickerProviderStateMixin {
      final List<LandmarkModel> fakeLandmarks = [
  LandmarkModel(
    name: 'Pyramids of Giza',
    subtitle: 'Ancient wonder of the world',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Kheops-Pyramid.jpg/800px-Kheops-Pyramid.jpg',
    lat: 29.9792,
    lng: 31.1342,
  ),
  LandmarkModel(
    name: 'Egyptian Museum',
    subtitle: 'Home of ancient Egyptian artifacts',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Egyptian_Museum.jpg/800px-Egyptian_Museum.jpg',
    lat: 30.0478,
    lng: 31.2336,
  ),
  LandmarkModel(
    name: 'Luxor Temple',
    subtitle: 'Ancient temple on the Nile',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Luxor_temple.jpg/800px-Luxor_temple.jpg',
    lat: 25.6997,
    lng: 32.6392,
  ),
  LandmarkModel(
    name: 'Abu Simbel',
    subtitle: 'Rock temples of Ramesses II',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Abu_Simbel%2C_Egypt.jpg/800px-Abu_Simbel%2C_Egypt.jpg',
    lat: 22.3372,
    lng: 31.6258,
  ),
  LandmarkModel(
    name: 'Karnak Temple',
    subtitle: 'Largest ancient religious site',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Karnak_temple.jpg/800px-Karnak_temple.jpg',
    lat: 25.7188,
    lng: 32.6573,
  ),
  LandmarkModel(
    name: 'Alexandria Library',
    subtitle: 'Modern revival of ancient library',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Biblioth%C3%A8que_d%27Alexandrie.jpg/800px-Biblioth%C3%A8que_d%27Alexandrie.jpg',
    lat: 31.2089,
    lng: 29.9092,
  ),
];
  late TabController _tabController;
  bool _mapGestureActive = false; // tracks if 2 fingers are on screen

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    if(_tabController.index == 1 && !_tabController.indexIsChanging){
      showModalBottomSheet(context: context, builder: (_) => MapBottomSheet(),isScrollControlled: true,showDragHandle: true,);
    }
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
          // Disable swipe only when 2 fingers are on the map
          physics: _mapGestureActive
              ? const NeverScrollableScrollPhysics()
              : const ScrollPhysics(),
          children: [
            PlanPage(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              trip: widget.trip,
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
              child: MapPage(landmarkModel: fakeLandmarks),
            ),
          ],
        ),
      ),
    );
  }
}
