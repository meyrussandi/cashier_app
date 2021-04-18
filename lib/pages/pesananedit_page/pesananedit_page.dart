import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashier_app/services/dbService.dart';
import 'package:cashier_app/services/providers.dart';
import 'package:cashier_app/utils/constanst.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app/utils/error.dart';
import 'package:provider/provider.dart';

class PesananEditPage extends StatefulWidget {
  final idt;

  const PesananEditPage({Key key, this.idt}) : super(key: key);

  @override
  _PesananEditPageState createState() => _PesananEditPageState();
}

class _PesananEditPageState extends State<PesananEditPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ubah Pesanan"),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 16),
              child: InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  child: Icon(Icons.refresh)),
            )
          ],
        ),
        body: FutureBuilder(
            future: DBService().getPesananDetails(widget.idt),
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
                      errorMessage: "Error load pesanan",
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data["data"].length,
                        itemBuilder: (context, i) => Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        //delete berdasarkan idt and mnu
                                        print("idt : " +
                                            snapshot.data["data"][i]["idn"]);
                                        await DBService().deletepesanandetails(
                                            snapshot.data["data"][i]["idt"],
                                            snapshot.data["data"][i]["mnu"]);
                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      ),
                                    ),
                                    snapshot.data["data"][i]["jml"] == "1.00"
                                        ? SizedBox(
                                            width: 30,
                                          )
                                        : InkWell(
                                            onTap: () async {
                                              await DBService()
                                                  .minjmlpesanandetails(
                                                      snapshot.data["data"][i]
                                                          ["idt"],
                                                      snapshot.data["data"][i]
                                                          ["mnu"]);

                                              setState(() {});
                                            },
                                            child: Icon(Icons.remove)),
                                    Text(snapshot.data["data"][i]["jml"]
                                        .split(".")[0]
                                        .toString()),
                                    InkWell(
                                      onTap: () async {
                                        await DBService().addjmlpesanandetails(
                                            snapshot.data["data"][i]["idt"],
                                            snapshot.data["data"][i]["mnu"]);
                                        setState(() {});
                                      },
                                      child: Icon(Icons.add),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FutureBuilder(
                                        future: DBService().getMenuByAcc(
                                            snapshot.data["data"][i]["mnu"]),
                                        builder: (context, ss) {
                                          if (ss.connectionState ==
                                              ConnectionState.done) {
                                            return Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 4),
                                                    color: Colors.green,
                                                    height: 100,
                                                    width: 100,
                                                    child: CachedNetworkImage(
                                                        imageUrl: Commons
                                                                .baseURL +
                                                            "menu/" +
                                                            ss.data["data"]
                                                                    ["im1"]
                                                                .toString()),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 80,
                                                        width: 100,
                                                        child: Text(
                                                          ss.data["data"]["nma"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(ss.data["data"]["hrg"]
                                                      .toString()),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Text("");
                                          }
                                        }),
                                    Text(" x " +
                                        snapshot.data["data"][i]["jml"]
                                            .split(".")[0]
                                            .toString()),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("= ${snapshot.data["data"][i]["tot"]}")
                                  ],
                                ),
                                Divider()
                              ],
                            )));
                  }
              }
              return Commons.sampleLoading("load data ... ");
            }),
      ),
    );
  }
}
