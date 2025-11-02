part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final Map<String, dynamic> data;
  AuthSuccess(this.data);
}

final class AuthError extends AuthState {
  final message;
  AuthError(this.message);
}
