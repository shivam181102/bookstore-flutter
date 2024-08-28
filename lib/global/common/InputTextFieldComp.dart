import 'package:flutter/material.dart';

class Inputtextfieldcomp extends StatefulWidget {
  TextEditingController controller;
  bool password, showshadow;
  String hintText;
   Inputtextfieldcomp({super.key, required this.controller, this.password = false , required this.hintText, this.showshadow = false});

  @override
  State<Inputtextfieldcomp> createState() => _InputtextfieldcompState();
}

class _InputtextfieldcompState extends State<Inputtextfieldcomp> {
  bool passwordview = false;
  @override
  void initState(){
    passwordview = widget.password;
    super.initState();
  }
  OutlineInputBorder borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.grey, width: 1));
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration( boxShadow: [
          widget.showshadow?
                      BoxShadow(
                        color: const Color.fromARGB(255, 0, 0, 0)
                            .withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 0), // changes position of shadow
                      ):BoxShadow(color: Colors.white),
                    ]),
        child: TextField(
          controller: widget.controller,
          cursorColor: Colors.grey,
          
          obscureText: passwordview,
          decoration: InputDecoration(
           labelStyle: TextStyle(color: Colors.grey),
            labelText: widget.hintText,
            fillColor: Colors.white,
            filled: true,
              
              enabledBorder: borderStyle,
              focusedBorder: borderStyle,
              suffixIcon:widget.password?passwordview?IconButton(icon: const Icon(Icons.visibility), onPressed: () {
                setState(() {
                  passwordview = !passwordview;
                });
              },):IconButton(icon: const Icon(Icons.visibility_off), onPressed: () {
                setState(() {
                  passwordview = !passwordview;
                });
              },) :null),
        ),
      ),
    );
  }
}
