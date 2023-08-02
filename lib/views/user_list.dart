import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/user_title.dart';
import 'package:primeiro_projeto/provider/user.dart';
import 'package:primeiro_projeto/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UsersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuários'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.userForm);
              },
              color: Colors.green,
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
          itemCount: users.count,
          itemBuilder: (context, i) => UserTitle(users.all.elementAt(i))),
    );
  }
}
