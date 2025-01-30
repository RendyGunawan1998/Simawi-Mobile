import '../../../core.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
  final List<ICD10Diagnosis> topICDCodes;

  DashboardSuccess({
    required this.topICDCodes,
  });
}

class DashboardFailure extends DashboardState {
  final String message;

  DashboardFailure(this.message);
}
