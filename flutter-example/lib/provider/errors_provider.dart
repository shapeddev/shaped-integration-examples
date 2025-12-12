import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorsEntity {
  final List<String>? errorList;

  ErrorsEntity({this.errorList});
}

class ErrorsNotifier extends StateNotifier<ErrorsEntity> {
  ErrorsNotifier() : super(ErrorsEntity());
  static bool start = true;

  void update(ErrorsEntity errors) {
    state = errors;
  }

  ErrorsEntity get() {
    if (ErrorsNotifier.start) {
      ErrorsNotifier.start = false;
      return ErrorsEntity(errorList: ['start']);
    }
    return state;
  }
}

final errorsProvider = StateNotifierProvider((ref) {
  return ErrorsNotifier();
});
