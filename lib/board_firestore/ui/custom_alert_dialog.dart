import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatefulWidget {
  final QueryDocumentSnapshot? document;

  const CustomAlertDialog({Key? key, this.document}) : super(key: key);

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  var firestore = FirebaseFirestore.instance.collection("board").snapshots();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameInputController;
  late TextEditingController titleInputController;
  late TextEditingController descriptionInputController;

  @override
  void initState() {
    super.initState();
    nameInputController = TextEditingController();
    titleInputController = TextEditingController();
    descriptionInputController = TextEditingController();

    if (widget.document != null) {
      nameInputController.text = widget.document!.get('name').toString();
      titleInputController.text = widget.document!.get('title').toString();
      descriptionInputController.text = widget.document!.get('description').toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text("Please fill out the form!"),
            Expanded(
              child: TextFormField(
                autofocus: true,
                autocorrect: true,
                decoration: const InputDecoration(
                  labelText: "Your Name",
                ),
                controller: nameInputController,
                validator: (value) {
                  return _validateInput(value, 'Name');
                },
              ),
            ),
            Expanded(
              child: TextFormField(
                autocorrect: true,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                controller: titleInputController,
                validator: (value) {
                  return _validateInput(value, 'Title');
                },
              ),
            ),
            Expanded(
              child: TextFormField(
                autocorrect: true,
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
                controller: descriptionInputController,
                validator: (value) {
                  return _validateInput(value, 'Description');
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _clearDialog(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (widget.document == null) {
                await FirebaseFirestore.instance.collection("board").add({
                  "name": nameInputController.text,
                  "title": titleInputController.text,
                  "description": descriptionInputController.text,
                  "timestamp": DateTime.now()
                }).then((response) {
                  _clearDialog(context);
                  _displaySnackBar(context: context);
                }).catchError((error) => _displaySnackBar(context: context, error: error));
              } else {
                await FirebaseFirestore.instance
                    .collection("board")
                    .doc(widget.document!.id)
                    .update({
                  "name": nameInputController.text,
                  "title": titleInputController.text,
                  "description": descriptionInputController.text,
                  "timestamp": DateTime.now()
                }).then((response) {
                  _clearDialog(context);
                  _displaySnackBar(context: context);
                }).catchError((error) => _displaySnackBar(context: context, error: error));
              }
            }
          },
          child: Text(widget.document == null ? 'Save' : 'Update'),
        ),
      ],
    );
  }

  void _clearDialog(BuildContext context) {
    nameInputController.clear();
    titleInputController.clear();
    descriptionInputController.clear();

    Navigator.pop(context);
  }

  String? _validateInput(String? value, String label) {
    if (value == null || value.isEmpty) return '$label is required';
    return null;
  }

  void _displaySnackBar({required BuildContext context, dynamic error}) {
    String message;
    Color bgColor;

    if (error == null) {
      message = "Board post successfully saved!";
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
}
