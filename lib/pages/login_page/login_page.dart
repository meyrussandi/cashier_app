import 'package:flutter/material.dart';

import '../dashboard_page/dashboard_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController txtUsername = new TextEditingController();
    TextEditingController txtPassword = new TextEditingController();
    double widthSreen = MediaQuery.of(context).size.width;
    double heightSreen = MediaQuery.of(context).size.height;
    double defaultMargin = widthSreen * 0.1;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1,0.7],
          colors: [
            Colors.grey[350],
            Colors.grey[200],
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
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
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: txtUsername,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.perm_identity),
                                hintText: "Username",
                                hintStyle: TextStyle(color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.blue, width: 2)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.blue, width: 2))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: txtPassword,
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.vpn_key_outlined, color: Colors.grey,),
                                suffixIcon: Icon(Icons.remove_red_eye, color: Colors.grey,),
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.blue, width: 2)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.blue, width: 2))),
                          ),
                        ],
                      ),
                    ),SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> DashboardPage()), (route) => false);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.greenAccent),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: Colors.blue))),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    horizontal: widthSreen * 0.2, vertical: 10))),
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
    );
  }
}
