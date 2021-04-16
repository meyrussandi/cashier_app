import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashier_app/services/dbService.dart';
import 'package:cashier_app/services/providers.dart';
import 'package:cashier_app/utils/constanst.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app/utils/error.dart';
import 'package:provider/provider.dart';

class PesananEditPage extends StatelessWidget {
  final idt;

  const PesananEditPage({Key key, this.idt}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pesanan Saya"),
        ),
        body: Column(
          children: [
            FutureBuilder(
                future: DBService().getPesananDetails(idt),
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
                        return Column(
                          children: [
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data["data"].length,
                                itemBuilder: (context, i) => Container(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FutureBuilder(
                                            future: DBService().getMenuByAcc(
                                                snapshot.data["data"][i]
                                                    ["mnu"]),
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
                                                        height: 50,
                                                        width: 50,
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
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(ss.data["data"]
                                                                  ["nma"]
                                                              .toString()),
                                                        ],
                                                      ),
                                                      Text(ss.data["data"]
                                                              ["hrg"]
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
                                    ))),
                          ],
                        );
                      }
                  }
                  return Commons.sampleLoading("load data ... ");
                }),
          ],
        ),
      ),
    );
  }
}
