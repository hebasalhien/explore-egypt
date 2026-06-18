import 'package:explore_egypt/features/plans/presentation/cubit/suggested_plans_cubit.dart';
import 'package:explore_egypt/features/plans/presentation/view/widgets/plans_loaded_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              selectedCategoryId: state.selectedCategoryId,
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}