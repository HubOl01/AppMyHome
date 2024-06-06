import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/Styles/Colors.dart';

class CustomInput extends StatefulWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String label;
  final Widget icon;
  final bool isNumber;
  const CustomInput(
      {super.key,
      required this.controller,
      this.isPassword = false,
      this.isNumber = false,
      required this.label,
      required this.icon});

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        inputFormatters: widget.isNumber
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
        keyboardType: widget.isNumber ? TextInputType.number : null,
        controller: widget.controller,
        obscureText: widget.isPassword ? _isObscure : widget.isPassword,
        cursorColor: purpleColor,
        // style: TextStyle(color: purpleColor),
        decoration: InputDecoration(
          // filled: true,
          focusColor: purpleColor,
          // fillColor: purpleColor.withOpacity(.2),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintStyle: TextStyle(color: purpleColor),
          labelText: widget.label,
          suffixIcon: widget.isPassword
              ? IconButton(
                  splashColor: purpleColor.withOpacity(.1),
                  splashRadius: 15,
                  icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: purpleColor,
                      size: 20),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  })
              : null,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: purpleColor, width: 2),
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: purpleColor, width: 2),
            borderRadius: BorderRadius.circular(20.0),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: IconTheme(
              data: IconThemeData(color: purpleColor),
              child: widget.icon,
            ),
          ),
        ),
      ),
    );
  }
}
