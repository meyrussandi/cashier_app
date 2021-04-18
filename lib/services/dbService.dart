import 'dart:convert';
import 'dart:io';

import 'package:cashier_app/models/menu_model.dart';
import 'package:cashier_app/models/pesanan_model.dart';
import 'package:cashier_app/utils/constanst.dart';
import 'package:http/http.dart' as http;

class DBService {
  Future loginKaryawan(String email, String katasandi) async {
    try {
      final response = await http.post(Commons.baseURL + "login.php", headers: {
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

  Future postPesanan(Map<String, dynamic> trkPsnHdr,
      List<Map<String, dynamic>> trkPsnDtl) async {
    try {
      final response =
          await http.post(Commons.baseURL + "createpesanan.php", headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      }, body: <String, dynamic>{
        "trk_psn_hdr": json.encode(trkPsnHdr),
        "trk_psn_dtl": json.encode(trkPsnDtl)
      });

      if (response.statusCode == 200) {
        print("data : " + response.body.toString());
        return "200";
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      print("Post pesanan error : $e");
      return e.toString();
    }
  }

  Future getPesanan(String meja) async {
    try {
      final response =
          await http.get(Commons.baseURL + "getpesanan.php?mja=$meja");
      if (response.statusCode == 200) {
        var responseJson = Commons.returnResponse(response);
//        menu = Menu.fromJson(responseJson);
        print("data menu" + responseJson["data"].toString());
        return responseJson;
        //return menu;
      } else {
        return null;
      }
    } on SocketDirection {
      return null;
    }
    //   if (response.statusCode == 200) {
    //     print("data : " + json.decode(response.body)["data"].toString());
    //     return json.decode(response.body)["data"];
    //   } else {
    //     return response.statusCode.toString();
    //   }
    // } catch (e) {
    //   print("Exception Login error $e");
    //   return e.toString();
    // }
  }

  Future getPesananDetails(String idt) async {
    try {
      final response = await http.post(
          Commons.baseURL + "getpesanandetails.php",
          body: <String, dynamic>{
            "idt": idt,
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } on SocketDirection {
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future addjmlpesanandetails(String idt, String mnu) async {
    try {
      final response = await http.post(
          Commons.baseURL + "addjmlpesanandetails.php",
          body: <String, dynamic>{"idt": idt, "mnu": mnu});
      if (response.statusCode == 200) {
        print("" + jsonDecode(response.body).toString());
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } on SocketDirection {
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future minjmlpesanandetails(String idt, String mnu) async {
    try {
      final response = await http.post(
          Commons.baseURL + "minjmlpesanandetails.php",
          body: <String, dynamic>{"idt": idt, "mnu": mnu});
      if (response.statusCode == 200) {
        print("" + jsonDecode(response.body).toString());
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } on SocketDirection {
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future deletepesanandetails(String idt, String mnu) async {
    try {
      final response = await http.post(
          Commons.baseURL + "deletepesanandetails.php",
          body: <String, dynamic>{"idt": idt, "mnu": mnu});
      if (response.statusCode == 200) {
        print("" + jsonDecode(response.body).toString());
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } on SocketDirection {
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future getMenuByAcc(String acc) async {
    try {
      final response = await http
          .post(Commons.baseURL + "getmenubyacc.php", body: <String, dynamic>{
        "acc": acc,
      });
      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } on SocketDirection {
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<Menu> fetchMenu() async {
    try {
      final response = await http.get(Commons.baseURL + "menu.php", headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      });
      if (response.statusCode == 200) {
        var responseJson = Commons.returnResponse(response);
//        menu = Menu.fromJson(responseJson);
        // print("data menu" + responseJson.toString());
        return Menu.fromJson(responseJson);
        //return menu;
      } else {
        return Menu();
      }
    } on SocketDirection {
      return null;
    }
  }
}
