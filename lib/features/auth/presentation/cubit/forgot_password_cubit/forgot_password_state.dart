part of 'forgot_password_cubit.dart';

@immutable
sealed class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordLoading extends ForgotPasswordState {}

final class ResetEmailSent extends ForgotPasswordState {}

final class PasswordResetSuccess extends ForgotPasswordState {
  final String message;
  PasswordResetSuccess({this.message = 'Password reset successful'});
}

final class ForgotPasswordError extends ForgotPasswordState {
  final String message;
  ForgotPasswordError(this.message);
}
