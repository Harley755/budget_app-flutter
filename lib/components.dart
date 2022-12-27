import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OpenSans extends StatelessWidget {
  final text;
  final size;
  final color;
  final fontWeight;

  const OpenSans({
    super.key,
    @required this.text,
    @required this.size,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      style: GoogleFonts.openSans(
        fontSize: size,
        color: color == null ? Colors.black : color,
        fontWeight: fontWeight == null ? FontWeight.normal : fontWeight,
      ),
    );
  }
}

DialogueBox(BuildContext context, String title) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: EdgeInsets.all(32.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(width: 2.0, color: Colors.black),
      ),
      title: OpenSans(text: title, size: 20.0),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: Colors.black,
          child: OpenSans(
            text: "Okay",
            size: 20.0,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
