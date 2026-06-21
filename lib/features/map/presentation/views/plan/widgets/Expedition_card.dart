import 'package:explore_egypt/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/glass_icon_button.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/card_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpeditionCard extends StatelessWidget {
  const ExpeditionCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    this.trip
  });

  final double screenHeight;
  final double screenWidth;
  final TripModel? trip;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        height: screenHeight * .4,
        width: screenWidth * .65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage('assets/images/pyramid.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            if(trip == null)
            Positioned(
              right: 8,
              top: 8,
              // child: BlocSelector<FavoritesCubit, FavoritesState, bool>(
              //   selector: (state) =>
              //       state is FavoritesLoaded &&
              //       state.favLandmarkIds.contains(landmark.id),
              //   builder: (context, isFavorite) {
              //     return GlassIconButton(isFavorite: isFavorite, onPressed: () {
              //                       //         // context.read<FavoritesCubit>().toggleLandmarkFavorite(
              //   //         //         landmark.id,
              //   //         //       );
              //     });
              //   },
              // ),
              child: GlassIconButton(
                isFavorite: false,
                onPressed: () {
                  debugPrint("pressed");
                },
              ),
            ),

            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CardInfo(screenWidth: screenWidth, trip: trip),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
