import 'package:flutter/material.dart';
import 'package:primeiro_projeto/models/user.dart';
import 'package:primeiro_projeto/provider/user.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final form = GlobalKey<FormState>();

  final Map<String, String> formData = {};

  void loadFormData(User user) {
    if (user.id!.isNotEmpty) {
      formData['id'] = user.id.toString();
      formData['name'] = user.name;
      formData['email'] = user.email;
      formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Object? eNull = ModalRoute.of(context)?.settings.arguments;
    if (eNull != null) {
      final user = eNull as User;
      loadFormData(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Usuários'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                final isValid = form.currentState!.validate();

                if (isValid) {
                  form.currentState?.save();

                  Provider.of<UsersProvider>(context, listen: false).put(
                    User(
                        id: formData['id'],
                        name: formData['name'].toString(),
                        email: formData['email'].toString(),
                        avatarUrl: formData['avatarUrl'].toString()),
                  );

                  Navigator.of(context).pop();
                }
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: formData['name'],
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nome Inválido';
                    }
                    if (value.trim().length < 3) {
                      return 'Mínimo de 3 caracteres';
                    }
                    return null;
                  },
                  onSaved: (value) => formData['name'] = value.toString(),
                ),
                TextFormField(
                  initialValue: formData['email'],
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  onSaved: (value) => formData['email'] = value.toString(),
                ),
                TextFormField(
                  initialValue: formData['avatarUrl'],
                  decoration: const InputDecoration(labelText: 'URL do Avatar'),
                  onSaved: (value) => formData['avatarUrl'] = value.toString(),
                ),
              ],
            )),
      ),
    );
  }
}
