abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminSuccess extends AdminState {
  final dynamic data;

  AdminSuccess(this.data);
}

class AdminFailure extends AdminState {
  final String message;

  AdminFailure(this.message);
}
