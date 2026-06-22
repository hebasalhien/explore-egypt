import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';

class NavigationState {
  final int index;
  final TripModel? trip;
  NavigationState(this.index, {this.trip});
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(0));

  void switchTab(int index, {TripModel? trip}) {
    emit(NavigationState(index, trip: trip ?? state.trip));
  }
  void clearTrip() {
  emit(NavigationState(state.index, trip: null));
}
}
