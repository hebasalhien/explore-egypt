import 'package:explore_egypt/core/services/location_services.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/map/presentation/views/map/widgets/map_button.dart';
import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

class MapControllersButtons extends StatelessWidget {
  const MapControllersButtons({
    super.key,
    required MapController? controller,
    required LocationService locationService,
  }) : _controller = controller, _locationService = locationService;

  final MapController? _controller;
  final LocationService _locationService;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .2,
      child: Column(
        spacing: 10,
        children: [
          MapButton(
            icon: Icons.add,
            onTap: () {
              final camera = _controller?.getCamera();
              final zome = camera?.zoom ?? 5.0;
              _controller?.animateCamera(
                zoom: zome + 1,
                nativeDuration: const Duration(milliseconds: 300),
              );
            },
          ),
          MapButton(
            icon: Icons.remove,
            onTap: () {
              final camera = _controller?.getCamera();
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
    );
  }
}
