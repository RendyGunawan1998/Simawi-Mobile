// icd_state.dart
abstract class IcdState {}

class IcdInitial extends IcdState {}

class IcdLoading extends IcdState {}

class IcdSuccess extends IcdState {
  final Map<String, dynamic> icdDetails;

  IcdSuccess(this.icdDetails);
}

class IcdFailure extends IcdState {
  final String error;

  IcdFailure(this.error);
}
