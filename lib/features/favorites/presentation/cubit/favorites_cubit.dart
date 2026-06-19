import 'package:bloc/bloc.dart';
import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/features/favorites/model/repo/favorites_repo.dart';
import 'package:meta/meta.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepo _repo;

  FavoritesCubit(this._repo) : super(FavoritesInitial());

  /// load all the data of favorites

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());
    try {
      final results = await Future.wait([
        // _repo.getFavoriteLandmarks(),
        _repo.getFavoritePlans(),
      ]);

      emit(
        FavoritesLoaded(
          //favLandmarkIds: _toIdSet(results[0]),
          //favPlanIds: _toIdSet(results[1]),
          favPlanIds: _toIdSet(results[0]),
        ),
      );
    } on ServerException catch (e) {
      emit(FavoritesError(e.message));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  /// toggle landmark favorite
  // Future<void> toggleLandmarkFavorite(String id) async {
  //   final current = _currentLoaded;
  //   if (current == null) return;

  //   final isFavorited = current.favLandmarkIds.contains(id);

  //   // Optimistic update
  //   final updatedIds = Set<String>.from(current.favLandmarkIds);
  //   isFavorited ? updatedIds.remove(id) : updatedIds.add(id);
  //   emit(current.copyWith(favLandmarkIds: updatedIds));

  //   try {
  //     if (isFavorited) {
  //       await _repo.removeLandmarkFromFavorites(landmarkId: id);
  //     } else {
  //       await _repo.addLandmarkToFavorites(landmarkId: id);
  //     }
  //   } on ServerException catch (_) {
  //     emit(current); // revert on failure
  //   } catch (_) {
  //     emit(current); // revert on failure
  //   }
  // }

  /// toggle plan favorite
  Future<void> togglePlanFavorite(String id) async {
    final current = _currentLoaded;
    if (current == null) return;

    final isFavorited = current.favPlanIds.contains(id);

    // Optimistic update
    final updatedIds = Set<String>.from(current.favPlanIds);
    isFavorited ? updatedIds.remove(id) : updatedIds.add(id);
    emit(current.copyWith(favPlanIds: updatedIds));

    try {
      if (isFavorited) {
        await _repo.removePlanFromFavorites(planId: id);
      } else {
        await _repo.addPlanToFavorites(planId: id);
      }
    } on ServerException catch (_) {
      emit(current); // revert on failure
    } catch (_) {
      emit(current); // revert on failure
    }
  }

  FavoritesLoaded? get _currentLoaded =>
      state is FavoritesLoaded ? state as FavoritesLoaded : null;

  Set<String> _toIdSet(dynamic data) {
    return (data as List).map<String>((item) => item['id'] as String).toSet();
  }
}
