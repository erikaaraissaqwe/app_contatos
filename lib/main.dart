import 'package:app_crud/provider/user.dart';
import 'package:app_crud/routes/app_routes.dart';
import 'package:app_crud/views/user_form.dart';
import 'package:app_crud/views/user_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Users()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        routes: {
          AppRoutes.HOME: (context) => UserList(),
          AppRoutes.USER_FORM:(context) => UserForm(),
        },
      ),
    );
  }
}
