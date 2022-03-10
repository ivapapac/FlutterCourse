import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'custom_alert_dialog.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, this.document}) : super(key: key);

  final QueryDocumentSnapshot? document;

  @override
  Widget build(BuildContext context) {
    var timestamp = (document?.data() as Map<String, dynamic>)['timestamp'];
    String? dateFormatted;

    if (timestamp != null) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
      dateFormatted = DateFormat('EEEE, MMM d, y').format(dateTime);
    }

    return Column(
      children: [
        Container(
          height: 200,
          child: Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(document?.get('title')),
                  subtitle: Text(document?.get('description')),
                  leading: CircleAvatar(
                    radius: 34,
                    child: Text(document?.get('title')[0]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("By: ${(document?.data() as Map<String, dynamic>)['name'] ?? "N/A"}"),
                      Text("Date: ${dateFormatted ?? "N/A"}"),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection("board")
                            .doc(document?.id)
                            .delete()
                            .then((value) {
                          _displaySnackBar(context: context);
                        }).catchError((error) {
                          _displaySnackBar(context: context, error: error);
                        });
                      },
                      icon: const Icon(
                        FontAwesomeIcons.trash,
                        size: 20,
                        color: Colors.redAccent,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _showDialog(context, document);
                      },
                      icon: const Icon(
                        FontAwesomeIcons.edit,
                        size: 20,
                        color: Colors.green,
                      ),
                    ),
                  ],
                )
              ],
            ),
            elevation: 9,
          ),
        ),
      ],
    );
  }

  void _displaySnackBar({required BuildContext context, dynamic error}) {
    String message;
    Color bgColor;

    if (error == null) {
      message = "Board post successfully removed!";
      bgColor = Colors.lightGreen;
    } else {
      message = "Error processing board post!";
      bgColor = Colors.redAccent;
    }

    SnackBar snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 2000),
      backgroundColor: bgColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showDialog(BuildContext context, QueryDocumentSnapshot? document) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(document: document);
        });
  }
}
