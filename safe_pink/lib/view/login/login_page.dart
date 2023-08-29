import 'dart:core';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_pink/services/auth_service.dart';
import '../../components/style_form_field.dart';
import '../register/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  bool loading = false;

  _submitForm() async {
    if (formKey.currentState!.validate()) {
      FocusNode().unfocus();
      try {
        setState(() {
          loading = true;
        });
        await context.read<AuthService>().login(
              emailController.text,
              passwordController.text,
            );
      } on AuthException catch (e) {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.purple,
            content: Text(e.message),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 7, 96),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 80,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Safe Pink.',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                  ),
                ),
                SizedBox(
                  height: size.width * .4,
                  child: const Image(
                    image: AssetImage("assets/alert_rosa.png"),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      TextFormFieldComponent(
                        controller: emailController,
                        label: 'Email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite seu email';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Digite um email valido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormFieldComponent(
                        controller: passwordController,
                        label: 'senha',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite sua senha';
                          } else if (value.length < 6) {
                            return 'Sua senha deve contar no minimo 6 digitos';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        child: Container(
                          width: size.width,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color.fromARGB(255, 189, 22, 86),
                          ),
                          child: loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text("Entrar"),
                        ),
                        onTap: () => _submitForm(),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        child: const Text('Esqueceu a senha?'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * .2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Não possui uma conta?'),
                    TextButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                        (Route<dynamic> route) => false,
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
