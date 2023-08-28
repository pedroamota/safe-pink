import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/auth_service.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    AuthService user = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 7, 96),
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
              'Perfil',
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
        child: Column(
          children: [
            const SizedBox(height: 80),

            //NOME DO USUARIO
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              height: size.height * .07,
              width: size.width * .7,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.person_rounded,
                    color: Color.fromARGB(255, 239, 7, 96),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: size.width * .56,
                    padding: EdgeInsets.zero,
                    child: const Text(
                      'Pedro Mota',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
            ),
            const SizedBox(height: 20),

            //EMAIL DO USUARIO
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              height: size.height * .07,
              width: size.width * .7,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.email_outlined,
                    color: Color.fromARGB(255, 239, 7, 96),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: size.width * .56,
                    padding: EdgeInsets.zero,
                    child: Text(
                      user.usuario!.email!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            //TELEFONE DO USUARIO
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              height: size.height * .07,
              width: size.width * .7,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(
                    Icons.local_phone_outlined,
                    color: Color.fromARGB(255, 239, 7, 96),
                  ),
                  Text(
                    '35999693123',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(),
                ],
              ),
            ),
            const SizedBox(height: 20),

            //SEGURANÇA
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              height: size.height * .07,
              width: size.width * .7,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(
                    Icons.verified_user_outlined,
                    color: Color.fromARGB(255, 239, 7, 96),
                  ),
                  Text(
                    'Segurança',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(),
                ],
              ),
            ),
            const SizedBox(height: 20),

            //TROCAR SENHA
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              height: size.height * .07,
              width: size.width * .7,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(
                    Icons.lock,
                    color: Color.fromARGB(255, 239, 7, 96),
                  ),
                  Text(
                    'Trocar senha',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Deseja sair do aplicativo?'),
                TextButton(
                  onPressed: () => setState(() {
                    AuthService().logOut();
                  }),
                  child: const Text(
                    'Sair',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            //TROCA DE SENHA
          ],
        ),
      ),
    );
  }
}
