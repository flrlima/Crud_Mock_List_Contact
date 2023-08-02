// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:primeiro_projeto/models/user.dart';
import 'package:primeiro_projeto/provider/user.dart';
import 'package:primeiro_projeto/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTitle extends StatelessWidget {
  final User user;

  const UserTitle(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.edit),
                color: Colors.cyan,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.userForm,
                    arguments: user,
                  );
                }),
            IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: Text('Excluir Usuário'),
                            content: Text('Tem certeza?'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Não'),
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                              ),
                              TextButton(
                                child: Text('Sim'),
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                              )
                            ],
                          )).then((confirmed) {
                    if (confirmed) {
                      Provider.of<UsersProvider>(context, listen: false)
                          .remove(user);
                    }
                  });
                })
          ],
        ),
      ),
    );
  }
}
