import 'package:explore_egypt/features/auth/model/repos/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _repo;
  ForgotPasswordCubit(this._repo) : super(ForgotPasswordInitial());

  Future<void> sendOtp({required String email}) async {
    emit(EmailSending());
    try {
      // Simulate sending reset link
      await _repo.sendOtp(email: email);
      emit(EmailSent(email));
    } catch (e) {
      emit(ForgotPasswordError('Failed to send reset link'));
    }
  }

  Future<void> otpVerification({required String otp}) async {
    final email = (state as EmailSent).email;
    emit(OtpVerified(email, otp));
  }

  Future<void> resetPassword({
    required String newPassword,
  }) async {
    final currentState = state as OtpVerified;
    emit(PasswordResetting());
    try {
      // Simulate password reset
      await _repo.resetPassword(
        email: currentState.email,
        otp: currentState.otp,
        newPassword: newPassword,
      );
      emit(PasswordResetSuccess());
    } catch (e) {
      emit(ForgotPasswordError('Failed to reset password'));
    }
  }
}
