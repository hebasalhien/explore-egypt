import 'package:cached_network_image/cached_network_image.dart';
import 'package:explore_egypt/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:explore_egypt/features/home/model/entities/plan_card_model.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/glass_icon_button.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/photo_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.planCardModel,
  });
  final PlanCardModel planCardModel;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        height: screenHeight * .25,
        width: screenWidth * .45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          image: DecorationImage(
            image: CachedNetworkImageProvider(planCardModel.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 8,
              top: 8,
              child: BlocSelector<FavoritesCubit, FavoritesState, bool>(
                selector: (state) =>
                    state is FavoritesLoaded &&
                    state.favPlanIds.contains(planCardModel.id),
                builder: (context, isFavorite) {
                  return GlassIconButton(
                    isFavorite: isFavorite,
                    onPressed: () {
                      context.read<FavoritesCubit>().togglePlanFavorite(
                        planCardModel.id,
                      );
                    },
                  );
                },
              ),
            ),

            Positioned(
              left: 15,
              bottom: 15,
              child: SizedBox(
                width: screenWidth * .35,
                child: PhotoInfo(
                  title: planCardModel.name,
                  subtitle: planCardModel.subtitle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
