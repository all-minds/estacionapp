import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionapp/components/default_app_bar.dart';
import 'package:estacionapp/constants/font_size.dart';
import 'package:estacionapp/models/parking.dart';
import 'package:estacionapp/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:estacionapp/constants/spacing.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  User? loggedUser;

  @override
  Widget build(BuildContext context) {
    final authRepository = FirebaseAuthService(context: context);

    loggedUser = authRepository.getUser();

    final userInfoContainer = Container(
        padding: const EdgeInsets.all(Spacing.base),
        //color: Colors.amber,
        child: Column(
          children: [
            CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(loggedUser!.photoURL!)),
            Padding(
                padding: const EdgeInsets.all(Spacing.base),
                child: Text(
                    loggedUser != null
                        ? loggedUser!.displayName!
                        : 'Desconhecido',
                    style: const TextStyle(fontSize: FontSize.title)))
          ],
        ));

    Widget parkingListTile(
        BuildContext context, QueryDocumentSnapshot snapshot) {
      Parking parking = Parking.fromSnapshot(snapshot);
      return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: Spacing.base),
          title: Text(
            parking.label,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Text(
                  "Endereço: ${parking.address.streetName}, ${parking.address.city}",
                  style: const TextStyle(color: Colors.white))
            ],
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.white,
          ));
    }

    Widget parkingCard(BuildContext context, QueryDocumentSnapshot snapshot) {
      return Card(
        elevation: 8.0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(0, 119, 182, .9)),
            child: parkingListTile(context, snapshot)),
      );
    }

    Widget buildParkingListItems(
        BuildContext context, List<QueryDocumentSnapshot> snapshot) {
      return ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: snapshot
              .map((parking) => parkingCard(context, parking))
              .toList());
    }

    Widget buildParkingList(BuildContext context) {
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("parkings").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();

          if (snapshot.data == null) {
            return const Text("Não foram encontratos estacionamentos");
          } else {
            return buildParkingListItems(context, snapshot.data!.docs);
          }
        },
      );
    }

    return Scaffold(
      appBar: DefaultAppBar(onLogoutPressed: authRepository.signOut),
      body: Column(children: <Widget>[
        userInfoContainer,
        // parkingListFilter,
        Expanded(child: buildParkingList(context))
      ]),
    );
  }
}
