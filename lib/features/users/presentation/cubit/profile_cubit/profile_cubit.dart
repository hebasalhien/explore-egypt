import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/core/media/image_picker_services.dart';
import 'package:explore_egypt/core/session/cubit/session_cubit.dart';
import 'package:explore_egypt/features/users/model/entities/user_model.dart';
import 'package:explore_egypt/features/users/model/repos/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _repository;
  final SessionCubit _sessionCubit; // ← injected

  ProfileCubit(this._repository, this._sessionCubit) : super(ProfileInitial());

  /// gets all user data
  Future<void> getUserData() async {
    emit(ProfileLoading());
    try {
      final userData = await _repository.getUserData();
      emit(ProfileLoaded(user: userData));
    } on ServerException catch (e) {
      emit(ProfileLoadedFaild(e.message.message));
    } catch (e) {
      emit(ProfileLoadedFaild('An unexpected error occurred: $e'));
    }
  }

  /// updates user data and notifies UserCubit so home stays in sync
  Future<void> updateUserData({String? image, String? userName, String? bio}) async {
  final current = state;
  if (current is! ProfileLoaded) return;

  emit(ProfileUpdateLoading());
  try {
    final updatedUser = await _repository.updateUserData(
      userName: userName,
      bio: bio,
      image: image,
    );

    // ← update SessionCubit so HomeScreen reacts automatically
    await _sessionCubit.updateUser(
      username: updatedUser.name,
      imageUrl: updatedUser.imageURL,
    );

    emit(ProfileUpdatedSuccess(user: updatedUser));
    emit(ProfileLoaded(user: updatedUser));
  } catch (e) {
    emit(ProfileUpdateFaild(e.toString()));
    emit(current);
  }
}

  void setPickedImage(String path) {
    final current = state;
    if (current is ProfileLoaded) {
      emit(current.copyWith(pickedImage: path));
    }
  }

  /// picks image from gallery
  Future<String?> pickImage() async {
    final picked = await ImagePickerServices().pickImageFromGallery();
    if (picked != null) {
      final cleanPath = picked.path.replaceFirst('file://', '');
      setPickedImage(cleanPath);
      return cleanPath;
    }
    return null;
  }
}