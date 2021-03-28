import 'package:emailinator/email.dart';
import 'package:emailinator/enums.dart';
import 'package:emailinator/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendEmailScreen extends StatefulWidget {
  @override
  _SendEmailScreenState createState() => _SendEmailScreenState();
}

class _SendEmailScreenState extends State<SendEmailScreen> {
  Email email;

  void done() {}

  @override
  Widget build(BuildContext context) {
    email = Provider.of<Email>(context);
    return Scaffold(
      appBar: appBar(title: "Send E-Mail"),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                pageActionText("Okay its time to send E-Mail"),
                SizedBox(
                  height: 20,
                ),
                pageActionText("Write your valid E-Mail credentials!"),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "it will permanently deleted",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                input(showHint: false, title: "E-Mail Service Username"),
                SizedBox(
                  height: 10,
                ),
                input(showHint: false, title: "E-Mail Service Password"),
                SizedBox(
                  height: 20,
                ),
                customButton(
                    title: "Done", onPressed: () {}, action: ButtonAction.Done),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
