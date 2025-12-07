import 'package:explore_egypt/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explore_egypt/services/profile_service.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ProfileService _profileService;
  ChatCubit(this._profileService) : super(ChatLoading());
  Future<dynamic> getUserData() async {
    try {
      final response = await _profileService.getUserProfile();
      emit(ChatInitial(userModel: response));
    } catch (e) {
      String errorMessage = e.toString().replaceFirst('Exception: ', '');

      emit(ChatError(errorMessage: errorMessage));
    }
  }
}
