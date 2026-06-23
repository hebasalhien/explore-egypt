part of 'favorites_cubit.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final Set<String> favLandmarkIds;
  final Set<String> favPlanIds;

  FavoritesLoaded({
    required this.favLandmarkIds,
    required this.favPlanIds,
  });

  FavoritesLoaded copyWith({
    Set<String>? favLandmarkIds,
    Set<String>? favPlanIds,
  }) {
    return FavoritesLoaded(
      favLandmarkIds: favLandmarkIds ?? this.favLandmarkIds,
      favPlanIds: favPlanIds ?? this.favPlanIds,
    );
  }
}

class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}