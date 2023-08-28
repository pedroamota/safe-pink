import 'package:flutter/material.dart';

class AlertPopUp {
  show(context) {
    const style = TextStyle(
      color: Color.fromARGB(255, 239, 7, 96),
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(top: 20),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            title: const Text(
              'Deseja realmente acionar o alarme?',
              style: style,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Sim',
                          style: style,
                        )),
                    Container(
                      color: const Color.fromARGB(255, 239, 7, 96),
                      height: MediaQuery.of(context).size.height * .07,
                      width: 5,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Não',
                        style: style,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
