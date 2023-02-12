// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../comment.dart';
import '../../vender/orders/AddOrders.dart';

class DetailsServiceForUser extends StatefulWidget {
  final data;
  final ID_Doc;

  DetailsServiceForUser({
    super.key,
    this.data,
    this.ID_Doc,
  });

  @override
  State<DetailsServiceForUser> createState() => _DetailsServiceForUserState();
}

class _DetailsServiceForUserState extends State<DetailsServiceForUser> {
  CollectionReference ref = FirebaseFirestore.instance.collection("Service");
  CollectionReference refFavorite =
      FirebaseFirestore.instance.collection("Favorites");
  bool isPressed = false;
  late String name;
  late String desc;
  late String imageURl;
  late String price;
  @override
  void initState() {
    name = widget.data['name'].toString();
    desc = widget.data['desc'].toString();
    imageURl = widget.data['imageurl'].toString();
    price = widget.data['salary'].toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            value: 10,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );

    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        "\$" + price.toString(),
        style: TextStyle(color: Colors.white),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),

        SizedBox(height: 10.0),
        // Text(
        // name,
        //   style: TextStyle(color: Colors.white, fontSize: 45.0),
        // ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            // Expanded(
            //     flex: 6,
            //     child: Padding(
            //         padding: EdgeInsets.only(left: 10.0),
            //         child: Text(
            //         name.toString(),
            //           style: TextStyle(color: Colors.white),
            //         ))),
            Expanded(flex: 1, child: coursePrice)
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new NetworkImage("$imageURl"),
                fit: BoxFit.cover,
              ),
            )),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Column(
      children: [
        Text(
          "الاسم :${name.toString()}",
          style: TextStyle(fontSize: 18.0),
          textDirection: TextDirection.rtl,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "السعر :${price.toString()}",
          style: TextStyle(fontSize: 18.0),
          textDirection: TextDirection.rtl,
        ),
        Text(
          "التفاصيل :${desc.toString()}",
          style: TextStyle(fontSize: 18.0),
          textDirection: TextDirection.rtl,
        )
      ],
    );
    final readButton = Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Text(
                  'إضافة الى المفضلة',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    color: Colors.red,
                    onPressed: () async {
                      setState(() {
                        isPressed = !isPressed;
                      });
                      if (isPressed == true) {
                        await addTOFavorite();
                      } else {}
                    },
                    icon: isPressed == false
                        ? Icon(Icons.favorite_border_outlined)
                        : Icon(Icons.favorite)),
                SizedBox(
                  width: 70,
                ),
                Text(
                  'التعليقات',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  tooltip: "التعليقات",
                  color: Color.fromARGB(255, 0, 0, 0),
                  onPressed: (() {
                    Get.to(comment(
                      ID_doc:widget.ID_Doc ,
                    ));
                  }),
                  icon: Icon(Icons.comment),
                )
              ],
            )),
        Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              onPressed: () => {
                Get.to(() => AddOrders(
                      ID_doc: widget.ID_Doc,
                    ))
              },
              color: Colors.black,
              child: Text(
                " حجز خدمة  ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            )),
      ],
    );
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: ListView(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }

  addTOFavorite() async {
    refFavorite.add({
      "name": name,
      "desc": desc,
      "salary": price,
      "booking": "true",
      "imageurl": imageURl,
      "Publishing": "1",
      "user_id": FirebaseAuth.instance.currentUser!.uid.toString()
    }).then((value) {
      Get.snackbar("تمت العملية بنجاح  ", " ",
          colorText: Colors.white,
          backgroundColor: Colors.lightBlue,
          icon: const Icon(Icons.add_alert),
          snackPosition: SnackPosition.BOTTOM);
    }).catchError((e) {
      print(e);
    });
  }
}
