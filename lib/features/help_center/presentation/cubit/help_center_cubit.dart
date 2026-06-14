import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/features/help_center/model/entities/faq_model.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'help_center_state.dart';

class HelpCenterCubit extends Cubit<HelpCenterState> {
  HelpCenterCubit() : super(HelpCenterInitial());

Future<void> loadFaqs() async {
  emit(HelpCenterLoading());
  try {
    final jsonString = await rootBundle.loadString(AppConstants.faqData);

    final Map<String, dynamic> data = json.decode(jsonString);

      final faqs = (data['faq'] as List)
          .map((e) => FaqModel.fromJson(e))
          .toList();

    emit(HelpCenterLoaded(faq: faqs));
  } catch (e) {
    emit(HelpCenterError(error: e.toString()));
  }
}
}
