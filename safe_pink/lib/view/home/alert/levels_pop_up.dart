import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_pink/components/components_style.dart';
import 'package:safe_pink/database/servicesDB.dart';
import 'package:safe_pink/models/user.dart';
import 'package:safe_pink/services/auth_service.dart';
import 'package:safe_pink/services/notify_user.dart';

class LevelsPopUp {
  static show(context) {
    String nivel1 = 'Acompanhe minha localização!';
    String nivel2 = 'Estou sentindo que alguem está me seguindo!';
    String nivel3 = 'Preciso de ajuda agora!';
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
                width: MediaQuery.of(context).size.height * .5,
                height: 5,
              ),
              TextButton(
                onPressed: () => {
                  db.sendAlert(context, nivel1, true),
                  Navigator.of(context).pop(),
                  Navigator.of(context).pop(),
                  NotifyUser.showScackbar(context, nivel1),
                },
                child: Text(
                  nivel1,
                  style: ComponentsStyle.text,
                ),
              ),
              Container(
                color: const Color.fromARGB(255, 239, 7, 96),
                width: MediaQuery.of(context).size.height * .5,
                height: 5,
              ),
              TextButton(
                onPressed: () => {
                  db.sendAlert(context, nivel2, true).whenComplete(() {
                    Future.delayed(const Duration(minutes: 5), () {
                      db.sendAlert(context, '', false);
                    });
                  }),
                  Navigator.of(context).pop(),
                  Navigator.of(context).pop(),
                  NotifyUser.showScackbar(context, nivel2),
                },
                child: Text(
                  nivel2,
                  style: ComponentsStyle.text,
                ),
              ),
              Container(
                color: const Color.fromARGB(255, 239, 7, 96),
                width: MediaQuery.of(context).size.height * .5,
                height: 5,
              ),
              TextButton(
                onPressed: () => {
                  db.sendAlert(context, nivel3, true).whenComplete(() {
                    Future.delayed(const Duration(minutes: 5), () {
                      db.sendAlert(context, '', false);
                    });
                  }),
                  Navigator.of(context).pop(),
                  Navigator.of(context).pop(),
                  NotifyUser.showScackbar(context, nivel3),
                },
                child: Text(
                  nivel3,
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
