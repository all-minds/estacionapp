import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionapp/models/occupation.dart';
import 'package:estacionapp/models/parking_lot.dart';
import 'package:estacionapp/repositories/auth_repository.dart';
import 'package:estacionapp/repositories/occupations_repository.dart';
import 'package:estacionapp/repositories/parking_lots_repository.dart';
import 'package:estacionapp/repositories/parking_repository.dart';
import 'package:estacionapp/screens/occupy_parking_lot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListParkingLotsWidget extends StatefulWidget {
  const ListParkingLotsWidget({super.key});
  final title = const Text("Lista de Vagas");
  @override
  State<ListParkingLotsWidget> createState() => _ListParkingLotsWidgetState();
}

class _ListParkingLotsWidgetState extends State<ListParkingLotsWidget> {
  String parkingId = "1ANAmUT3C6YocWtKpMVS";
  final loggedUser = AuthRepository.loggedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title,
      ),
      body: buildList(context),
    );
  }

  Widget buildList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: ParkingLotsRepository.listParkingLots(parkingId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();
          if (snapshot.data == null) {
            return Container(child: const Text("Nenhuma vaga encontrada"));
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
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5)),
            child: ListTile(
              title: Text("Número da vaga: ${pl.number}"),
              subtitle: Text("Andar: ${pl.floor}"),
              trailing: buildTrailingButton(context, pl.id, pl.isAvailable),
            )));
  }

  Widget buildTrailingButton(
      BuildContext context, String parkingLotId, bool isAvailable) {
    var occupationStatus = ParkingLotsRepository.verifyOccupation(
        parkingLotId, parkingId, loggedUser!.uid);
    occupationStatus = isAvailable ? 0 : 1;
    switch (occupationStatus) {
      case 0:
        return ElevatedButton(
            onPressed: () => {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OccupyParkingLot()))
                      .then((person) {
                    setState(() {});
                  })
                },
            child: const Text("Ocupar"));
      case 1:
        return TextButton(
            onPressed: () => {setState(() => {})},
            child: const Text("Ocupada"));
      case 2:
        return OutlinedButton(
            onPressed: () => {setState(() => {})},
            child: const Text("Indisponível"));
    }

    return TextButton(onPressed: () => {}, child: const Text("Ocupar"));
  }

  Widget buildParkingLotButtons(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: OccupationsRepository.listOccupations(parkingId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();
          if (snapshot.data == null) {
            return Container(child: const Text("Nenhuma vaga encontrada"));
          } else {
            return buildListSeparated(context, snapshot.data!.docs);
          }
        });
  }
}
