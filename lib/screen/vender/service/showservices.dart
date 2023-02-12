// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_templeate/screen/vender/packageservices/AddPackage.dart';
// import 'package:file_templeate/screen/vender/service/AddService.dart';
// import 'package:file_templeate/screen/vender/service/serviceDetails.dart';
// import 'package:file_templeate/widget/homeAppBar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import '../../../widget/services/custom_button.dart';
// import '../packageservices/detailsPackage.dart';
// import 'Editservice.dart';

// class ShowServices extends StatefulWidget {
//   const ShowServices({super.key});

//   @override
//   State<ShowServices> createState() => _ShowServicesState();
// }

// class _ShowServicesState extends State<ShowServices> {
//   final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
//       .collection('PackageServices')
//       .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//       .snapshots();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: homeAppBar(),
//       body: ListView(children: [
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: serviceButton(
//             text: " اضافة خدمة ",
//             onTap: () {
//               print("========================");
//               print(FirebaseAuth.instance.currentUser!.uid);
//               Get.to(() => AddPackage());
//             },
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         serviceButton(
//           text: "  اضافة مجموعة من الخدمات  ",
//           onTap: () {},
//         ),
//         SizedBox(
//           height: 25,
//         ),
//         StreamBuilder<QuerySnapshot>(
//           stream: _usersStream,
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return Text('Something went wrong');
//             }

//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: Text("Loading"));
//             }

//             return GridView.builder(
//                 padding: EdgeInsets.all(10),
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   childAspectRatio: 7 / 8,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                   crossAxisCount: 2,
//                 ),
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (BuildContext context, int i) {
//                   return InkWell(
//                     onTap: () {
//                         // Get.to(() => PackageDetails(
//                         //    data: snapshot.data!.docs[i]   ,
//                         //     ));
//                       },
//                     child: Container(
//                       child: Stack(
//                         children: [
//                           ClipRRect(
//                               borderRadius: BorderRadius.circular(15),
//                               child: Image.network(
//                                 "${snapshot.data!.docs[i]["imageurl"]}",
//                                 height: 250,
//                                 width: 250,
//                                 fit: BoxFit.cover,
//                               )),
//                           Container(
//                             padding: EdgeInsets.all(10),
//                             alignment: Alignment.center,
//                             child: Text(
//                               "${snapshot.data!.docs[i]["name"]}",
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 25),
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.5),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 });
//           },
//         ),
//       ]),
//     );
//   }
// }
