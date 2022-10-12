import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionapp/components/default_app_bar.dart';
import 'package:estacionapp/constants/spacing.dart';
import 'package:estacionapp/models/parking.dart';
import 'package:estacionapp/models/parking_lot.dart';
import 'package:estacionapp/services/parking_lots_repository.dart';
import 'package:estacionapp/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListParkingLots extends StatefulWidget {
  const ListParkingLots({super.key});
  final title = const Text("Lista de Vagas");
  @override
  State<ListParkingLots> createState() => _ListParkingLotsState();
}

class _ListParkingLotsState extends State<ListParkingLots> {
  User? loggedUser;
  Parking? parking;

  @override
  Widget build(BuildContext context) {
    loggedUser = FirebaseAuthService.getUser();
    parking = ModalRoute.of(context)!.settings.arguments as Parking;

    return Scaffold(
      appBar: const DefaultAppBar(),
      body: buildList(context),
    );
  }

  Widget buildList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: ParkingLotsRepository.listParkingLots(parking!.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();
          if (snapshot.data == null) {
            return const Text("Nenhuma vaga encontrada");
          } else {
            return buildListSeparated(context, snapshot.data!.docs);
          }
        });
  }

  Widget buildListSeparated(
      BuildContext context, List<QueryDocumentSnapshot> snapshot) {
    return ListView(
        padding: const EdgeInsets.only(top: 30),
        children:
            snapshot.map((data) => buildListItem(context, data)).toList());
  }

  Widget buildListItem(BuildContext context, QueryDocumentSnapshot data) {
    ParkingLot pl = ParkingLot.fromSnapshot(data);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(0, 119, 182, .9)),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: Spacing.base),
              title: Text(
                "Número da vaga: ${pl.number}",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Andar: ${pl.floor}",
                  style: const TextStyle(color: Colors.white)),
              trailing: buildTrailingButton(context, pl),
            )));
  }

  Widget buildTrailingButton(BuildContext context, ParkingLot pl) {
    final userId = loggedUser!.uid;
    if (pl.occupantId == null) {
      return ElevatedButton(
          onPressed: () => {
                ParkingLotsRepository.updateParkingLot(
                    pl, parking!.id, userId, true)
              },
          style: ElevatedButton.styleFrom(minimumSize: const Size(100.0, 35.0)),
          child: const Text("Ocupar"));
    } else if (pl.occupantId == userId) {
      return OutlinedButton(
        onPressed: () => {
          ParkingLotsRepository.updateParkingLot(pl, parking!.id, userId, false)
        },
        style: OutlinedButton.styleFrom(backgroundColor: Colors.white),
        child: const Text(
          "Desocupar",
          style: TextStyle(
              color: Color.fromRGBO(0, 119, 182, .9),
              fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return TextButton(
        onPressed: () => {},
        child: const Text(
          "Indisponível",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
    }
  }
}
