import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashier_app/models/menu_model.dart';
import 'package:cashier_app/models/pesanan_model.dart';
import 'package:cashier_app/pages/menu_page/menu_page.dart';
import 'package:cashier_app/services/dbService.dart';
import 'package:cashier_app/services/providers.dart';
import 'package:cashier_app/utils/constanst.dart';
import 'package:cashier_app/utils/error.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  final VoidCallback logOut;

  const DashboardPage(this.logOut);
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String nama;
  logOut() {
    setState(() {
      widget.logOut();
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nama = preferences.getString("email");
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
    double defaultMargin = widthSreen * 0.05;
    PesananProvider pp = Provider.of<PesananProvider>(context, listen: false);
    pp.loadPesanan();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.7],
          colors: [
            Colors.grey.shade300,
            Colors.grey.shade200,
          ],
        ),
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.green.shade900,
          ),
          backgroundColor: Colors.greenAccent,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MenuPage()));
          },
        ),
        drawer: Container(
          width: widthSreen * 0.7,
          child: Drawer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.green.shade900),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).platform == TargetPlatform.iOS
                              ? Colors.white
                              : Colors.white,
                      child: Text(nama == null
                          ? "X"
                          : nama.substring(0, 1).toUpperCase()),
                    ),
                    accountName: Text("$nama"),
                    accountEmail: SizedBox()),
                Container(
                    padding: EdgeInsets.only(left: 16),
                    alignment: Alignment.centerLeft,
                    width: widthSreen * 0.7,
                    height: 48,
                    decoration: BoxDecoration(color: Colors.green.shade900),
                    child: Text("Menu", style: TextStyle(color: Colors.white))),
                Container(
                    padding: EdgeInsets.only(left: 16),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 2),
                    width: widthSreen * 0.7,
                    height: 48,
                    decoration: BoxDecoration(color: Colors.green.shade900),
                    child:
                        Text("Pesanan", style: TextStyle(color: Colors.white))),
                Spacer(),
                InkWell(
                    onTap: () {
                      logOut();
                    },
                    child: Container(
                        width: widthSreen * 0.7,
                        height: 48,
                        decoration: BoxDecoration(color: Colors.greenAccent),
                        child: Center(child: Text("LOG OUT")))),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: Text("DASHBOARD"),
                  backgroundColor: Colors.green[900],
                ),
              ];
            },
            body: Column(
              children: [
                Container(
                  child: Image.asset("assets/images/logo2.jpg"),
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  width: widthSreen,
                  color: Colors.grey.shade300,
                  child: Text("List Pesanan $nama",
                      style: TextStyle(fontSize: 24, color: Colors.black)),
                ),
                Expanded(
                  child: _PesananList(
                    meja: nama,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PesananTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pesanan = context.watch<PesananModel>();

    return pesanan == null
        ? Text("Tidak ada Pesanan")
        : SizedBox(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<MenuProvider>(
                      builder: (context, pesanan, chils) => Text(
                          pesanan.menu == null
                              ? "Total Pesanan "
                              : "Total Pesanan " +
                                  pesanan.menu.items.length.toString(),
                          style: TextStyle(fontSize: 24, color: Colors.black)))
                ],
              ),
            ),
          );
  }
}

class _PesananList extends StatelessWidget {
  final String meja;

  const _PesananList({Key key, this.meja}) : super(key: key);
  @override
  Widget build(BuildContext context) {
//    var pesanan = context.watch<PesananProvider>();
    final pesanan = context.select((PesananProvider p) => p.pesanan);
//    pesanan.loadPesanan();
    print("data pesanan : " + pesanan.toString());
    return pesanan == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : pesanan.data.where((element) => element.mja == meja).toList().isEmpty
            ? Center(child: Text("Tidak Ada Pesanan"))
            : ListView.builder(
                itemCount: pesanan.data
                    .where((element) => element.mja == meja)
                    .toList()
                    .length,
                itemBuilder: (context, index) {
                  var pesananMeja = pesanan.data
                      .where((element) => element.mja == meja)
                      .toList();
                  return Column(
                    children: [
                      ExpansionTile(
                        collapsedBackgroundColor: Colors.white,
                        backgroundColor: Colors.white,
                        title: Text(
                          pesananMeja[index].nma,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        childrenPadding: EdgeInsets.symmetric(
                          horizontal: 18,
                        ),
                        children: [
                          FutureBuilder(
                              future: DBService()
                                  .getPesananDetails(pesananMeja[index].idt),
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
                                    return Commons.sampleLoading(
                                        "Getting Data...");
                                  case ConnectionState.done:
                                    if (snapshot.hasError) {
                                      return Error(
                                        errorMessage: "Error load menu",
                                      );
                                    } else {
                                      return Column(
                                        children: [
                                          ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  snapshot.data["data"].length,
                                              itemBuilder:
                                                  (context, i) => Container(
                                                          child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          FutureBuilder(
                                                              future: DBService()
                                                                  .getMenuByAcc(
                                                                      snapshot.data["data"]
                                                                              [
                                                                              i]
                                                                          [
                                                                          "mnu"]),
                                                              builder: (context,
                                                                  ss) {
                                                                if (ss.connectionState ==
                                                                    ConnectionState
                                                                        .done) {
                                                                  return Expanded(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Container(
                                                                          margin:
                                                                              EdgeInsets.only(right: 4),
                                                                          color:
                                                                              Colors.green,
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                          child:
                                                                              CachedNetworkImage(imageUrl: Commons.baseURL + "menu/" + ss.data["data"]["im1"].toString()),
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Text(ss.data["data"]["nma"].toString()),
                                                                          ],
                                                                        ),
                                                                        Text(ss
                                                                            .data["data"]["hrg"]
                                                                            .toString()),
                                                                      ],
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      "");
                                                                }
                                                              }),
                                                          Text("x" +
                                                              snapshot
                                                                  .data["data"]
                                                                      [i]["jml"]
                                                                  .toString()),
                                                        ],
                                                      ))),
                                        ],
                                      );
                                    }
                                }
                                return Commons.sampleLoading("load data ... ");
                              }),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Text("Total Harga : " +
                                  pesananMeja[index].tot.toString())),
                        ],
                      ),
                      Divider(),
                      index != pesananMeja.length - 1
                          ? SizedBox()
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            )
                    ],
                  );
                });
  }
}
