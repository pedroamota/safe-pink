import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:provider/provider.dart';
import 'package:safe_pink/database/servicesDB.dart';
import 'package:safe_pink/services/auth_service.dart';
import 'package:safe_pink/services/position_service.dart';
import 'package:safe_pink/view/home/alert/alert_pop_up.dart';
import 'package:safe_pink/view/home/friends/friends_page.dart';
import 'package:safe_pink/view/home/info/info_page.dart';
import 'package:safe_pink/view/home/local/local_page.dart';
import 'package:safe_pink/view/home/perfil/perfil_page.dart';

import '../../components/components_style.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer _timer;
  getData() async {
    final auth = Provider.of<AuthService>(context, listen: false);
    final db = ServicesDB(auth: auth);
    Provider.of<PositionService>(context, listen: false).getPosition();
    db.getData(context);
    db.listenToAlert(context);
    db.getLocalFriends(context);
    await FlutterBackground.enableBackgroundExecution();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of<AuthService>(context, listen: false);
    final position = Provider.of<PositionService>(context, listen: false);
    final db = ServicesDB(auth: auth);
    Timer.periodic(const Duration(minutes: 1), (timer) {
      db.saveLocal(position.latitude, position.longitude);
      db.sendAlert(context, '', false);
    });
    db.getLocalFriends(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 7, 96),

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

      //BODY
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
                GestureDetector(
                  child: Container(
                    width: size.width * .35,
                    height: size.width * .35,
                    decoration: ComponentsStyle.bordas,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * .06),
                          child: const Image(
                              image: AssetImage("assets/alert_white.png"),
                              fit: BoxFit.cover),
                        ),
                        const Text("Alerta", style: ComponentsStyle.text)
                      ],
                    ),
                  ),
                  onTap: () {
                    AlertPopUp.show(context);
                  },
                ),

                //LOCAL
                GestureDetector(
                  child: Container(
                    width: size.width * .35,
                    height: size.width * .35,
                    decoration: ComponentsStyle.bordas,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * .06),
                          child: const Image(
                              image: AssetImage("assets/local.png"),
                              fit: BoxFit.cover),
                        ),
                        const Text("Localização", style: ComponentsStyle.text)
                      ],
                    ),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocalPage(),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //FRIENDS
                GestureDetector(
                  child: Container(
                    width: size.width * .35,
                    height: size.width * .35,
                    decoration: ComponentsStyle.bordas,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * .06),
                          child: const Image(
                              image: AssetImage("assets/friends.png"),
                              fit: BoxFit.cover),
                        ),
                        const Text("Amigos", style: ComponentsStyle.text)
                      ],
                    ),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FriendsPage(),
                    ),
                  ),
                ),

                //INFO
                GestureDetector(
                  child: Container(
                    width: size.width * .35,
                    height: size.width * .35,
                    decoration: ComponentsStyle.bordas,
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
                        const Text(
                          "Informações",
                          style: ComponentsStyle.text,
                        )
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
            GestureDetector(
              child: Container(
                width: size.width * .35,
                height: size.width * .35,
                decoration: ComponentsStyle.bordas,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * .06),
                      child: const Image(
                        image: AssetImage("assets/user.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Text("Perfil", style: ComponentsStyle.text)
                  ],
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PerfilPage(),
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
