import 'package:cashier_app/models/menu_model.dart';
import 'package:cashier_app/models/pesanan_model.dart';
import 'package:cashier_app/pages/menu_page/menu_page.dart';
import 'package:cashier_app/services/dbService.dart';
import 'package:cashier_app/services/providers.dart';
import 'package:http/http.dart';
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
                      child: Text("N"),
                    ),
                    accountName: Text("$nama"),
                    accountEmail: SizedBox()),
                Text("Menu 1"),
                Text("Menu 2"),
                Spacer(),
                InkWell(
                    onTap: () {
                      logOut();
                    },
                    child: Container(child: Text("Log Out"))),
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
                  child: _PesananList(),
                ),
                // SizedBox(
                //   height: heightSreen * 0.1,
                // )
                //Divider(height: 4, color: Colors.black),
                // _PesananTotal(),
                // ElevatedButton(
                //     onPressed: () {
                //       Navigator.pushNamed(context, "/menu");
                //     },
                //     style: ButtonStyle(
                //         backgroundColor: MaterialStateProperty.all<Color>(
                //             Colors.greenAccent),
                //         shape:
                //             MaterialStateProperty.all<RoundedRectangleBorder>(
                //                 RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(10),
                //                     side: BorderSide(color: Colors.blue))),
                //         padding: MaterialStateProperty.all<EdgeInsets>(
                //             EdgeInsets.symmetric(
                //                 horizontal: widthSreen * 0.2, vertical: 10))),
                //     child: Text(
                //       "Buat Pesanan",
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 20,
                //           fontWeight: FontWeight.w400),
                //     )),
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
        : pesanan.data.isEmpty
            ? Center(child: Text("Tidak Ada Pesanan"))
            : ListView.builder(
                itemCount: pesanan.data.length,
                itemBuilder: (context, index) => Column(
                      children: [
                        ExpansionTile(
                          title: Text(
                            "nama " + pesanan.data[index].nma,
                            style: TextStyle(color: Colors.black),
                          ),
                          childrenPadding: EdgeInsets.symmetric(
                            horizontal: 18,
                          ),
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: 5,
                                itemBuilder: (context, i) => Container(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Menu"),
                                        Text("Total Harga"),
                                        Text("Jumlah"),
                                      ],
                                    ))),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text("Total Harga")),
                          ],
                        ),
                        Divider(),
                      ],
                    )
//                 ListTile(
//                   leading: Icon(Icons.done),
//                   trailing: IconButton(
//                       icon: Icon(Icons.remove_circle_outline),
//                       onPressed: () {
// //                    pesanan.remove(pesanan.data[index]);
//                       }),
//                   title: Text(
//                     "nama " + pesanan.data[index].nma,
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
                );
  }
}
