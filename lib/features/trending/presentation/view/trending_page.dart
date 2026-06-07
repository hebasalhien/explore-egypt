import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/widgets/categories_list.dart';
import 'package:explore_egypt/core/widgets/custom_app_bar_background.dart';
import 'package:explore_egypt/features/home/model/entities/landmark_model.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/landmark_card.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';

class TrendingPage extends StatelessWidget {
  const TrendingPage({super.key, required this.landmarkModel});
  final List<LandmarkModel> landmarkModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F3ED),
      body: Column(
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
                      'Trending Expeditions',
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
                  child: CustomSearchBar(
                    hint: 'Search Expeditions',
                    radius: 30,
                  ),
                ),
              ],
            ),
          ),
          CategoriesList(isSelected: false, onTap: () {}),
          LandmarkGridView(landmarkModel: landmarkModel),
        ],
      ),
    );
  }
}

class LandmarkGridView extends StatelessWidget {
  const LandmarkGridView({super.key, required this.landmarkModel});
  final List<LandmarkModel> landmarkModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.only(left: 10, top: 12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          childAspectRatio: .7,
        ),
        itemCount: landmarkModel.length,
        itemBuilder: (context, index) {
          return LandmarkCard(
            screenHeight: MediaQuery.of(context).size.height * .4,
            screenWidth: MediaQuery.of(context).size.width,
            landmark: landmarkModel[index],
          );
        },
      ),
    );
  }
}
