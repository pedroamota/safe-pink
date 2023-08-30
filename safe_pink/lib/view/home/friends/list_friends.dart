import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendListScreen extends StatelessWidget {
  final String userEmail;

  const FriendListScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.maxFinite,
      height: size.height * .6,
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('dados')
            .doc(userEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            Map<String, dynamic> userData =
                snapshot.data!.data() as Map<String, dynamic>;
            List<dynamic> friendList = userData['friends'] ?? [];
            return ListView.builder(
              itemCount: friendList.length,
              itemBuilder: (context, index) {
                final friend = friendList.elementAt(index);

                return Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}
