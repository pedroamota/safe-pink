import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_pink/components/components_style.dart';
import 'package:safe_pink/components/style_form_field.dart';
import 'package:safe_pink/database/servicesDB.dart';
import 'package:safe_pink/services/auth_service.dart';

class AddFriend {
  show(context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String errorSenha = "";
    TextEditingController email = TextEditingController();
    //email.text = user.email;

    submit(auth) async {
      if (formKey.currentState!.validate()) {
        try {
          ServicesDB(auth: auth).addFriend(
            email.text,
            context,
          );
        } on AuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.purple,
              content: Text(e.message),
            ),
          );
        }
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
            'Adicionar amigo',
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
              Form(
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
                        label: 'Novo amigo',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite o email do seu amigo';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Digite um email valido';
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
                icon: const Icon(
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
