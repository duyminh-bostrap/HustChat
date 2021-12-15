import 'package:flutter/material.dart';

class rounded_password_field extends StatefulWidget {
  rounded_password_field({
    Key? key,
    required this.size,
    required this.text,
    required this.passwordController,
  }) : super(key: key);

  final Size size;
  final String text;
  TextEditingController passwordController = TextEditingController();

  @override
  State<rounded_password_field> createState() => _rounded_password_fieldState();
}

class _rounded_password_fieldState extends State<rounded_password_field> {
  // TextEditingController passwordController = TextEditingController();
  bool checkPass = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      height: widget.size.height * 0.095,
      width: widget.size.width * 0.8,
      child: TextFormField(
        controller: widget.passwordController,
        // validator: (value) {
        //   if (value.isEmpty) return "Password cannot be empty";
        //   if (value.length <= 8) return "Password length must have >=8";
        //   return null;
        // },
        obscureText: checkPass,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(checkPass ? Icons.visibility_off : Icons.visibility),
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
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: widget.text,
            fillColor: Colors.white70),
      ),
    );
  }
}
