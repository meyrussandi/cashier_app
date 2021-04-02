import 'dart:convert';
import 'package:cashier_app/services/dbService.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../dashboard_page/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtUsername = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  bool _hidePassword = true;
  @override
  Widget build(BuildContext context) {
    double widthSreen = MediaQuery.of(context).size.width;
    double heightSreen = MediaQuery.of(context).size.height;
    double defaultMargin = widthSreen * 0.08;
    double getSmallDiameter(BuildContext context) =>
        MediaQuery.of(context).size.width * 5 / 9;
    double getBigDiameter(BuildContext context) =>
        MediaQuery.of(context).size.width * 3 / 7;

    showPassword() {
      setState(() {
        _hidePassword = !_hidePassword;
      });
    }

    loginKaryawan(String email, String katasandi) async {
      try {
        final response =
            await http.post("http://192.168.1.11/dbresto/login.php", headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        }, body: {
          'email': email,
          'katasandi': katasandi,
        });
        print("data : " + response.body.toString());

        return jsonDecode(response.body);
      } catch (e) {
        return e.toString();
      }
    }

    return Scaffold(
      backgroundColor: Colors.green.shade50,
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: [
          Container(
            width: widthSreen,
            height: heightSreen,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      width: getSmallDiameter(context),
                      height: getSmallDiameter(context),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [
                                Colors.green.shade200,
                                Colors.green.shade100
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter))),
                ),
                Positioned(
                  right: -getSmallDiameter(context) / 4,
                  top: -getSmallDiameter(context) / 3,
                  child: Container(
                      width: getSmallDiameter(context),
                      height: getSmallDiameter(context),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [
                                Colors.green.shade200,
                                Colors.green.shade100
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter))),
                ),
                Positioned(
                  left: -getBigDiameter(context) / 5,
                  top: -getBigDiameter(context) / 5,
                  child: Container(
                      width: getBigDiameter(context),
                      height: getBigDiameter(context),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [
                                Colors.green.shade200,
                                Colors.green.shade100
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter))),
                ),
                Positioned(
                  right: -getSmallDiameter(context) / 3,
                  bottom: -getSmallDiameter(context) / 3,
                  child: Container(
                      width: getSmallDiameter(context),
                      height: getSmallDiameter(context),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [
                                Colors.green.shade200,
                                Colors.green.shade100
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter))),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Text(
                                "Selamat Datang",
                                style: TextStyle(fontSize: 24),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Image.asset(
                                "assets/images/logo2.jpg",
                                width: widthSreen * 0.7,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(defaultMargin),
                          padding: EdgeInsets.all(defaultMargin),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      validator: (e) {
                                        if (e.isEmpty) {
                                          return "Masukan email";
                                        }
                                      },
                                      controller: txtUsername,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.perm_identity),
                                          hintText: "Email",
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2))),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      validator: (e) {
                                        if (e.isEmpty) {
                                          return "Masukan Password";
                                        }
                                      },
                                      controller: txtPassword,
                                      obscureText: _hidePassword,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.vpn_key_outlined,
                                            color: Colors.grey,
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: showPassword(),
                                            icon: Icon(
                                              Icons.remove_red_eye,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          hintText: "Password",
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2))),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    loginKaryawan(
                                            txtUsername.text, txtPassword.text)
                                        .then((value) {
                                      print("hasil " +
                                          value["success"].toString());
                                      if (value["success"] == 1) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DashboardPage()));
                                      } else {
                                        Flushbar(
                                          message: value["message"],
                                          backgroundColor: Colors.red,
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                          duration: Duration(seconds: 2),
                                        )..show(context);
                                      }

                                    });

                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .all<Color>(Colors.greenAccent),
                                      shape:
                                          MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  side: BorderSide(
                                                      color: Colors.blue))),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.symmetric(
                                                  horizontal: widthSreen * 0.2,
                                                  vertical: 10))),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
