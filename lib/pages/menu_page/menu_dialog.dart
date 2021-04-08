import 'package:cashier_app/pages/menu_page/menu_details.dart';
import 'package:cashier_app/services/myCashier.dart';
import 'package:cashier_app/services/providers.dart';
import 'package:cashier_app/utils/constanst.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuDialog extends ModalRoute<void> {
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
                          Image.network(
                            Commons.baseURL +
                                "menu/" +
                                myOrders.myBaskets[i].im1.toString(),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
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
