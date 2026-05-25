import 'package:explore_egypt/core/services/location_services.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/home/model/entities/landmark_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:maplibre/maplibre.dart';



class MapPage extends StatefulWidget {
  final List<LandmarkModel>? landmarkModel;
  const MapPage({super.key, this.landmarkModel});


  @override  State<MapPage> createState() => _MapPageState();

}

class _MapPageState extends State<MapPage> {
  final keyMap = dotenv.env['MAPTILER_KEY'];

  MapController? _controller; 

  final _locationService = LocationService(); 


  List<Marker> _buildMarkers() {
    final landmarks = widget.landmarkModel;
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

@override
void initState() {
  super.initState();
  _requestPermission();
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
              initStyle:
                  'https://api.maptiler.com/maps/019e5b83-9d95-791b-be05-28fcc0c224ba/style.json?key=$keyMap',
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
            ],
          ),
          Positioned(
            right: 0,
            bottom: 10,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              child: Column(
                spacing: 10,
                children: [
                  MapButton(
                    icon: Icons.add,
                    onTap: () async {
                      final camera = await _controller?.getCamera();
                      final zome = camera?.zoom ?? 5.0;
                      _controller?.animateCamera(
                        zoom: zome + 1,
                        nativeDuration: const Duration(milliseconds: 300),
                      );
                    },
                  ),
                  MapButton(
                    icon: Icons.remove,
                    onTap: () async {
                      final camera = await _controller?.getCamera();
                      final zome = camera?.zoom ?? 5.0;
                      _controller?.animateCamera(
                        zoom: zome - 1,
                        nativeDuration: const Duration(milliseconds: 300),
                      );
                    },
                  ),
                  MapButton(
                    icon: Icons.location_on_outlined,
                    color: AppColors.kPrimaryColor,
                    onTap: () async {
                      final position = await _locationService
                          .getCurrentPosition();

                      _controller?.animateCamera(
                        center: Geographic(
                          lon:
                              position?.longitude ?? LocationService.defaultLng,
                          lat: position?.latitude ?? LocationService.defaultLat,
                        ),
                        zoom: 12,
                        nativeDuration: const Duration(milliseconds: 500),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MapButton extends StatelessWidget {
  const MapButton({super.key, this.color, required this.icon, this.onTap});
  final Color? color;
  final IconData icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color ?? Color(0xCC2D2D2D),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

class MapMarker extends StatelessWidget {
  const MapMarker({super.key, required this.number});
  final int number;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 52,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 3, color: Colors.white),
              color: const Color(0xffB2001A),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 4,
              height: 12,
              color: const Color(0xffB2001A),
            ),
          ),
        ],
      ),
    );
  }
}
