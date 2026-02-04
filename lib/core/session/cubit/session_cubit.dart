import 'package:explore_egypt/core/services/shared_pref_helper.dart';
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

    emit(SessionAuthenticated(token));
  }

  Future<dynamic> endSession() async {
    try {
      await SharedPrefHelper.clearAlldata();
      debugPrint('token deleted');
      emit(SessionUnauthenticated());
    } catch (e) {
      throw ('An unexpected error occurred $e');
    }
  }

}
