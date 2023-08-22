import 'package:flutter/material.dart';
import 'package:safe_pink/view/home/info/info_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final styleText = const TextStyle(
    color: Color.fromARGB(255, 239, 7, 96),
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  final bordas = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 7, 96),

      //APP BAR
      appBar: AppBar(
        toolbarHeight: size.height * .1,
        backgroundColor: const Color.fromARGB(255, 239, 7, 96),
        elevation: 0,
        title: Center(
          child: Container(
            width: size.width * .8,
            height: size.height * .07,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/alert_red.png"),
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //ALERTA
                Container(
                  width: size.width * .35,
                  height: size.width * .35,
                  decoration: bordas,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * .06),
                        child: const Image(
                            image: AssetImage("assets/alert_white.png"),
                            fit: BoxFit.cover),
                      ),
                      Text("Alerta", style: styleText)
                    ],
                  ),
                ),

                //LOCAL
                Container(
                  width: size.width * .35,
                  height: size.width * .35,
                  decoration: bordas,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * .06),
                        child: const Image(
                            image: AssetImage("assets/local.png"),
                            fit: BoxFit.cover),
                      ),
                      Text("Localização", style: styleText)
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //FRIENDS
                Container(
                  width: size.width * .35,
                  height: size.width * .35,
                  decoration: bordas,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * .06),
                        child: const Image(
                            image: AssetImage("assets/friends.png"),
                            fit: BoxFit.cover),
                      ),
                      Text("Amigos", style: styleText)
                    ],
                  ),
                ),

                //INFO
                GestureDetector(
                  child: Container(
                    width: size.width * .35,
                    height: size.width * .35,
                    decoration: bordas,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * .06),
                          child: const Image(
                              image: AssetImage("assets/info.png"),
                              fit: BoxFit.cover),
                        ),
                        Text("Informações", style: styleText)
                      ],
                    ),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InfoPage(),
                    ),
                  ),
                ),
              ],
            ),

            //PERFIL
            Container(
              width: size.width * .35,
              height: size.width * .35,
              decoration: bordas,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .06),
                    child: const Image(
                        image: AssetImage("assets/user.png"),
                        fit: BoxFit.cover),
                  ),
                  Text("Perfil", style: styleText)
                ],
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
