import 'dart:async';

import 'package:bloc_webapp/user/bloc/user_bloc.dart';
import 'package:bloc_webapp/user/widgets/empty_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helper/color.dart';
import '../model/user.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetListUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DSColor.secondary,
      appBar: AppBar(
        backgroundColor: DSColor.primary,
        title: const Text(
          "REGISTER USERS",
        ),
        centerTitle: true,
        actions: [
          Material(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            color: DSColor.primary,
            child: InkWell(
              onTap: () {
                final form = _formKey.currentState;
                if (context.read<UserBloc>().state.data.isNotEmpty) {
                  if (form!.validate()) {
                    FocusScope.of(context).unfocus();
                    form.save();
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pushNamed(context, "/list");
                    });
                  }
                }
              },
              splashFactory: InkRipple.splashFactory,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserAdded ||
                state is UserDeleted ||
                state is UserSaved ||
                state is UserLoaded) {
              if (state.data.isNotEmpty) {
                return ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final TextEditingController nameController =
                        TextEditingController();
                    final TextEditingController emailController =
                        TextEditingController();
                    User user = state.data.elementAt(index);
                    nameController.value = TextEditingValue(
                      text: user.name, // same thing as 10.toString()
                      selection: TextSelection.fromPosition(
                        TextPosition(offset: user.name.length),
                      ),
                    );
                    emailController.value = TextEditingValue(
                      text: user.email, // same thing as 10.toString()
                      selection: TextSelection.fromPosition(
                        TextPosition(offset: user.email.length),
                      ),
                    );

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ClipPath(
                        clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              color: DSColor.primary,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "User Details ${user.id}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<UserBloc>()
                                          .add(DeleteUserEvent(user: user));
                                    },
                                    child: const SizedBox(
                                      width: 40,
                                      child: Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      autocorrect: false,
                                      controller: nameController,
                                      keyboardType: TextInputType.name,
                                      onChanged: (value) {
                                        if (_debounce?.isActive ?? false) {
                                          _debounce?.cancel();
                                        }
                                        _debounce = Timer(
                                            const Duration(milliseconds: 500),
                                            () {
                                          context.read<UserBloc>().add(
                                                SaveUserEvent(
                                                  user: user.copyWith(
                                                    name: nameController.text,
                                                    email: emailController.text,
                                                  ),
                                                ),
                                              );
                                        });
                                      },
                                      validator: (val) {
                                        var regex = RegExp(r"^[a-zA-Z]");
                                        if (val == null) return null;
                                        if (val.isEmpty) {
                                          return "Full name is invalid.";
                                        }
                                        if (!regex.hasMatch(val)) {
                                          return "Full name is invalid.";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: const Icon(
                                          Icons.person,
                                        ),
                                        prefixIconConstraints:
                                            const BoxConstraints(
                                          minWidth: 50,
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black38.withAlpha(50),
                                            width: 0.5,
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black38.withAlpha(50),
                                            width: 0.5,
                                          ),
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.blue,
                                            width: 0.5,
                                          ),
                                        ),
                                        hintStyle: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black38.withAlpha(150),
                                        ),
                                        hintText: "Full Name",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      autocorrect: false,
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (val) {
                                        var regex = RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                        if (val == null) return null;
                                        if (val.isEmpty) {
                                          return "Email is invalid.";
                                        }
                                        if (!regex.hasMatch(val)) {
                                          return "Email is invalid.";
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        if (_debounce?.isActive ?? false) {
                                          _debounce?.cancel();
                                        }
                                        _debounce = Timer(
                                            const Duration(milliseconds: 500),
                                            () {
                                          context.read<UserBloc>().add(
                                                SaveUserEvent(
                                                  user: user.copyWith(
                                                    name: nameController.text,
                                                    email: emailController.text,
                                                  ),
                                                ),
                                              );
                                        });
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: const Icon(
                                          Icons.email,
                                        ),
                                        prefixIconConstraints:
                                            const BoxConstraints(
                                          minWidth: 50,
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black38.withAlpha(50),
                                            width: 0.5,
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black38.withAlpha(50),
                                            width: 0.5,
                                          ),
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.blue,
                                            width: 0.5,
                                          ),
                                        ),
                                        hintStyle: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black38.withAlpha(150),
                                        ),
                                        hintText: "Email Address",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const EmptyCard();
              }
            } else {
              return const EmptyCard();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<UserBloc>().add(AddUserEvent());
        },
        tooltip: 'Add User',
        child: const Icon(Icons.add),
      ), //
    );
  }
}
