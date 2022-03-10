import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_flutter_app/board_firestore/ui/custom_alert_dialog.dart';
import 'package:first_flutter_app/board_firestore/ui/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoardApp extends StatefulWidget {
  const BoardApp({Key? key}) : super(key: key);

  @override
  State<BoardApp> createState() => _BoardAppState();
}

class _BoardAppState extends State<BoardApp> {
  var firestore = FirebaseFirestore.instance.collection("board").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Community Board"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        child: const Icon(FontAwesomeIcons.pen),
      ),
      body: StreamBuilder(
          stream: firestore,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                return CustomCard(document: snapshot.data?.docs[index]);
              },
            );
          }),
    );
  }

  void _showDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CustomAlertDialog();
        });
  }
}
