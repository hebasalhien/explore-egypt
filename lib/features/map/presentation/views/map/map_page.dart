import 'package:explore_egypt/core/config/app_config.dart';
import 'package:explore_egypt/core/services/location_services.dart';
import 'package:explore_egypt/features/map/model/entities/activity_model.dart';
import 'package:explore_egypt/features/map/presentation/views/map/widgets/map_bottom_sheet.dart';
import 'package:explore_egypt/features/map/presentation/views/map/widgets/map_controllers_buttons.dart';
import 'package:explore_egypt/features/map/presentation/views/map/widgets/map_marker.dart';
import 'package:explore_egypt/features/map/presentation/views/map/widgets/user_position_marker.dart';
import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:geolocator/geolocator.dart' as geo;

class MapPage extends StatefulWidget {
  final List<ActivityModel>? activityModel;
  final int dayNumber;
  final String planTitle;
  const MapPage({
    super.key,
    this.activityModel,
    required this.dayNumber,
    required this.planTitle,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController? _controller;

  final _locationService = LocationService();

  List<Marker> _buildMarkers() {
    final landmarks = widget.activityModel;
    if (landmarks == null || landmarks.isEmpty) return [];

    return landmarks
        .asMap()
        .entries
        .map(
          (entry) => Marker(
            point: Geographic(lon: entry.value.lng, lat: entry.value.lat),
            size: const Size(42, 52),
            alignment: Alignment.bottomCenter,
            child: MapMarker(number: entry.key + 1),
          ),
        )
        .toList();
  }

  late Future<geo.Position?> _positionFuture;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _positionFuture = _locationService.getCurrentPosition();
  }

  Future<void> _requestPermission() async {
    final granted = await _locationService.requestPermission();
    if (!granted) {
      debugPrint('Location permission not granted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapLibreMap(
            onMapCreated: (controller) {
              _controller = controller;
              debugPrint(_controller.toString());
            },
            options: MapOptions(
              initCenter: Geographic(
                lon: LocationService.defaultLng,
                lat: LocationService.defaultLat,
              ),
              initStyle: AppConfig.mapStyle,
              initZoom: 6,
              gestures: MapGestures(
                rotate: true,
                pan: true,
                zoom: true,
                pitch: true,
              ),
            ),
            children: [
              WidgetLayer(markers: _buildMarkers(), allowInteraction: true),
              FutureBuilder(
                future: _positionFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final pos = snapshot.data!;
                    return WidgetLayer(
                      markers: [
                        Marker(
                          point: Geographic(
                            lon: pos.longitude,
                            lat: pos.latitude,
                          ),
                          child: UserPositionMarker(),
                          size: Size(20, 20),
                        ),
                      ],
                      allowInteraction: false,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom:
                widget.activityModel != null && widget.activityModel!.isNotEmpty
                ? 240
                : 20,
            child: MapControllersButtons(
              controller: _controller,
              locationService: _locationService,
            ),
          ),
          if (widget.activityModel != null && widget.activityModel!.isNotEmpty)
            MapBottomSheet(
              dayNumber: widget.dayNumber,
              planTitle: widget.planTitle,
              activityModel: widget.activityModel!,
            ),
        ],
      ),
    );
  }
}
