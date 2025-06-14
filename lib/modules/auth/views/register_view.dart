import 'package:ip_master/core/widgets/app_input_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:ip_master/modules/auth/models/user_model.dart';
import 'package:ip_master/modules/auth/data/users_database_helper.dart';
import 'package:ip_master/core/widgets/app_fullwidth_button.dart';
import 'package:ip_master/modules/auth/views/login_view.dart';

/// Ecrã de registo da aplicação.
/// Permite ao utilizador criar uma conta local, validando os dados e guardando na base de dados.
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>(); // Form key

  // Controladores dos campos do formulário
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Função de registo: valida se o email já existe e insere novo utilizador
  void _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();

    final db = UsersDatabaseHelper();

    final emailTaken = await db.emailExists(email);
    if (emailTaken) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Este e-mail já está registado')),
      );
      return;
    }

    final user = User(email: email, password: password, displayName: name);

    await db.insertUser(user);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registo efetuado com sucesso')),
    );

    Navigator.pop(context); // volta ao login
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/login_background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 150),
                Text(
                  'Crie a sua conta',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Color.fromARGB(255, 29, 28, 28),
                  ),
                ),

                Text(
                  'Entre na sua conta para continuar.',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Color(0xFF1C1C1C),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 26),

                      AppInputTextformfield(
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        hintText: 'Insira o seu nome',
                        icon: Icons.person,
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'O nome é obrigatório';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      AppInputTextformfield(
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        hintText: 'Insira o seu e-mail',
                        icon: Icons.email_outlined,
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

                      AppInputTextformfield(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        hintText: 'Insira a sua password',
                        icon: Icons.password,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'A password é obrigatória';
                          } else if (value.length < 4) {
                            return 'A password deve ter pelo menos 4 caracteres';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      AppFullWidthButton(
                        text: 'Criar Conta',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _register();
                          }
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                          top: 40,
                          left: 40,
                          right: 40,
                          bottom: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(
                              child: Divider(thickness: 1, color: Colors.grey),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text(
                                "OU",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(thickness: 1, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ),
                          );
                        },
                        child: Text("Já tem conta? Faça Login."),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
