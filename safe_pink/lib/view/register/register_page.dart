import 'package:flutter/material.dart';
import 'package:safe_pink/view/login/login_page.dart';
import '../../components/style_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  _submitForm() {
    if (formKey.currentState!.validate()) {
      print('validado');
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
                    height: size.width * .3,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormFieldComponent(
                          controller: emailController,
                          label: 'Email',
                        ),
                        const SizedBox(height: 10),
                        TextFormFieldComponent(
                          controller: nameController,
                          label: 'Nome completo',
                        ),
                        const SizedBox(height: 10),
                        TextFormFieldComponent(
                          controller: usernameController,
                          label: 'Nome de usuario',
                        ),
                        const SizedBox(height: 10),
                        TextFormFieldComponent(
                          controller: passwordController,
                          label: 'senha',
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
                          child: const Text("Entrar"),
                        ),
                        const SizedBox(height: 30),
                        Row(
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
                  SizedBox(height: size.height * .2),
                  Center(
                    child: Row(
                      children: [
                        const Text('Termos de uso e Politicas de Privacidade'),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Ler mais',
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
