import '../../../core.dart';

abstract class PatientState extends Equatable {
  const PatientState();

  @override
  List<Object?> get props => [];
}

class PatientInitial extends PatientState {}

class PatientLoading extends PatientState {}

class PatientLoaded extends PatientState {
  final List<CombinedUserPatient> combinedData;

  const PatientLoaded(this.combinedData);

  @override
  List<Object?> get props => [combinedData];
}

class PatientError extends PatientState {
  final String message;

  const PatientError(this.message);

  @override
  List<Object?> get props => [message];
}

class DoctorsLoaded extends PatientState {
  final List<UserModel> doctors;
  const DoctorsLoaded(this.doctors);

  @override
  List<Object?> get props => [doctors];
}
