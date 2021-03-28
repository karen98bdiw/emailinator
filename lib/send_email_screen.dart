import 'package:emailinator/email.dart';
import 'package:emailinator/enums.dart';
import 'package:emailinator/helpers.dart';
import 'package:emailinator/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart' as sender;

class SendEmailScreen extends StatefulWidget {
  @override
  _SendEmailScreenState createState() => _SendEmailScreenState();
}

class _SendEmailScreenState extends State<SendEmailScreen> {
  Email _email;
  String username;
  String password;
  String senderName;
  var _formState = GlobalKey<FormState>();
  var _isLoading = false;

  void done() {
    if (_formState.currentState.validate()) {
      _formState.currentState.save();
      sendEmail();
    } else {
      showError("Review form!");
    }
  }

  Future<dynamic> sendEmailWithDefaulMailer() async {
    setState(() {
      _isLoading = true;
    });

    var email = sender.Email(
      body: _email.content,
      isHTML: false,
      recipients: [_email.mainRecepient, ..._email.recepinets],
      subject: _email.title,
    );

    try {
      await sender.FlutterEmailSender.send(email);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("error:${e.toString()}");
    }

    print("username:$username");
  }

  Future<dynamic> sendEmail() async {}

  @override
  Widget build(BuildContext context) {
    _email = Provider.of<Email>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: sendEmailWithDefaulMailer,
        label: const Text('Send With Device Email Service'),
        tooltip: "Send E-Mail with EMailier from device",
        icon: const Icon(Icons.email),
        backgroundColor: Colors.pink,
      ),
      appBar: appBar(title: "Send E-Mail"),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formState,
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
                      input(
                        showHint: false,
                        title: "Your name",
                        validator: (v) => v.isEmpty ? "Write your name!" : null,
                        onSave: (newValue) => senderName = newValue,
                        inputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      input(
                          inputAction: TextInputAction.done,
                          inputType: TextInputType.emailAddress,
                          showHint: false,
                          title: "E-Mail Service Username",
                          validator: (v) {
                            if (isValidEmail(v)) {
                              return v.isEmpty
                                  ? "Can't do this without E-Mail"
                                  : null;
                            } else {
                              return "Looks like this is not E-Mail";
                            }
                          },
                          onSave: (v) {
                            username = v;
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      input(
                        inputAction: TextInputAction.done,
                        obscureText: true,
                        showHint: false,
                        title: "E-Mail Service Password",
                        validator: (value) => value.isEmpty
                            ? "Can't do this without password"
                            : null,
                        onSave: (v) => password = v,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      customButton(
                          title: "Done",
                          onPressed: done,
                          action: ButtonAction.Done),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
