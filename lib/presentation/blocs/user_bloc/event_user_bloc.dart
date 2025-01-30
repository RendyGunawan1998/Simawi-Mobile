import '../../../core.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class FetchUsers extends UserEvent {}

class CreateUser extends UserEvent {
  final UserModel user;

  const CreateUser(this.user);

  @override
  List<Object?> get props => [user];
}

class UpdateUser extends UserEvent {
  final int id;
  final UserModel user;

  const UpdateUser(this.id, this.user);

  @override
  List<Object?> get props => [id, user];
}

class DeleteUser extends UserEvent {
  final int id;

  const DeleteUser(this.id);

  @override
  List<Object?> get props => [id];
}
