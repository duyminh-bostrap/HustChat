import 'package:flutter/material.dart';

class rounded_password_field extends StatefulWidget {
  final Size size;
  final String text;
  TextEditingController passwordController = TextEditingController();
  String errorText = '';
  String? Function(String?) validator;

  rounded_password_field({
    Key? key,
    required this.size,
    required this.text,
    required this.passwordController,
    required this.validator,
  }) : super(key: key);


  @override
  State<rounded_password_field> createState()
  => _rounded_password_fieldState(size: size, text: text, passwordController: passwordController, errorText: errorText);
}

class _rounded_password_fieldState extends State<rounded_password_field> {
  // TextEditingController passwordController = TextEditingController();
  bool checkPass = true;
  _rounded_password_fieldState({
    Key? key,
    required this.size,
    required this.text,
    required this.passwordController,
    required this.errorText,
  });

  final Size size;
  final String text;
  TextEditingController passwordController = TextEditingController();
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      height: widget.size.height * 0.095,
      width: widget.size.width * 0.8,
      child: TextFormField(
        controller: widget.passwordController,
        validator: widget.validator,
        // validator(value) {
        //   if (value!.isEmpty) return "Password cannot be empty";
        //   if (value.length <= 8) {
        //     return "Password length must have >=8";
        //   }
        //   return null;
        // },
        obscureText: checkPass,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(checkPass ? Icons.visibility_off : Icons.visibility, color: Colors.black,),
              onPressed: () {
                setState(() {
                  checkPass = !checkPass;
                });
              },
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                color: Color(0xffaedd94),
                style: BorderStyle.solid,
                width: 4)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black,)),
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red,)),

            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: widget.text,
            fillColor: Colors.white70),
      ),
    );
  }
}
