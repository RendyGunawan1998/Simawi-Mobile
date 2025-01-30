import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<CreateUser>(_onCreateUser);
    on<UpdateUser>(_onUpdateUser);
    on<DeleteUser>(_onDeleteUser);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final users = await userRepository.getAllUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError('Failed to fetch users: $e'));
    }
  }

  Future<void> _onCreateUser(CreateUser event, Emitter<UserState> emit) async {
    try {
      await userRepository.createUser(event.user);
      add(FetchUsers());
    } catch (e) {
      emit(UserError('Failed to create user: $e'));
    }
  }

  Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    try {
      await userRepository.updateUser(event.id, event.user);
      add(FetchUsers());
    } catch (e) {
      emit(UserError('Failed to update user: $e'));
    }
  }

  Future<void> _onDeleteUser(DeleteUser event, Emitter<UserState> emit) async {
    try {
      await userRepository.deleteUser(event.id);
      add(FetchUsers());
    } catch (e) {
      emit(UserError('Failed to delete user: $e'));
    }
  }
}
