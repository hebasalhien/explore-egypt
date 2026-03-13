part of 'forgot_password_cubit.dart';

@immutable
sealed class ForgotPasswordState {
  const ForgotPasswordState();
}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class EmailSending extends ForgotPasswordState {}
final class OtpVerifying extends ForgotPasswordState {}
final class PasswordResetting extends ForgotPasswordState {}


final class EmailSent extends ForgotPasswordState {
  final String email;
  const EmailSent(this.email);
}

final class OtpVerified extends ForgotPasswordState {
  final String email;
  final String otp;
  const OtpVerified(this.email,this.otp);
}

final class PasswordResetSuccess extends ForgotPasswordState {
  final String message;
  const PasswordResetSuccess({this.message = 'Password reset successful'});
}

final class ForgotPasswordError extends ForgotPasswordState {
  final String message;
  const ForgotPasswordError(this.message);
}
