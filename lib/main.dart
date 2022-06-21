import 'package:bloc_webapp/helper/my_bloc_observer.dart';
import 'package:bloc_webapp/user/bloc/user_bloc.dart';
import 'package:bloc_webapp/user/view/user_list_page.dart';
import 'package:bloc_webapp/user/view/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(),
      child: MaterialApp(
        title: 'BLoC User App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        routes: {
          '/': (context) => const UserPage(),
          '/list': (context) => const UserListPage(),
        },
      ),
    );
  }
}
