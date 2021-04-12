import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashier_app/pages/login_page/login_page.dart';
import 'package:cashier_app/pages/menu_page/menu_details.dart';
import 'package:cashier_app/services/dbService.dart';
import 'package:cashier_app/services/myCashier.dart';
import 'package:cashier_app/services/providers.dart';
import 'package:cashier_app/utils/constanst.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuDialog extends ModalRoute<void> {
  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String idu;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idu = preferences.getString("email");
    });
  }

  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.white.withOpacity(0.9);

  @override
  String get barrierLabel => "";

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    getPref();
    var myOrders = Provider.of<MenuProvider>(context);
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: Icon(Icons.close, color: Colors.black, size: 40),
                ),
              ),
            ),
//            Text("panjang" + myOrders.makanan.length.toString()),
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Nama Pemesan"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: myOrders.myBaskets.length,
                itemBuilder: (BuildContext context, int i) {
                  return InkWell(
                      onTap: () {
//                        myOrders.setActiveMenu(myOrders.myBaskets[i]);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => MenuDetails()));
                      },
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            width: 100,
                            height: 100,
                            imageUrl: Commons.baseURL +
                                "menu/" +
                                myOrders.myBaskets[i].im1.toString(),
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, d) => Icon(
                              Icons.error,
                              size: 50,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  myOrders.myBaskets[i].nma.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "Rp " +
                                            myOrders
                                                .getMyOrderPrice(
                                                    myOrders.myBaskets[i])
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.green.shade400,
                                        )),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          myOrders.myBaskets.contains(
                                                  myOrders.myBaskets[i])
                                              ? InkWell(
                                                  onTap: () {
                                                    myOrders.removeToMyOrder(
                                                        myOrders.myBaskets[i]);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            right: BorderSide(
                                                                width: 1))),
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                          myOrders.myBaskets.contains(
                                                  myOrders.myBaskets[i])
                                              ? Container(
                                                  alignment: Alignment.center,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1,
                                                  child: Text(
                                                      "${myOrders.myBaskets[i].qty}"))
                                              : SizedBox(),
                                          InkWell(
                                            onTap: () {
                                              myOrders.addToMyOrder(
                                                  myOrders.myBaskets[i]);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      left: BorderSide(
                                                          width: myOrders
                                                                  .myBaskets
                                                                  .contains(myOrders
                                                                      .myBaskets[i])
                                                              ? 0
                                                              : 1))),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                TextField(
                                  onChanged: (val) {
                                    myOrders.myBaskets[i].ket = val;
                                  },
                                  onSubmitted: (val) {
                                    myOrders.myBaskets[i].ket = val;
                                  },
                                  decoration:
                                      InputDecoration(hintText: "Catatan"),
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   color: Colors.grey,
                          //   width: MediaQuery.of(context).size.width * 0.18,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Icon(
                          //         Icons.remove,
                          //         color: Colors.red,
                          //       ),
                          //       Text(myOrders.myBaskets[i].qty.toString()),
                          //       Icon(
                          //         Icons.add,
                          //         color: Colors.blue,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ));
                },
              ),
            ),

            InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(width: 1, color: Colors.grey))),
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.shopping_basket_rounded,
                                      color: Colors.green,
                                      size: 30,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green),
                                      child: Text(
                                        myOrders.getMyOrdersQty().toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(right: 8),
                                child: Text(
                                  "Rp" +
                                      myOrders
                                          .getMyOrderTotalPrice()
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.green),
                                ))
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //                ('PSN20210921001', 'menu0', 0, 15000, 15000, 'pedas', '2021-03-02 17:00:00','meja03','0000-00-00 00:00:00')
                        final DateTime now = DateTime.now();
                        final DateFormat formatter =
                            DateFormat('yyyy-MM-dd H:m:s');
                        final String formatted = formatter.format(now);

                        //create trk_psn_hdr data
                        Map<String, dynamic> trk_psn_hdr = {
                          "jpp": "0000-00-00",
                          "jps": formatted,
                          "jpd": "0000-00-00",
                          "jpf": "0000-00-00",
                          "nma": nameController.text,
                          "mja": idu,
                          "ket": "catatan dari tamu",
                          "tot": myOrders.getMyOrderTotalPrice(),
                          "tdi": "0000-00-00",
                          "idu": idu,
                          "val": "0000-00-00",
                        };

                        //create trk_psn_dtl data
                        List<Map<String, dynamic>> trk_psn_dtl = [];
                        for (var i = 0; i < myOrders.myBaskets.length; i++) {
                          trk_psn_dtl.add({
                            "mnu": myOrders.myBaskets[i].acc.toString(),
                            "jml": myOrders.myBaskets[i].qty.toString(),
                            "hrg": myOrders.myBaskets[i].hrg.toString(),
                            "tot":
                                myOrders.getMyOrderPrice(myOrders.myBaskets[i]),
                            "ket": myOrders.myBaskets[i].ket.toString(),
                            "tdi": "0000-00-00 00:00:00",
                            "idu": idu,
                            "val": "0000-00-00 00:00:00",
                          });
                        }
                        if (nameController.text.isEmpty) {
                          print("isi nama");
                        } else {
                          DBService().postPesanan(trk_psn_hdr, trk_psn_dtl);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                          myOrders.clearMyBasket();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 48,
                        color: Colors.green,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          "Pesan",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
