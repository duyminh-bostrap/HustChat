import 'dart:convert';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import '../network_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

NetworkHandler networkHandler = NetworkHandler();
final storage = new FlutterSecureStorage();
getPostInfo() async {
  String? token = await storage.read(key: "token");
  if (token != null) {
    var response =
    await networkHandler.getWithAuth("/posts/list", token);
    Map output = json.decode(response.body);
    await storage.write(key: "described", value: output["data"]["described"]);
    // await storage.write(key: "postTimeAgo", value: output["data"]["described"]);
    var described = await storage.read(key: "described");
    if (described != null) {
      return described;
    }
    return "";


  }
}
class ShowPostInfo extends StatelessWidget {
  const ShowPostInfo({
  Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPostInfo(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //                       if (snapshot.connectionState == ConnectionState.waiting) {
          // return CircularProgressIndicator();
          // }
          if (snapshot.hasData) {
            return ExpandableText(
                snapshot.data,
                style: TextStyle(
                  fontSize: 15.0,
                ),
                expandText: 'Xem thêm',
                collapseText: 'Rút gọn',
                maxLines: 3,
                linkColor: Colors.black54,
              );
              // TextStyle(
              //     color: Colors.black87,
              //     fontSize: 20,
              //     fontWeight: FontWeight.w600),
              // );
          }
          return Container();
        });
  }
}
