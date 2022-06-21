part of 'user_bloc.dart';

class UserState extends Equatable {
  final List<User> data;

  const UserState({
    required this.data,
  });

  UserState copyWith({
    required List<User> data,
  }) {
    return UserState(
      data: data,
    );
  }

  @override
  List<Object> get props => data;
}

class UserInitial extends UserState {
  UserInitial() : super(data: []);
}

class UserLoaded extends UserState {
  final List<User> newData;

  const UserLoaded({required this.newData}) : super(data: newData);
}

class UserAdded extends UserState {
  final List<User> newData;

  const UserAdded({required this.newData}) : super(data: newData);
}

class UserSaved extends UserState {
  final List<User> newData;

  const UserSaved({required this.newData}) : super(data: newData);
}

class UserDeleted extends UserState {
  final List<User> newData;

  const UserDeleted({required this.newData}) : super(data: newData);
}

class UserEmpty extends UserState {
  UserEmpty() : super(data: []);
}

class UserLoading extends UserState {
  final List<User> newData;

  const UserLoading({required this.newData}) : super(data: newData);
}

class UserError extends UserState {
  UserError() : super(data: []);
}
