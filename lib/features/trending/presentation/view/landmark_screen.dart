import 'package:cached_network_image/cached_network_image.dart';
import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:explore_egypt/features/home/model/entities/landmark_model.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/glass_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LandmarkScreen extends StatelessWidget {
  const LandmarkScreen({super.key, required this.landmark});
  final LandmarkModel landmark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,

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
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
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
          ),

          // The rest of your scrollable screen content goes here
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20,
              ),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LandmarkDetailsRow(landmark: landmark),
                  LandmarkInfoWidget(landmark: landmark),
                  LandmarkGallery(imagesUrl: landmark.imagesUrl),
                  Column(
                    spacing: 10,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'What People Say',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff4A3728),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              showBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                // showDragHandle: true,
                                builder: (context) => Container(
                                  height:
                                      MediaQuery.of(context).size.height * .55,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(35),
                                    ),
                                  ),
                                  child: ListView.builder(
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                        child: CommentWidget(
                                          landmark: landmark,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'See All',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.kPrimaryVariant,
                              ),
                            ),
                          ),
                        ],
                      ),

                      CommentWidget(landmark: landmark),
                    ],
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

class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key, required this.landmark});

  final LandmarkModel landmark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0x40FFFFFF), // #FFFFFF40
            offset: Offset(0, 4),
            blurRadius: 4.0,
            spreadRadius: 0.0,
          ),

          BoxShadow(
            color: Color(0x1A000000), // #0000001A
            offset: Offset(0, 3),
            blurRadius: 2.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(landmark.imagesUrl[0]),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 100,
                children: [
                  Text(
                    "User Name",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.kBlack,
                    ),
                  ),
                  Text(
                    "2 days ago",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textCaption,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Generate the stars dynamically
                  ...List.generate(5, (index) {
                    if (index < landmark.rating.floor()) {
                      // Full Star
                      return const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFE3A366),
                        size: 16,
                      );
                    } else if (index < landmark.rating &&
                        landmark.rating % 1 != 0) {
                      // Half Star (for values like 4.5)
                      return const Icon(
                        Icons.star_half_rounded,
                        color: Color(0xFFE3A366),
                        size: 16,
                      );
                    } else {
                      // Empty Border Star
                      return Icon(
                        Icons.star_border_rounded,
                        color: Colors.grey[300],
                        size: 16,
                      );
                    }
                  }),
                ],
              ),
              Expanded(
                child: Text(
                  "I really enjoyed my trip, it \nwas great and amazing I will came again",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textCaption,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LandmarkGallery extends StatelessWidget {
  const LandmarkGallery({super.key, required this.imagesUrl});

  final List<String> imagesUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gallery',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imagesUrl.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CachedNetworkImage(
                  imageUrl: imagesUrl[index],
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return Container(
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kPrimaryVariant,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(child: Icon(Icons.error)),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class LandmarkInfoWidget extends StatelessWidget {
  const LandmarkInfoWidget({super.key, required this.landmark});

  final LandmarkModel landmark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'About ${landmark.name}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: Text(
                landmark.description,
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textCaption,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xffF8EFE5), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x0D000000),
                        offset: Offset(0, 1),
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Column(
                    spacing: 4,
                    children: [
                      SvgPicture.asset(AppConstants.audioGuideIcon),
                      Text(
                        'Audio guide',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.kPrimaryVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LandmarkDetailsRow extends StatelessWidget {
  const LandmarkDetailsRow({super.key, required this.landmark});

  final LandmarkModel landmark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LandmardDetails(
          type: 'Category',
          data: landmark.category,
          svgIcon: AppConstants.categoryIcon,
        ),
        LandmardDetails(
          type: 'Best Time',
          data: landmark.bestTimeToVisit,
          icon: Icons.query_builder,
        ),
        LandmardDetails(
          type: 'Entry Fee',
          data: landmark.price,
          icon: Icons.confirmation_number_outlined,
        ),
        LandmardDetails(
          type: 'Duration',
          data: landmark.duration,
          icon: Icons.calendar_today_outlined,
        ),
      ],
    );
  }
}

class LandmardDetails extends StatelessWidget {
  const LandmardDetails({
    super.key,
    required this.type,
    required this.data,
    this.icon,
    this.svgIcon,
  });

  final String type;
  final String data;
  final IconData? icon;
  final String? svgIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffF8EFE5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: icon != null
                ? Icon(icon, color: AppColors.kPrimaryVariant, size: 26)
                : SvgPicture.asset(svgIcon!, width: 12, height: 12),
          ),
        ),
        Text(
          type,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: AppColors.textCaption,
          ),
        ),
        Text(
          data,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: AppColors.kBlack,
          ),
        ),
      ],
    );
  }
}
