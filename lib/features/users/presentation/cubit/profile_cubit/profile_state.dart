part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final UserModel user;
  ProfileLoaded({required this.user});
}

final class ProfileLoadedFaild extends ProfileState {
  final String errorMessage;
  ProfileLoadedFaild(this.errorMessage);
}
