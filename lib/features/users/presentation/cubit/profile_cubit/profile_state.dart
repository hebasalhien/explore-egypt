part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final UserModel user;
final String? pickedImage;

  ProfileLoaded({
    required this.user,
    this.pickedImage,
  });

  ProfileLoaded copyWith({
    UserModel? user,
    String? pickedImage,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
      pickedImage: pickedImage,
    );
  }}

final class ProfileLoadedFaild extends ProfileState {
  final String errorMessage;
  ProfileLoadedFaild(this.errorMessage);
}

final class ProfileUpdate extends ProfileState {
  final UserModel user;
  
  ProfileUpdate({required this.user});
}

final class ProfileUpdateLoading extends ProfileState {}

final class ProfileUpdatedSuccess extends ProfileState {
final UserModel user;
  ProfileUpdatedSuccess({required this.user});
}

final class ProfileUpdateFaild extends ProfileState {
  final String errorMessage;
  ProfileUpdateFaild(this.errorMessage);
}
