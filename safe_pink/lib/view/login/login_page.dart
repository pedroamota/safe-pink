import 'package:flutter/material.dart';
import 'package:safe_pink/view/home/home_page.dart';
import '../../components/style_form_field.dart';
import '../register/register_page.dart';
import 'dart:core';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  _submitForm() {
    if (formKey.currentState!.validate()) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 7, 96),
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 120,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormFieldComponent(
                          controller: emailController,
                          label: 'email',
                        ),
                        const SizedBox(height: 10),
                        TextFormFieldComponent(
                          controller: passwordController,
                          label: 'senha',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu email';
                            }
                            if (!EmailValidator.validate(value)) {
                              return 'Digite um email valido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Container(
                            width: size.width,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.red,
                            ),
                            child: const Text("Entrar")),
                        const SizedBox(height: 10),
                        GestureDetector(
                          child: const Text('Esqueceu a senha?'),
                          onTap: () => _submitForm(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * .2),
                  Center(
                    child: Row(
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
                    ),
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
/*
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            labelText: 'Email',
          ),
        ),
*/
