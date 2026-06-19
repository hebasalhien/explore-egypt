import 'package:explore_egypt/core/constants/storage_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';
import 'package:explore_egypt/core/services/shared_pref_helper.dart';
import 'package:explore_egypt/features/splash/model/entities/session_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(SessionCubitInitial());

  Future<void> startSession(String token) async {
    await SharedPrefHelper.setSecureString('accessToken', token);
    emit(SessionAuthenticated(token));
  }

  Future<void> restoreSession() async {
    final token = await SharedPrefHelper.getSecuredString('accessToken');

    if (token == null) {
      emit(SessionUnauthenticated());
      return;
    }
  //   try{
  //     // Actually validate with backend — returns user data too
  //   final user = await _authRepository.validateSession();

  //   await _localDb.saveUserProfile(user); // save for home/profile
  //   emit(SessionAuthenticated(token));

  // } on UnauthorizedException {
  //   // Both tokens expired — clean up and force login
  //   await SharedPrefHelper.removeSecuredString('accessToken');
  //   await SharedPrefHelper.removeSecuredString('refreshToken');
  //   emit(SessionUnauthenticated());

  // } catch (e) {
  //   // Network error — token might still be valid
  //   // Two strategies (pick one):
  //   emit(SessionAuthenticated(token)); // optimistic: trust local token
  //   // emit(SessionUnauthenticated()); // strict: force login on any error
  // }
    emit(SessionAuthenticated(token));
  }

  Future<dynamic> endSession() async {
    try {
      await SharedPrefHelper.removeSecureData(StorageConstants.userToken);
      await ApiService.instance.cookieJar.deleteAll();
      
      debugPrint('token deleted');
      emit(SessionUnauthenticated());
    } catch (e) {
      throw ('An unexpected error occurred $e');
    }
  }
}
