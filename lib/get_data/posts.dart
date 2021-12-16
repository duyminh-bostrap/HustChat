import 'dart:convert';
import 'package:flutter/material.dart';
import '../network_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Posts {
  final String username;
  final String described;
  final String timeAgo;
  Posts({
    required this.username,
    required this.described,
    required this.timeAgo});
}
