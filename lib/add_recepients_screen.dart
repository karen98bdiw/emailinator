import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:emailinator/constats.dart';
import 'package:emailinator/email.dart';
import 'package:emailinator/enums.dart';
import 'package:emailinator/helpers.dart';
import 'package:emailinator/send_email_screen.dart';
import 'package:emailinator/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';

class AddRecepientsScreen extends StatefulWidget {
  @override
  _AddRecepientsScreen createState() => _AddRecepientsScreen();
}

class _AddRecepientsScreen extends State<AddRecepientsScreen> {
  Email email;
  final recepinetCont = TextEditingController();
  final mainRecepientCont = TextEditingController();
  final scrollController = ScrollController();

  @override
  void dispose() {
    recepinetCont.dispose();
    mainRecepientCont.dispose();
    super.dispose();
  }

  void next() {
    if (mainRecepientCont.text.isNotEmpty) {
      if (isValidEmail(mainRecepientCont.text)) {
        email.mainRecepient = mainRecepientCont.text;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (c) => SendEmailScreen()));
      } else {
        showRecepientError(RecepientErrorType.WrongMainRecepient);
      }
    } else {
      showRecepientError(RecepientErrorType.ExistMainRecepient);
    }
  }

  void addRecepient() {
    if (recepinetCont.text.isNotEmpty) {
      if (email.recepinets.contains(recepinetCont.text)) {
        showRecepientError(RecepientErrorType.ExistRecepinet);
      } else if (!isValidEmail(recepinetCont.text)) {
        showRecepientError(RecepientErrorType.InValidRecepient);
      } else {
        email.addRecepient(recepinetCont.text);
        scrollController.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
        recepinetCont.clear();
      }
    } else {
      showRecepientError(RecepientErrorType.EmptyRecepient);
    }
  }

  Future<File> uploadFile() async {
    File res = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ["txt"],
    );

    if (res != null) {
      res
          .openRead()
          .map(utf8.decode)
          .transform(LineSplitter())
          .forEach((element) {
        if (isValidEmail(element)) {
          if (!email.recepinets.contains(element)) {
            email.addRecepient(element);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    email = Provider.of<Email>(context);
    return KeyboardDismisser(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: uploadFile,
          label: const Text('Upload Recepients'),
          tooltip: "List of Recepients from text file",
          icon: const Icon(Icons.file_upload),
          backgroundColor: Colors.pink,
        ),
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar: appBar(title: "Add Participants"),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    pageActionText("Lets add recepients"),
                    SizedBox(
                      height: 20,
                    ),
                    input(
                        showHint: true,
                        title: "Main Recepient",
                        controller: mainRecepientCont),
                    SizedBox(
                      height: 20,
                    ),
                    recepinentsList(),
                    Row(
                      children: [
                        Expanded(
                          child: input(
                              inputAction: TextInputAction.done,
                              controller: recepinetCont,
                              showHint: true,
                              title: "Recepient E-Mail"),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        addRecepientButton(),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    customButton(
                      title: "Next",
                      onPressed: () {
                        next();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget recepinentsList() {
    return Container(
      padding: email.recepinets.length > 0 ? EdgeInsets.all(10) : null,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.4,
      ),
      child: ListView.separated(
        controller: scrollController,
        reverse: true,
        separatorBuilder: (c, i) => Divider(),
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          return participantItem(
              title: email.recepinets[index],
              onDelete: () {
                email.deleteRecepien(email.recepinets[index]);
              });
        },
        itemCount: email.recepinets.length,
      ),
    );
  }

  Widget addRecepientButton() {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          14,
        ),
        side: BorderSide(color: buttonTextColor),
      ),
      onPressed: () {
        addRecepient();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "ADD",
            style: TextStyle(
              color: buttonTextColor,
              fontSize: 20,
            ),
            textAlign: TextAlign.end,
          ),
          SizedBox(
            width: 4,
          ),
          Icon(
            Icons.add,
            color: buttonTextColor,
          )
        ],
      ),
    );
  }
}
