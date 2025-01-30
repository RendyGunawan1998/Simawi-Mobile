import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepo repo = DashboardRepo();

  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboardDataEvent>(_onLoadDashboardData);
  }

  Future<void> _onLoadDashboardData(
      LoadDashboardDataEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    try {
      print('call dashboard bloc');

      final topICDCodes = await repo.getTopICDCodes();

      print('topICDCodes :: $topICDCodes');
      emit(DashboardSuccess(
        topICDCodes: topICDCodes,
      ));
    } catch (e) {
      emit(DashboardFailure('Failed to load dashboard data: $e'));
    }
  }
}
