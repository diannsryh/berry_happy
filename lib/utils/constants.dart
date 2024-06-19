import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constants {
  static const Color primaryColor = Color.fromARGB(255, 255, 65, 158);
  static const Color scaffoldBackgroundColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color activeMenu = Color.fromARGB(255, 167, 167, 167);
}

const secondaryColor = Color(0xFF5593f8);
const primaryColor = Color(0xFF48c9e2);

final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
final DateFormat formatDate = DateFormat('yyyy-MM-dd H:mm');
const tokenStoreName = "access_token";
