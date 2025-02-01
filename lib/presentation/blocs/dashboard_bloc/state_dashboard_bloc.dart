import '../../../core.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
  final int patientCount;
  final List<Patient> recentPatients;
  final List<ICD10Diagnosis> topICDCodes;

  DashboardSuccess(
    this.patientCount,
    this.recentPatients,
    this.topICDCodes,
  );
}

class DashboardFailure extends DashboardState {
  final String message;

  DashboardFailure(this.message);
}
