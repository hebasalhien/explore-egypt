import 'package:bloc/bloc.dart';
import 'package:explore_egypt/features/home/model/entities/plan_card_model.dart';
import 'package:explore_egypt/features/plans/model/data_source/suggested_plans_remote_data_source.dart';
import 'package:explore_egypt/features/plans/model/entities/categories_model.dart';
import 'package:explore_egypt/features/plans/model/repo/suggested_plans_repo.dart';
import 'package:meta/meta.dart';

part 'suggested_plans_state.dart';

class SuggestedPlansCubit extends Cubit<SuggestedPlansState> {
  final List<PlanCardModel> initialPlans;

  final SuggestedPlansRepo _suggestedPlansRepo = SuggestedPlansRepo(
    SuggestedPlansRemoteDataSource(),
  );

  List<CategoriesModel> categories = [];
  List<PlanCardModel> plans = [];

  SuggestedPlansCubit({required this.initialPlans})
    : super(SuggestedPlansLoaded(categories: [], plans: initialPlans));
  Future<void> getCategories() async {
    emit(SuggestedPlansLoading());
    try {
      final response = await _suggestedPlansRepo.getCategories();
      plans = initialPlans;
      categories =
          [
            CategoriesModel(name: 'All', id: ''),
            CategoriesModel(name: 'Favourite', id: ''),
          ] +
          ((response as List<dynamic>)
              .map((item) => CategoriesModel.fromJson(item))
              .toList());
      emit(SuggestedPlansLoaded(categories: categories, plans: plans));
    } catch (e) {
      emit(SuggestedPlansError(error: e.toString()));
    }
  }

  Future<void> getPlansByCategory({required String categoryId}) async {
    emit(SuggestedPlansLoading());
    try {
      plans =
          (await _suggestedPlansRepo.getPlansByCategory(categoryId: categoryId)
                  as List<dynamic>)
              .map((item) => PlanCardModel.fromJson(item))
              .toList();

      emit(SuggestedPlansLoaded(categories: categories, plans: plans));
    } catch (e) {
      emit(SuggestedPlansError(error: e.toString()));
    }
  }

}
