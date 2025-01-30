import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DatabaseHelper databaseHelper;

  LoginBloc(this.databaseHelper) : super(LoginInitial()) {
    on<PerformLogin>(_onPerformLogin);
  }

  Future<void> _onPerformLogin(
    PerformLogin event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final role = await databaseHelper.login(event.email, event.password);
      print('role :: $role');
      if (role != []) {
        String? roles = role.first['Role'] as String?;
        print('sukses login');
        Get.snackbar('Success', 'Login successfully as $roles');
        roles == 'Admin'
            ? Get.offAll(() => AdminPage())
            : Get.offAll(() => DoctorPatientPage(
                  doctorId: role.first['ID'] as int,
                ));
        emit(LoginSuccess(roles!));
      } else {
        emit(const LoginFailure("Invalid email or password."));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
