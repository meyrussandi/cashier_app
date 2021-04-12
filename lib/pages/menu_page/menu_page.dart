import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashier_app/models/makanan.dart';
import 'package:cashier_app/models/menu_model.dart';
import 'package:cashier_app/models/pesanan_model.dart';
import 'package:cashier_app/pages/dashboard_page/dashboard_page.dart';
import 'package:cashier_app/pages/login_page/login_page.dart';
import 'package:cashier_app/pages/menu_page/menu_details.dart';
import 'package:cashier_app/pages/menu_page/menu_dialog.dart';
import 'package:cashier_app/services/dbService.dart';
import 'package:cashier_app/services/myCashier.dart';
import 'package:cashier_app/services/providers.dart';
import 'package:cashier_app/utils/constanst.dart';
import 'package:cashier_app/utils/error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin {
  TabController _tabController;
  MenuProvider myCashier;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    myCashier = Provider.of<MenuProvider>(context, listen: false);
    myCashier.loadMenu();
    super.initState();
  }

  Future getMenu() async {
    final response = await http.get(Commons.baseURL + "menu.php");
    print("data " + json.decode(response.body).length.toString());
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    var makanan = context.watch<MenuProvider>();
    double widthSreen = MediaQuery.of(context).size.width;
    double heightSreen = MediaQuery.of(context).size.height;
    double defaultMargin = widthSreen * 0.1;
    // Menu menu;
    //print("menu : " + menu.toString());
    return Scaffold(
      bottomNavigationBar: myCashier.myBaskets.length == 0
          ? SizedBox()
          : Container(
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(width: 1, color: Colors.grey))),
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MenuDialog());
                          },
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
                                          myCashier.getMyOrdersQty().toString(),
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
                                        myCashier
                                            .getMyOrderTotalPrice()
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.green),
                                  ))
                            ],
                          )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MenuDialog());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 48,
                      color: Colors.green,
                      width: widthSreen * 0.3,
                      child: Text(
                        "Checkout",
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
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              backgroundColor: Colors.green.shade900,
              title: Text("MENU"),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            SliverFillRemaining(
              child: myCashier.menu == null
                  ? FutureBuilder(
                      future: DBService().fetchMenu(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text(
                              'Fetch data.',
                              textAlign: TextAlign.center,
                            );
                          case ConnectionState.active:
                            return Text('');
                          case ConnectionState.waiting:
                            return Commons.sampleLoading("Getting Data...");
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Error(
                                errorMessage: "Error load menu",
                              );
                            } else {
                              return buildListViewMenu(widthSreen);
                            }
                        }

                        return Commons.sampleLoading("load data ... ");
                      })
                  : myCashier.menu == null
                      ? Commons.sampleLoading("load data ... ")
                      : buildListViewMenu(widthSreen),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView buildListViewMenu(double widthSreen) {
    return ListView.builder(
      itemCount: myCashier.menu.items.length,
      itemBuilder: (context, index) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.15,
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(bottom: 16, left: 8, right: 8),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3))
          ]),
          child: InkWell(
            onTap: () {
              myCashier.setActiveMenu(myCashier.menu.items[index]);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MenuDetails()));
            },
            child: Row(
              children: [
                CachedNetworkImage(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.15,
                  imageUrl: Commons.baseURL +
                      "menu/" +
                      myCashier.menu.items[index].im1,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, d) => Icon(
                    Icons.error,
                    size: 50,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        myCashier.menu.items[index].nma.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "Rp " +
                                  myCashier.menu.items[index].hrg.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green.shade400,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          myCashier.myBaskets
                                  .contains(myCashier.menu.items[index])
                              ? InkWell(
                                  onTap: () {
                                    myCashier.removeToMyOrder(
                                        myCashier.menu.items[index]);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(width: 1))),
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          myCashier.myBaskets
                                  .contains(myCashier.menu.items[index])
                              ? Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  child: Text(
                                      "${myCashier.menu.items[index].qty}"))
                              : SizedBox(),
                          InkWell(
                            onTap: () {
                              myCashier
                                  .addToMyOrder(myCashier.menu.items[index]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          width: myCashier.myBaskets.contains(
                                                  myCashier.menu.items[index])
                                              ? 1
                                              : 0))),
                              child: Icon(
                                Icons.add,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
        // ListTile(
        //   onTap: () {
        //     myCashier.setActiveMenu(myCashier.menu.items[index]);
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => MenuDetails()));
        //   },
        //   minVerticalPadding: 20,
        //   leading: Image.network(
        //     Commons.baseURL + "menu/" + myCashier.menu.items[index].im1,
        //     width: 100,
        //     height: 100,
        //     fit: BoxFit.cover,
        //   ),
        //   title: Text(
        //     "nama : " + myCashier.menu.items[index].nma.toString(),
        //   ),
        //   // Text("nama : " +
        //   // myCashier.makanan[i].name.toString(),)
        //   trailing: Container(
        //     width: widthSreen * 0.18,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Icon(
        //           Icons.remove,
        //           color: Colors.red,
        //         ),
        //         Text("${myCashier.menu.items[index].qty}"),
        //         Icon(
        //           Icons.add,
        //           color: Colors.blue,
        //         ),
        //       ],
        //     ),
        //   ),
        // );
      },
    );
  }
}
