import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_webapp/user/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<GetListUserEvent>(
      (event, emit) async {
        try {
          List<User> data = state.data.toList();
          emit(UserLoading(newData: data));
          emit(UserLoaded(newData: data));
        } catch (e) {
          emit(UserError());
        }
      },
      transformer: droppable(),
    );
    on<AddUserEvent>(
      (event, emit) async {
        try {
          List<User> data = state.data.toList();
          var newUser = User(
            id: 1,
            name: "",
            email: "",
          );
          if (data.isNotEmpty) {
            newUser = User(
              id: data.last.id + 1,
              name: "",
              email: "",
            );
          }
          data.add(newUser);
          emit(UserAdded(newData: data));
        } catch (e) {
          emit(UserError());
        }
      },
      transformer: sequential(),
    );
    on<SaveUserEvent>(
      (event, emit) async {
        try {
          List<User> data = state.data.toList();
          data[data.indexWhere((element) => element.id == event.user.id)] =
              event.user;
          emit(UserSaved(newData: data));
        } catch (e) {
          emit(UserError());
        }
      },
      transformer: restartable(),
    );
    on<DeleteUserEvent>(
      (event, emit) async {
        try {
          List<User> data = state.data.toList();
          data.removeWhere((element) => element.id == event.user.id);
          emit(UserDeleted(newData: data));
        } catch (e) {
          emit(UserError());
        }
      },
      transformer: restartable(),
    );
  }
}
