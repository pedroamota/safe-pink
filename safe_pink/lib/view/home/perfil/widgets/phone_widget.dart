import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_pink/components/components_style.dart';
import 'package:safe_pink/components/style_form_field.dart';
import 'package:safe_pink/database/servicesDB.dart';
import 'package:safe_pink/services/auth_service.dart';

class PhoneWidget {
  show(context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String errorSenha = "";
    TextEditingController phone = TextEditingController();
    //password.text = user.password;

    submit(auth, context) async {
      if (formKey.currentState!.validate()) {
        final auth = Provider.of<AuthService>(context, listen: false);
        final db = ServicesDB(auth: auth);
        db.updatePhone(phone.text, context);
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
            'Alterar Telefone',
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
                  height: size.height * .15,
                  alignment: Alignment.center,
                  child: TextFormFieldComponent(
                    isRed: true,
                    controller: phone,
                    label: 'Telefone',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite seu telefone';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Container(
                color: const Color.fromARGB(255, 239, 7, 96),
                width: MediaQuery.of(context).size.height * .5,
                height: 5,
              ),
              IconButton(
                onPressed: () => submit(auth, context),
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
