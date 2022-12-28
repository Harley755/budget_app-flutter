import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/svg.dart';

// OPENSANS
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

class Poppins extends StatelessWidget {
  final text;
  final size;
  final color;
  final fontWeight;

  const Poppins({
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
      style: GoogleFonts.poppins(
        fontSize: size,
        color: color == null ? Colors.black : color,
        fontWeight: fontWeight == null ? FontWeight.normal : fontWeight,
      ),
    );
  }
}

// DIALOGUE BOX
DialogBox(BuildContext context, String title) {
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

class UrlLaunch extends StatelessWidget {
  final String url;
  final String iconSvg;
  final colorSvg;
  const UrlLaunch({
    super.key,
    required this.url,
    required this.iconSvg,
    this.colorSvg,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async => await launchUrl(Uri.parse(url)),
      icon: SvgPicture.asset(
        iconSvg,
        color: colorSvg == null ? Colors.black : colorSvg,
        width: 35.0,
      ),
    );
  }
}

class TextForm extends StatelessWidget {
  final text;
  final containerWidth;
  final hintText;
  final controller;
  final digitsOnly;
  final validator;
  const TextForm({
    super.key,
    this.text,
    this.containerWidth,
    this.hintText,
    this.controller,
    this.digitsOnly,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OpenSans(text: text, size: 14.0),
        SizedBox(height: 5.0),
        SizedBox(
          width: containerWidth,
          child: TextFormField(
            validator: validator,
            inputFormatters: digitsOnly != null
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
            controller: controller,
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.tealAccent, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              hintStyle: GoogleFonts.poppins(fontSize: 13.0),
              hintText: hintText,
            ),
          ),
        )
      ],
    );
  }
}
