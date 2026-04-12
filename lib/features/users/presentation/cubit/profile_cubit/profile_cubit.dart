import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/features/users/model/entities/user_model.dart';
import 'package:explore_egypt/features/users/model/repos/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _repository;
  ProfileCubit(this._repository) : super(ProfileInitial());

  Future<dynamic> getUserData() async {
    emit(ProfileLoading());
    try {
      final userData = await _repository.getUserData();

      emit(ProfileLoaded(user: userData));
    } on ServerException catch (e) {
      emit(ProfileLoadedFaild(e.message));
    } catch (e) {
      emit(ProfileLoadedFaild('An unexpected error occurred:$e'));
    }
  }
}
