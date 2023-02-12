import 'package:file_templeate/Auth/signin.dart';
import 'package:file_templeate/screen/sponsor/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../homePage/BottomNavigationBar.dart';

class HomePageSponsor extends StatefulWidget {
  const HomePageSponsor({super.key});

  @override
  State<HomePageSponsor> createState() => _HomePageSponsorState();
}

class _HomePageSponsorState extends State<HomePageSponsor> {
  final Stream<QuerySnapshot> _usersStreamPackage = FirebaseFirestore.instance
      .collection('Users')
      .where("role", isEqualTo: "sponser")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        title: Text(
          ' ممول الخدمة  ',
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            print(FirebaseAuth.instance.currentUser!.uid);
            Get.to(() => BottomNavigation());
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Signin()));
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStreamPackage,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                // childAspectRatio: 7 / 8,
                mainAxisSpacing: 5,
                //crossAxisSpacing: 2,
                crossAxisCount: 1,
              ),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int i) {
                return InkWell(
                  onTap: () {
                    Get.to(() => ChatScreen(
                        //data: snapshot.data!.docs[i],
                        //ID_Doc:snapshot.data!.docs[i].id
                        ));
                  },
                  child: ListView(
                    children: [
                      ListTile(
                        tileColor: Colors.black12,
                        title: Text(
                          textDirection: TextDirection.rtl,
                          "الإسم:${snapshot.data!.docs[i]["username"]}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                      ),
                      ListTile(
                        tileColor: Colors.black12,
                        title: Text(
                          textDirection: TextDirection.rtl,
                          "البريد الالكتروني:    ${snapshot.data!.docs[i]["email"]}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(
                          Icons.email,
                          color: Colors.blue,
                        ),
                      ),
                      ListTile(
                        tileColor: Colors.black12,
                        title: Text(
                          textDirection: TextDirection.rtl,
                          "تواصل  ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(
                          Icons.chat_outlined,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
