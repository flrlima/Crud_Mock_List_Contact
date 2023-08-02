import 'package:flutter/material.dart';
import 'package:primeiro_projeto/provider/user.dart';
import 'package:primeiro_projeto/routes/app_routes.dart';
import 'package:primeiro_projeto/views/user_form.dart';
import 'package:provider/provider.dart';

import 'views/user_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UsersProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const UserList(),
        routes: {
          AppRoutes.home: (_) => const UserList(),
          AppRoutes.userForm: (_) => UserForm()
        },
      ),
    );
  }
}
