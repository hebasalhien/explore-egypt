import 'package:explore_egypt/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:explore_egypt/features/home/model/entities/landmark_model.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/glass_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandmarkAppBar extends StatelessWidget {
  const LandmarkAppBar({super.key, required this.landmark});

  final LandmarkModel landmark;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Color.fromARGB(255, 17, 14, 10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
      ),

      clipBehavior: Clip.antiAlias,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: BlocSelector<FavoritesCubit, FavoritesState, bool>(
            selector: (state) =>
                state is FavoritesLoaded &&
                state.favLandmarkIds.contains(landmark.id),
            builder: (context, isFavorite) {
              return GlassIconButton(
                isFavorite: isFavorite,
                onPressed: () {
                  context.read<FavoritesCubit>().toggleLandmarkFavorite(
                    landmark.id!,
                  );
                },
              );
            },
          ),
        ),
      ],

      flexibleSpace: FlexibleSpaceBar(
        background: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(landmark.imageUrl, fit: BoxFit.cover),

              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.0, 0.3472], // Matches 0% and 34.72%
                    colors: [
                      Color(0xFF000000), // #000000 at the bottom
                      Color(
                        0x00E3A366,
                      ), // rgba(227, 163, 102, 0) transparent orange
                    ],
                  ),
                ),
              ),

              // 3. The Second Gradient: Top-down Red Tint (180deg in CSS is top-to-bottom)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.4107], // Matches 0% and 41.07%
                    colors: [
                      Color(0xFFA24945), // #A24945 at the top
                      Color(
                        0x00E3A366,
                      ), // rgba(227, 163, 102, 0) transparent orange
                    ],
                  ),
                ),
              ),

              // Title Text Positioned perfectly near the bottom left
              Positioned(
                left: 20,
                bottom: 30,
                right: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      landmark.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 4,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Color(0xffE5E7EB),
                              size: 16,
                            ),
                            Text(
                              landmark.locationUrl,
                              style: TextStyle(
                                color: Color(0xffE5E7EB),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          spacing: 4,
                          children: [
                            Icon(
                              Icons.star,
                              color: Color(0xffE5E7EB),
                              size: 16,
                            ),
                            Text(
                              landmark.rating.toString(),
                              style: TextStyle(
                                color: Color(0xffE5E7EB),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "(${landmark.reviewCount})",
                              style: TextStyle(
                                color: Color(0xffE5E7EB),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
