import 'package:explore_egypt/core/services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  Future<void> sendResetEmail({required String email}) async {
    emit(ForgotPasswordLoading());
    try {
      // Simulate sending reset link
      await AuthServices().sendResetPasswordEmail(email: email);
      emit(ResetEmailSent());
    } catch (e) {
      emit(ForgotPasswordError('Failed to send reset link'));
    }
  }
  Future<void> resetPassword({required String email, required String otp, required String newPassword}) async {
    emit(ForgotPasswordLoading());
    try {
      // Simulate password reset
      await AuthServices().resetPassword(email: email, otp: otp, newPassword: newPassword);
      emit(PasswordResetSuccess());
    } catch (e) {
      emit(ForgotPasswordError('Failed to reset password'));
    }
  }
}
