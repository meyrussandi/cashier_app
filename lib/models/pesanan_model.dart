import 'package:cashier_app/models/makanan.dart';
import 'package:cashier_app/models/menu_model.dart';
import 'package:flutter/cupertino.dart';

// To parse this JSON data, do
//
//     final pesanan = pesananFromJson(jsonString);

import 'dart:convert';

Pesanan pesananFromJson(String str) => Pesanan.fromJson(json.decode(str));

String pesananToJson(Pesanan data) => json.encode(data.toJson());

class Pesanan {
  Pesanan({
    this.data,
  });

  List<PesananModel> data;

  factory Pesanan.fromJson(Map<String, dynamic> json) => Pesanan(
        data: json["data"] == null
            ? null
            : List<PesananModel>.from(
                json["data"].map((x) => PesananModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PesananModel {
  PesananModel({
    this.idn,
    this.idt,
    this.jpp,
    this.jps,
    this.jpd,
    this.jpf,
    this.nma,
    this.mja,
    this.ket,
    this.tot,
    this.tdi,
    this.idu,
    this.val,
  });

  String idn;
  String idt;
  String jpp;
  DateTime jps;
  DateTime jpd;
  DateTime jpf;
  String nma;
  String mja;
  String ket;
  String tot;
  DateTime tdi;
  String idu;
  String val;

  factory PesananModel.fromJson(Map<String, dynamic> json) => PesananModel(
        idn: json["idn"] == null ? null : json["idn"],
        idt: json["idt"] == null ? null : json["idt"],
        jpp: json["jpp"] == null ? null : json["jpp"],
        jps: json["jps"] == null ? null : DateTime.parse(json["jps"]),
        jpd: json["jpd"] == null ? null : DateTime.parse(json["jpd"]),
        jpf: json["jpf"] == null ? null : DateTime.parse(json["jpf"]),
        nma: json["nma"] == null ? null : json["nma"],
        mja: json["mja"] == null ? null : json["mja"],
        ket: json["ket"] == null ? null : json["ket"],
        tot: json["tot"] == null ? null : json["tot"],
        tdi: json["tdi"] == null ? null : DateTime.parse(json["tdi"]),
        idu: json["idu"] == null ? null : json["idu"],
        val: json["val"] == null ? null : json["val"],
      );

  Map<String, dynamic> toJson() => {
        "idn": idn == null ? null : idn,
        "idt": idt == null ? null : idt,
        "jpp": jpp == null ? null : jpp,
        "jps": jps == null ? null : jps.toIso8601String(),
        "jpd": jpd == null ? null : jpd.toIso8601String(),
        "jpf": jpf == null ? null : jpf.toIso8601String(),
        "nma": nma == null ? null : nma,
        "mja": mja == null ? null : mja,
        "ket": ket == null ? null : ket,
        "tot": tot == null ? null : tot,
        "tdi": tdi == null ? null : tdi.toIso8601String(),
        "idu": idu == null ? null : idu,
        "val": val == null ? null : val,
      };
}

// class PesananModel extends ChangeNotifier {
//   Menu _menu;

//   final List<int> _itemsId = [];

//   set menu(Menu newMenu) {
//     _menu = newMenu;
//     notifyListeners();
//   }

//   List<Makanan> get items => _itemsId.map((id) => _menu.getById(id)).toList();

//   double get totalPrice =>
//       items.fold(0, (total, current) => total + current.hrg);

//   void loadPesanan() async{

//   }

//   void add(Makanan makanan) {
//     _itemsId.add(makanan.idn);
//     notifyListeners();
//   }

//   void remove(Makanan makanan) {
//     _itemsId.remove(makanan.idn);
//     notifyListeners();
//   }
// }
