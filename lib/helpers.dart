import 'package:emailinator/enums.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showRecepientError(RecepientErrorType errorType) {
  var errorText;
  switch (errorType) {
    case RecepientErrorType.EmptyRecepient:
      errorText = "How can i use empty recepient??";
      break;
    case RecepientErrorType.ExistRecepinet:
      errorText = "Hmm whats a point to add one participant two time?";
      break;
    case RecepientErrorType.NoRecepient:
      errorText = "What?To whom you think i will send E-Mail?Add Recepients";
      break;
    case RecepientErrorType.InValidRecepient:
      errorText = "Are you sure that this is email?I am not!";
      break;
    case RecepientErrorType.WrongMainRecepient:
      errorText = "Looks like your Main Recepient is InValid";
      break;
    case RecepientErrorType.ExistMainRecepient:
      errorText = "You have to write main Recepient";
      break;
    default:
      errorText = "Something is really wrong";
  }

  FlutterToast.showToast(
    msg: errorText,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

bool isValidEmail(String input) {
  final RegExp regex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return regex.hasMatch(input);
}

void showError(String text) {
  FlutterToast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
