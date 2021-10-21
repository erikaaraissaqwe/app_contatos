import 'package:app_crud/models/user.dart';
import 'package:app_crud/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id!;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context)!.settings.arguments == null
        ? null
        : ModalRoute.of(context)!.settings.arguments as User;
    user ?? _loadFormData(user!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Formulário'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                final isValid = _form.currentState!.validate();
                if (isValid) {
                  _form.currentState!.save();
                  Provider.of<Users>(context, listen: false).put(
                    User(
                      id: _formData['id'],
                      name: _formData['name']!,
                      email: _formData['email']!,
                      avatarUrl: _formData['avatarUrl']!,
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.save_rounded),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _form,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: _formData['name'],
                    decoration: const InputDecoration(labelText: "NOME"),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Nome inválido!";
                      }
                    },
                    onSaved: (value) => _formData['name'] = value!,
                  ),
                  TextFormField(
                    initialValue: _formData['email'],
                    decoration: const InputDecoration(labelText: "EMAIL"),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email inválido!";
                      }
                    },
                    onSaved: (value) => _formData['email'] = value!,
                  ),
                  TextFormField(
                    initialValue: _formData['avatarUrl'],
                    decoration: const InputDecoration(labelText: "URL"),
                    onSaved: (value) => _formData['avatarUrl'] = value!,
                  ),
                ],
              ),
            )));
  }
}
