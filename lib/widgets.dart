import 'package:emailinator/constats.dart';
import 'package:emailinator/email.dart';
import 'package:emailinator/enums.dart';
import 'package:flutter/material.dart';

AppBar appBar({String title}) {
  return AppBar(
    title: Text(
      title ?? "",
      style: TextStyle(color: titleColor),
    ),
    centerTitle: true,
    elevation: 0,
    shadowColor: Colors.transparent,
  );
}

Column input({
  String title,
  @required bool showHint,
  FormFieldSetter<String> onSave,
  FormFieldValidator<String> validator,
  TextInputType inputType,
  int maxLines,
  TextInputAction inputAction,
  TextEditingController controller,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      !showHint
          ? Text(
              title ?? "",
              style: TextStyle(color: inputTitleColor, fontSize: 17),
            )
          : Container(),
      !showHint
          ? SizedBox(
              height: 10,
            )
          : Container(),
      TextFormField(
        controller: controller,
        onSaved: onSave,
        validator: validator,
        keyboardType: inputType,
        maxLines: maxLines ?? 1,
        textInputAction: inputAction,
        decoration: InputDecoration(
          hintText: showHint ? title : null,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2),
          ),
        ),
      ),
    ],
  );
}

Text pageActionText(String text) {
  return Text(
    text ?? "",
    style: TextStyle(
      color: Color.fromRGBO(117, 125, 59, 1),
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    textAlign: TextAlign.center,
  );
}

RaisedButton customButton(
    {Function onPressed, title, BuildContext context, ButtonAction action}) {
  return RaisedButton(
    elevation: 0,
    color: buttonBackgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(
        width: 1,
        style: BorderStyle.solid,
      ),
    ),
    onPressed: onPressed,
    padding: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 15,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title ?? "",
          style: TextStyle(
            color: buttonTextColor,
            fontSize: 20,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        if (action == null || action == ButtonAction.Next)
          Icon(
            Icons.keyboard_arrow_right,
            color: buttonTextColor,
          )
      ],
    ),
  );
}

Widget participantItem({String title, Function onDelete}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Container(
      color: Color.fromRGBO(245, 245, 208, 1),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        dense: true,
        title: Text(
          title,
          style: TextStyle(
            color: boldTextColor,
            fontSize: 20,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: onDelete,
        ),
      ),
    ),
  );
}
