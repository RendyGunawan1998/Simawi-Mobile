import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core.dart';

class IcdBloc extends Bloc<IcdEvent, IcdState> {
  final ICDRepository icdRepository;

  IcdBloc(this.icdRepository) : super(IcdInitial()) {
    on<FetchIcdDetailsEvent>(_onFetchIcdDetails);
  }

  Future<void> _onFetchIcdDetails(
      FetchIcdDetailsEvent event, Emitter<IcdState> emit) async {
    emit(IcdLoading());
    try {
      print('call detail diagnosa :: ${event.diagnosa}');
      final icdDetails = await icdRepository.getICDDetail(event.diagnosa);
      emit(IcdSuccess(icdDetails));
    } catch (e) {
      emit(IcdFailure('Failed to load ICD data: $e'));
    }
  }
}
