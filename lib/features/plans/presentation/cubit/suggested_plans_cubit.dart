import 'package:bloc/bloc.dart';
import 'package:explore_egypt/features/home/model/entities/plan_card_model.dart';
import 'package:explore_egypt/features/home/model/repos/home_repository.dart';
import 'package:explore_egypt/features/plans/model/entities/categories_model.dart';
import 'package:explore_egypt/features/plans/model/repo/suggested_plans_repo.dart';
import 'package:meta/meta.dart';

part 'suggested_plans_state.dart';

class SuggestedPlansCubit extends Cubit<SuggestedPlansState> {
  final List<PlanCardModel> initialPlans;
  final HomeRepository _homeRepository;
  final SuggestedPlansRepo _suggestedPlansRepo;

  List<CategoriesModel> categories = [];
  List<PlanCardModel> plans = [];

  SuggestedPlansCubit({
    required this.initialPlans,
    required HomeRepository homeRepository,
    required SuggestedPlansRepo suggestedPlansRepo,
  })  : _homeRepository = homeRepository,
        _suggestedPlansRepo = suggestedPlansRepo,
        super(
          SuggestedPlansLoaded(
            categories: [],
            plans: initialPlans,
            selectedCategoryId: "All",
          ),
        );

  Future<void> getCategories() async {
    emit(SuggestedPlansLoading());
    try {
      final response = await _homeRepository.getCategories();
      plans = initialPlans;
      categories =
          [
            CategoriesModel(name: 'All', id: 'All'),
            CategoriesModel(name: 'Favorite', id: 'Favorite'),
          ] +
          ((response as List<dynamic>)
              .map((item) => CategoriesModel.fromJson(item))
              .toList());
      emit(
        SuggestedPlansLoaded(
          categories: categories,
          plans: plans,
          selectedCategoryId: "All",
        ),
      );
    } catch (e) {
      emit(SuggestedPlansError(error: e.toString()));
    }
  }

  Future<void> getAllFavoritePlans() async {
    try {
      plans = (await _suggestedPlansRepo.getFavoritePlans() as List<dynamic>)
          .map((item) => PlanCardModel.fromJson(item))
          .toList();

      emit(
        SuggestedPlansLoaded(
          categories: categories,
          plans: plans,
          selectedCategoryId: 'Favorite',
        ),
      );
    } catch (e) {
      emit(SuggestedPlansError(error: e.toString()));
    }
  }

  Future<void> getPlansByCategory({required String categoryId}) async {
    emit(SuggestedPlansLoading());
    if (categoryId == 'All') {
      plans = initialPlans;
      emit(
        SuggestedPlansLoaded(
          categories: categories,
          plans: plans,
          selectedCategoryId: categoryId,
        ),
      );
      return;
    }
    if (categoryId == 'Favorite') {
      await getAllFavoritePlans();
      return;
    }
    try {
      plans =
          (await _suggestedPlansRepo.getPlansByCategory(categoryId: categoryId)
                  as List<dynamic>)
              .map((item) => PlanCardModel.fromJson(item))
              .toList();

      emit(
        SuggestedPlansLoaded(
          categories: categories,
          plans: plans,
          selectedCategoryId: categoryId,
        ),
      );
    } catch (e) {
      emit(SuggestedPlansError(error: e.toString()));
    }
  }
}
