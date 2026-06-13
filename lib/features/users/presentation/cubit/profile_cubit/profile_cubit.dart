import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/core/media/image_picker_services.dart';
import 'package:explore_egypt/features/users/model/entities/user_model.dart';
import 'package:explore_egypt/features/users/model/repos/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _repository;
  ProfileCubit(this._repository) : super(ProfileInitial());

  /// gets all user data
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

  /// it calls the repository to update the user data
  Future<dynamic> updateUserData({
    String? image,
    String? userName,
    String? bio,
  }) async {
    final current = state;
    if (current is! ProfileLoaded) return;

    emit(ProfileUpdateLoading());

    try {
      final updatedUser = await _repository.updateUserData(
        userName: userName,
        bio: bio,
        image: image,
      );

      emit(ProfileUpdatedSuccess(user: updatedUser));

      emit(ProfileLoaded(user: updatedUser));
    } catch (e) {
      emit(ProfileUpdateFaild(e.toString()));
      emit(current); // rollback
    }
  }
  void setPickedImage(String path) {
    final current = state;

    if (current is ProfileLoaded) {
      emit(current.copyWith(pickedImage: path));
    }
  }
  /// picks image from gallery
  Future<dynamic> pickImage() async {
    final picked = await ImagePickerServices().pickImageFromGallery();
    if (picked != null) {
      final cleanPath = picked.path.replaceFirst('file://', '');
      setPickedImage(cleanPath);
      return cleanPath;
    }

    return null;
  }
}
