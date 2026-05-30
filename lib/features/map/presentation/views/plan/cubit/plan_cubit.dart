import 'package:bloc/bloc.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:meta/meta.dart';

part 'plan_state.dart';

class PlanCubit extends Cubit<PlanState> {
  PlanCubit() : super(PlanInitial());
}
