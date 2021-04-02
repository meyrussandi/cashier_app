import 'dart:convert';

import 'package:cashier_app/services/pesanan.dart';
import 'package:http/http.dart' as http;

class DBService {
  String baseUrl = "192.168.18.44";
  Future loginKaryawan(String email, String katasandi) async {
    try {
      final response =
          await http.post("http://192.168.1.11/dbresto/login.php", headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      }, body: {
        'email': email,
        'katasandi': katasandi,
      });

      if (response.statusCode == 200) {
        print("data : " + response.body.toString());
        return "200";
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      print("Exception Login error $e");
      return e.toString();
    }
  }

  Future getPesanan() async {
    try {
      var map = Map<String, dynamic>();
      final response = await http.get("http://192.168.1.11/dbresto/test.php");
      if (response.statusCode == 200) {
        print("data : " + json.decode(response.body)["data"].toString());
        return json.decode(response.body)["data"];
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      print("Exception Login error $e");
      return e.toString();
    }
  }
}
