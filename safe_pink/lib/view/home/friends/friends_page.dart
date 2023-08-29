import 'dart:core';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:safe_pink/components/style_form_field.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final friendController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  submit(){
    
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                        height: size.height * .07,
                        child: TextFormFieldComponent(
                          controller: friendController,
                          label: 'Adicione um amigo',
                        ),
                      ),
                      const SizedBox(height: 30),
                      
                    ],  
                  ),
                ),
                IconButton(
                  onPressed: submit,
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
