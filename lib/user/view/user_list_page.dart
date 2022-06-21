import 'package:bloc_webapp/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helper/color.dart';
import '../widgets/user_list_item.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetListUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
          ),
        ),
        backgroundColor: DSColor.primary,
        title: const Text(
          "LIST OF USERS",
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            return ListView.separated(
              itemCount: state.data.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 4,
                  color: Colors.black26,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return UserListItem(
                  data: state.data[index],
                );
              },
            );
          } else if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              child: Text("ad"),
            );
          }
        },
      ),
    );
  }
}
