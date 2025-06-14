import 'package:IPMaster/core/widgets/app_fullwidth_button.dart';
import 'package:IPMaster/core/widgets/app_input_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:IPMaster/modules/dashboard/views/dashboard_view.dart';
import 'package:IPMaster/modules/auth/views/register_view.dart';
import 'package:email_validator/email_validator.dart';
import 'package:IPMaster/modules/auth/data/users_database_helper.dart';
import 'package:IPMaster/modules/auth/models/user_model.dart';

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

    final db = UsersDatabaseHelper();
    final User? user = await db.loginUser(email, password);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bem-vindo, ${user.displayName}!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardView(user: user)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ou password inválidos')),
      );
    }
  }

  /// Interface visual do ecrã de conversão.
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
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 150),
                Text(
                  'Bem vindo',
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
                SizedBox(height: 26),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      AppInputTextformfield(
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Insera o seu e-mail',
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
                        icon: Icons.lock_outline,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'A password é obrigatória';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      AppFullWidthButton(
                        text: "Login",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _login();
                          }
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                          top: 40,
                          left: 40,
                          right: 40,
                          bottom: 35,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/icons/apple_icon.png",
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(width: 5),
                          Image.asset(
                            "assets/images/icons/facebook_icon.png",
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(width: 7),
                          Image.asset(
                            "assets/images/icons/google_icon.png",
                            height: 25,
                            width: 25,
                          ),
                          SizedBox(width: 13),
                          Image.asset(
                            "assets/images/icons/x_icon.png",
                            height: 27,
                            width: 27,
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterView(),
                            ),
                          );
                        },
                        child: Text("Ainda não tem conta? Crie aqui."),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterView(),
                            ),
                          );
                        },
                        child: Text(
                          "Quer ver o nosso leaderboard? Clique aqui.",
                        ),
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
