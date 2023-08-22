import 'package:flutter/material.dart';
import 'package:safe_pink/services/calls.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 7, 96),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: size.height * .1,
        backgroundColor: const Color.fromARGB(255, 239, 7, 96),
        elevation: 0,
        title: Center(
          child: Container(
            width: size.width * .8,
            height: size.height * .07,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: const Text(
              'Safe Pink',
              style: TextStyle(
                color: Color.fromARGB(255, 239, 7, 96),
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(children: [
          const SizedBox(height: 50),
          const Text(
            "Em caso de emergência, ligue:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              height: size.height * .05,
              width: size.width * .7,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Image(
                    image: AssetImage("assets/call.png"),
                  ),
                  Text(
                    '180',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => Call().ligar('180'),
          ),
          const Text("Central de atendimento da mulher"),
          const SizedBox(height: 20),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              height: size.height * .05,
              width: size.width * .7,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Image(
                    image: AssetImage("assets/call.png"),
                  ),
                  Text(
                    '190',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => Call().ligar('190'),
          ),
          Text("Policia minitar")
        ]),
      ),
    );
  }
}
