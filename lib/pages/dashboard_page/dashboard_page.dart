import 'package:cashier_app/models/pesanan_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    double widthSreen = MediaQuery.of(context).size.width;
    double heightSreen = MediaQuery.of(context).size.height;
    double defaultMargin = widthSreen * 0.1;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.7],
          colors: [
            Colors.grey,
            Colors.grey,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text("MY DASHBOARD"),
                backgroundColor: Colors.transparent,
              )
            ];
          },
          body: Container(
              child: Column(
            children: [
              Container(
                child: Image.asset("assets/images/logo2.jpg"),
              ),
              Text("List Pesanan",
                  style: TextStyle(fontSize: 24, color: Colors.black)),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(32),
                child: _PesananList(),
              )),
              Divider(height: 4, color: Colors.black),
              _PesananTotal(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/menu");
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
                    "Buat Pesanan",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  )),
            ],
          )),
        ),
      ),
    );
  }
}

class _PesananTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<PesananModel>(
                builder: (context, pesanan, chils) => Text(
                    "Total Pesanan ${pesanan.items.length}",
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
    var pesanan = context.watch<PesananModel>();
    return ListView.builder(
      itemCount: pesanan.items.length,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.done),
        trailing: IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: () {
              pesanan.remove(pesanan.items[index]);
            }),
        title: Text(
          pesanan.items[index].nama,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
