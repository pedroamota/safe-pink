import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_pink/components/components_style.dart';
import 'package:safe_pink/components/style_form_field.dart';
import 'package:safe_pink/services/auth_service.dart';

class EmailWidget {
  show(context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String errorSenha = "";
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    //email.text = user.email;
    bool updating = false;

    submit(AuthService auth) async {
      if (formKey.currentState!.validate()) {
        updating = true;
        auth.updateEmail(email.text, password.text);
      }
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(top: 20),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          title: const Text(
            'Alterar email',
            style: ComponentsStyle.text,
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: const Color.fromARGB(255, 239, 7, 96),
                width: MediaQuery.of(context).size.height * .5,
                height: 5,
              ),
              updating
                  ? const SizedBox(
                      height: 27.0,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Form(
                      key: formKey,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: size.height * .2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormFieldComponent(
                              isRed: true,
                              controller: email,
                              label: 'Novo email',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Digite seu novo email';
                                } else if (!EmailValidator.validate(value)) {
                                  return 'Digite um email valido';
                                }
                                return null;
                              },
                            ),
                            TextFormFieldComponent(
                              isRed: true,
                              controller: password,
                              label: 'Senha',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Digite sua senha';
                                } else if (value.length < 6) {
                                  return 'Sua senha deve contar no minimo 6 digitos';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
              Container(
                color: const Color.fromARGB(255, 239, 7, 96),
                width: MediaQuery.of(context).size.height * .5,
                height: 5,
              ),
              IconButton(
                onPressed: () => submit(auth),
                icon: updating
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.check,
                        size: 40,
                        color: Color.fromARGB(255, 239, 7, 96),
                      ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
