import 'package:cached_network_image/cached_network_image.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/widgets/categories_list.dart';
import 'package:explore_egypt/core/widgets/custom_app_bar_background.dart';
import 'package:explore_egypt/core/widgets/custom_button.dart';
import 'package:explore_egypt/features/home/model/entities/plan_card_model.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/glass_icon_button.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/custom_search_bar.dart';
import 'package:explore_egypt/features/plans/model/entities/categories_model.dart';
import 'package:explore_egypt/features/plans/presentation/cubit/suggested_plans_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SuggestedPlansPage extends StatelessWidget {
  const SuggestedPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffF8F3ED),
      body: BlocBuilder<SuggestedPlansCubit, SuggestedPlansState>(
        builder: (context, state) {
          if (state is SuggestedPlansLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SuggestedPlansError) {
            return Center(child: Text(state.error));
          } else if (state is SuggestedPlansLoaded) {
            return PlansLoaddedWidget(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              planCardModel: state.plans,
              categories: state.categories, 
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class PlansLoaddedWidget extends StatelessWidget {
  const PlansLoaddedWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.planCardModel,
    required this.categories,
  });

  final double screenHeight;
  final double screenWidth;
  final List<PlanCardModel> planCardModel;
  final List<CategoriesModel> categories;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarBackground(
          r1: 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              SizedBox(height: 20),
              Row(
                spacing: 20,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.kWhite),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Suggested Plans',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kWhite,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                child: CustomSearchBar(hint: 'Search Plans', radius: 30),
              ),
            ],
          ),
        ),
        CategoriesList(
          categories: categories,
        ),
        SuggestedPlansList(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          planCardModel: planCardModel,
        ),
      ],
    );
  }
}

class SuggestedPlansList extends StatelessWidget {
  const SuggestedPlansList({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.planCardModel,
  });

  final double screenHeight;
  final double screenWidth;
  final List<PlanCardModel> planCardModel;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 2),
        itemBuilder: (contxt, index) => Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: Container(
            height: screenHeight * .4,
            width: screenWidth,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                Positioned.fill(child: SuggestedPlanCardBG()),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: screenHeight * .15,
                  child: SuggestedPlanCardImage(
                    image: planCardModel[index].imageUrl,
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 6,
                        ),
                        child: Text(
                          '3 Days',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium!.copyWith(fontSize: 12),
                        ),
                      ),
                      GlassIconButton(opacity: 0),
                    ],
                  ),
                ),

                Positioned(
                  left: 15,
                  right: 8,
                  bottom: screenHeight * .10,
                  child: PlanInfo(
                    screenWidth: screenWidth,
                    title: planCardModel[index].name,
                    subtitle: planCardModel[index].subtitle,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: CustomButton(
                    onPressed: () {},
                    label: 'Add Plan',
                    radius: 26,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        itemCount: planCardModel.length,
      ),
    );
  }
}

class SuggestedPlanCardBG extends StatelessWidget {
  const SuggestedPlanCardBG({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
        boxShadow: const [
          // Shadow 1 (Larger, softer drop shadow)
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -3,
          ),
          // Shadow 2 (Tighter, inner-core shadow)
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -4,
          ),
        ],
      ),
    );
  }
}

class PlanInfo extends StatelessWidget {
  const PlanInfo({
    super.key,
    required this.screenWidth,
    required this.title,
    required this.subtitle,
  });

  final double screenWidth;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            subtitle.toUpperCase(),
            style: Theme.of(context).textTheme.titleSmall,
            softWrap: true,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
              fontFamily: GoogleFonts.notoSerif().fontFamily,
            ),
            softWrap: true,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Highlights:',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: Color(0xffE8C4A0)),
                ),
                TextSpan(
                  text:
                      'Philae Temple, Karnak, Nile Cruise, Valley of the kings',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SuggestedPlanCardImage extends StatelessWidget {
  const SuggestedPlanCardImage({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      // 1. This creates the exact CSS 0deg gradient (Bottom to Top)
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.bottomCenter, // 0% mapping
          end: Alignment.topCenter, // 100% mapping
          colors: [
            Color(0xFF000000), // Black at the very bottom (0%)
            Color(0x00000000), // Fully transparent black at 50%
            Color(0x00000000), // Fully transparent black at 100%
          ],
          stops: [0.0, 0.5, 1.0], // Maps exactly to your 0%, 50%, 100%
        ).createShader(bounds);
      },
      // 2. Tells Flutter to blend the gradient on top of the image container
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
          color:
              Colors.white, // Maps to your solid white CSS background fallback
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          image: DecorationImage(
            image: CachedNetworkImageProvider(image),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
