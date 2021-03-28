import 'package:emailinator/email.dart';
import 'package:emailinator/add_recepients_screen.dart';
import 'package:emailinator/widgets.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static final routeName = "Home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _formSate = GlobalKey<FormState>();

  Email email;

  void next() {
    if (_formSate.currentState.validate()) {
      _formSate.currentState.save();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (c) => AddRecepientsScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    email = Provider.of<Email>(context);
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar: appBar(title: "E-Mailinator"),
        body: LayoutBuilder(
          builder: (ctx, cnst) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: cnst.maxWidth,
                minHeight: cnst.maxHeight,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom > 0
                      ? MediaQuery.of(context).viewInsets.bottom
                      : 15,
                ),
                child: Form(
                  key: _formSate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      pageActionText("Okay first lets describe our e-mail"),
                      SizedBox(
                        height: 20,
                      ),
                      input(
                        onSave: (v) {
                          email.title = v;
                        },
                        validator: (v) => v.isEmpty
                            ? "Empty title???Hmm its not good!"
                            : null,
                        showHint: false,
                        title: "E-Mail Title",
                        inputAction: TextInputAction.done,
                        maxLines: 1,
                        inputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      input(
                          onSave: (v) {
                            email.content = v;
                          },
                          validator: (v) => v.isEmpty
                              ? "Hey you are not going to send empty email!!!"
                              : null,
                          showHint: false,
                          title: "E-Mail Content",
                          maxLines: 8),
                      SizedBox(
                        height: 25,
                      ),
                      customButton(
                          onPressed: () {
                            next();
                          },
                          title: "Next"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
