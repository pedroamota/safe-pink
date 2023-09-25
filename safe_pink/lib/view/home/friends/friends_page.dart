import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_pink/components/components_style.dart';
import 'package:safe_pink/components/style_form_field.dart';
import 'package:safe_pink/database/servicesDB.dart';
import 'package:safe_pink/services/auth_service.dart';

import 'add_friends.dart';
import 'list_friends.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  TextEditingController email = TextEditingController();
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 7, 96),
      resizeToAvoidBottomInset: false,
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
              'Amigos',
              style: TextStyle(
                color: Color.fromARGB(255, 239, 7, 96),
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .8,
                  width: size.width * .7,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * .15,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Digite o nome do amigo',
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.black54,
                            ),
                            filled: true,
                            isDense: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              searchTerm = value.toLowerCase();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        height: size.height * .6,
                        child: StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('dados')
                              .doc(auth.usuario!.email!)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            } else {
                              Map<String, dynamic> userData =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              List<dynamic> friendList =
                                  userData['friends'] ?? [];
                              return ListView.builder(
                                itemCount: friendList.length,
                                itemBuilder: (context, index) {
                                  final friend = friendList.elementAt(index);
                                  if (searchTerm.isNotEmpty &&
                                      !friend
                                          .toLowerCase()
                                          .contains(searchTerm)) {
                                    return Container(); // Oculta amigos que não correspondem à pesquisa
                                  }
                                  return Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(Icons.person_outlined),
                                        SizedBox(
                                          width: size.width * .5,
                                          child: Text(
                                            friend,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => AddFriend().show(context),
                  icon: const Icon(
                    Icons.person_add_rounded,
                    size: 40,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
