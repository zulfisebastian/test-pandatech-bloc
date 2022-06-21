part of 'user_bloc.dart';

abstract class UserEvent {}

class GetListUserEvent extends UserEvent {}

class AddUserEvent extends UserEvent {}

class SaveUserEvent extends UserEvent {
  final User user;

  SaveUserEvent({
    required this.user,
  });
}

class DeleteUserEvent extends UserEvent {
  final User user;

  DeleteUserEvent({
    required this.user,
  });
}
