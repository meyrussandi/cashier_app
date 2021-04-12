import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashier_app/pages/menu_page/menu_dialog.dart';
import 'package:cashier_app/services/myCashier.dart';
import 'package:cashier_app/services/providers.dart';
import 'package:cashier_app/utils/constanst.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var myMenu = Provider.of<MenuProvider>(context);
    print("menu details : " + myMenu.activeMakanan.im1.toString());
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              imageUrl: Commons.baseURL +
                  "menu/" +
                  myMenu.activeMakanan.im1.toString(),
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, d) => Icon(
                Icons.error,
                size: 50,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      end: Alignment.topRight)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    leading: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, color: Colors.white)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            myMenu.activeMakanan.nma.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "Rp. " + myMenu.activeMakanan.hrg.toString(),
                          style: TextStyle(
                              color: Colors.greenAccent.shade700,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.31,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: [
                  Text(
                    myMenu.activeMakanan.ket.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      myMenu.addToMyOrder(myMenu.activeMakanan);
                      Navigator.pop(context);
                      Navigator.of(context).push(MenuDialog());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.greenAccent.shade700,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "Tambah ke Pesanan",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {
                  //         myMenu.removeToMyOrder(myMenu.activeMakanan);
                  //       },
                  //       icon: Icon(
                  //         Icons.remove,
                  //         color: Colors.red,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 20,
                  //     ),
                  //     Text(myMenu.activeMakanan.qty.toString()),
                  //     SizedBox(
                  //       width: 20,
                  //     ),
                  //     IconButton(
                  //       onPressed: () {
                  //         myMenu.addToMyOrder(myMenu.activeMakanan);
                  //       },
                  //       icon: Icon(Icons.add, color: Colors.blue),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
