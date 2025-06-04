import 'package:flutter/material.dart';
import 'package:number_converter_app/views/register_view.dart';
import 'package:email_validator/email_validator.dart';
import 'package:number_converter_app/helpers/users_database_helper.dart';
import 'package:number_converter_app/models/user.dart';

/// Ecrã principal da aplicação que permite converter entre diferentes bases.
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final db = DatabaseHelper.instance;
    final User? user = await db.loginUser(email, password);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bem-vindo, ${user.displayName}!')),
      );

      // TODO: Navegar para o dashboard
      // Navigator.pushReplacement(context, MaterialPageRoute(
      //   builder: (_) => HomePage(user: user),
      // ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ou password inválidos')),
      );
    }
  }

  /// Interface visual do ecrã de conversão.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/logo.png', height: 200),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Insere um e-mail',
                    ),
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'O e-mail é obrigatório';
                      } else if (!EmailValidator.validate(value)) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Insere uma password',
                    ),
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'A password é obrigatória';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _login();
                      }
                    },
                    child: const Text("Login"),
                  ),

                  const SizedBox(height: 40),

                  const Divider(thickness: 1.5, color: Colors.grey, height: 10),

                  const SizedBox(height: 40),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterView(),
                        ),
                      );
                    },
                    child: const Text("Register"),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
            // Formulário de entrada e seleção de bases
          ],
        ),
      ),
    );
  }
}
