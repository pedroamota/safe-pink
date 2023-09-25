import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_pink/components/components_style.dart';
import 'package:safe_pink/database/servicesDB.dart';
import 'package:safe_pink/models/user.dart';
import 'package:safe_pink/services/auth_service.dart';
import 'package:safe_pink/services/notify_user.dart';

class LevelsPopUp {
  static show(context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    final user = Provider.of<Usuario>(context, listen: false);
    final db = ServicesDB(auth: auth);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(top: 20),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          title: const Text(
            'Qual o nivel de perigo?',
            style: ComponentsStyle.text,
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: const Color.fromARGB(255, 239, 7, 96),
                width: MediaQuery.of(context).size.height * .4,
                height: 5,
              ),
              TextButton(
                onPressed: () => {
                  db.sendMessage(user.friends!, user.name!, 'Nivel 1'),
                  Navigator.of(context).pop(),
                  Navigator.of(context).pop(),
                  NotifyUser.showScackbar(context,'Nivel 1'),
                },
                child: const Text(
                  'Nivel 1',
                  style: ComponentsStyle.text,
                ),
              ),
              Container(
                color: const Color.fromARGB(255, 239, 7, 96),
                width: MediaQuery.of(context).size.height * .4,
                height: 5,
              ),
              TextButton(
                onPressed: () => {
                  db.sendMessage(user.friends!, user.name!, 'Nivel 2'),
                  Navigator.of(context).pop(),
                  Navigator.of(context).pop(),
                  NotifyUser.showScackbar(context,'Nivel 2'),

                },
                child: const Text(
                  'Nivel 2',
                  style: ComponentsStyle.text,
                ),
              ),
              Container(
                color: const Color.fromARGB(255, 239, 7, 96),
                width: MediaQuery.of(context).size.height * .4,
                height: 5,
              ),
              TextButton(
                onPressed: () => {
                  db.sendMessage(user.friends!, user.name!,'Nivel 3'),
                  Navigator.of(context).pop(),
                  Navigator.of(context).pop(),
                  NotifyUser.showScackbar(context,'Nivel 3'),
                },
                child: const Text(
                  'Nivel 3',
                  style: ComponentsStyle.text,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
