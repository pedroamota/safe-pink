import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_pink/components/components_style.dart';
import 'package:safe_pink/components/style_form_field.dart';
import 'package:safe_pink/services/auth_service.dart';

class Recover extends StatefulWidget {
  const Recover({super.key});

  @override
  State<Recover> createState() => _RecoverState();
}

class _RecoverState extends State<Recover> {
  final emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  bool loading = false;

  _submitForm() async {
    if (formKey.currentState!.validate()) {
      try {
        FocusNode().unfocus();

        setState(() {
          loading = true;
        });
        await context
            .read<AuthService>()
            .recover(emailController.text, context);
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
      setState(() {
        loading = false;
      });
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
                    image: AssetImage("assets/lock.png"),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: size.width * .7,
                  child: const Text(
                    'Digite seu e-mail e enviaremos um link para a recuperação da senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
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
                      const SizedBox(height: 30),
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
                              : const Text("Enviar"),
                        ),
                        onTap: () => _submitForm(),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(height: size.height * .2),
              ],
            ),
          )
        ],
      ),
    );
  }
}
