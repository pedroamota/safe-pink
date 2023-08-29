import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_pink/main.dart';
import 'package:safe_pink/view/home/home_page.dart';
import 'package:safe_pink/view/login/login_page.dart';
import '../../components/style_form_field.dart';
import '../../database/servicesDB.dart';
import '../../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  submitForm(auth) async {
    if (formKey.currentState!.validate()) {
      FocusNode().unfocus();
      try {
        setState(() {
          loading = true;
        });
        await context.read<AuthService>().register(
              emailController.text,
              passwordController.text,
            );
        ServicesDB(auth: auth)
            .saveUser(
              nameController.text,
              usernameController.text,
              phoneController.text,
            )
            .whenComplete(
              () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ),
                (Route<dynamic> route) => false,
              ),
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
          SizedBox(
            height: size.height,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 50,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    height: size.width * .1,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                          controller: nameController,
                          label: 'Nome completo',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu nome';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormFieldComponent(
                          controller: usernameController,
                          label: 'Nome de usuario',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu nome de usuario';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormFieldComponent(
                          controller: phoneController,
                          label: 'Telefone',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu telefone';
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
                                : const Text("Registrar"),
                          ),
                          onTap: () => submitForm(
                            Provider.of<AuthService>(context, listen: false),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Já possui uma conta?'),
                            TextButton(
                              onPressed: () => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                (Route<dynamic> route) => false,
                              ),
                              child: const Text(
                                'Entrar',
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
                  ),
                  SizedBox(height: size.height * .08),
                  Wrap(
                    children: [
                      const Text('Termos de uso e Politicas de Privacidade'),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Ler mais',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
