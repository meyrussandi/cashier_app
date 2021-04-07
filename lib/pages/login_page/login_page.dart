import 'dart:convert';
import 'package:cashier_app/services/dbService.dart';
import 'package:cashier_app/utils/constanst.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../dashboard_page/dashboard_page.dart';

enum LoginStatus { notSignin, signIn }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtUsername = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  bool _hidePassword = true;
  LoginStatus _loginStatus = LoginStatus.notSignin;

  showPassword() {
    setState(() {
      print("hide passs " + _hidePassword.toString());
      _hidePassword = !_hidePassword;
    });
  }

  void showSnackBar(String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text("$title"),
      duration: Duration(seconds: 2),
    ));
  }

  void showErrorSnackBar(String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text("$title"),
      duration: Duration(seconds: 2),
    ));
  }

  loginKaryawan(String email, String katasandi) async {
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
      return jsonDecode(response.body);
    } catch (e) {
      return e.toString();
    }
  }

  LogOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      _loginStatus = LoginStatus.notSignin;
    });
  }

  savePref(int value, String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("email", email);
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int value = preferences.getInt("value");
    setState(() {
      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignin;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    double widthSreen = MediaQuery.of(context).size.width;
    double heightSreen = MediaQuery.of(context).size.height;
    double defaultMargin = widthSreen * 0.08;
    double getSmallDiameter(BuildContext context) =>
        MediaQuery.of(context).size.width * 5 / 9;
    double getBigDiameter(BuildContext context) =>
        MediaQuery.of(context).size.width * 3 / 7;

    switch (_loginStatus) {
      case LoginStatus.notSignin:
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
                                              prefixIcon:
                                                  Icon(Icons.perm_identity),
                                              hintText: "Email",
                                              hintStyle: TextStyle(
                                                  color: Colors.black),
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
                                              suffixIcon: Container(
                                                child: InkWell(
                                                  onTap: showPassword(),
                                                  child: Icon(
                                                      Icons.remove_red_eye,
                                                      color: _hidePassword
                                                          ? Colors.grey
                                                          : Colors.blue),
                                                ),
                                              ),
                                              hintText: "Password",
                                              hintStyle: TextStyle(
                                                  color: Colors.black),
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
                                        Commons().showLoaderDialog(context);
                                        loginKaryawan(txtUsername.text,
                                                txtPassword.text)
                                            .then((value) {
                                          if (value["success"] == 1) {
                                            Navigator.pop(context);
                                            showSnackBar(
                                                value["message"].toString());
                                            setState(() {
                                              _loginStatus = LoginStatus.signIn;
                                              savePref(1, txtUsername.text);
                                              print("session " +
                                                  _loginStatus.toString());
                                            });
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             DashboardPage(l)));
                                          } else {
                                            Navigator.pop(context);
                                            showErrorSnackBar(
                                                value["message"].toString());
                                          }
                                        });
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.greenAccent),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  side: BorderSide(
                                                      color: Colors.blue))),
                                          padding:
                                              MaterialStateProperty.all<EdgeInsets>(
                                                  EdgeInsets.symmetric(
                                                      horizontal:
                                                          widthSreen * 0.2,
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
        break;
      case LoginStatus.signIn:
        return DashboardPage(LogOut);
        break;
    }
  }
}
