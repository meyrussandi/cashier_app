// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

import 'dart:convert';

import 'package:cashier_app/models/makanan.dart';

Menu menuFromJson(String str) => Menu.fromJson(json.decode(str));

String menuToJson(Menu data) => json.encode(data.toJson());

class Menu {
  Menu({
    this.menu,
  });

  List<Makanan> menu;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        menu: json["menu"] == null
            ? null
            : List<Makanan>.from(json["menu"].map((x) => Makanan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "menu": menu == null
            ? null
            : List<dynamic>.from(menu.map((x) => x.toJson())),
      };

  List<Makanan> get items => menu;

  Makanan getById(int id) => Makanan(idn: id, nma: menu[id % menu.length].nma);

  Makanan getByPosition(int position) {
    return getById(position);
  }
}

// class MenuModel {
//   static List<String> makanan = [
//     'Code Smell',
//     'Control Flow',
//     'Interpreter',
//     'Recursion',
//     'Sprint',
//     'Heisenbug',
//     'Spaghetti',
//     'Hydra Code',
//     'Off-By-One',
//     'Scope',
//     'Callback',
//     'Closure',
//     'Automata',
//     'Bit Shift',
//     'Currying',
//   ];

//   List<String> get items => makanan;

//   Makanan getById(int id) => Makanan(id, makanan[id % makanan.length]);

//   Makanan getByPosition(int position) {
//     return getById(position);
//   }
// }

// @immutable
// class Makanan {
//   final int id;
//   final String nama;
//   final int harga = 5000;

//   Makanan(this.id, this.nama);

//   @override
//   int get hashCode => id;

//   @override
//   bool operator ==(Object other) => other is Makanan && other.id == id;
// }

class Keranjang {
  Keranjang({
    this.idn,
    this.acc,
    this.nma,
    this.hrg,
    this.im1,
    this.ket,
    this.qty,
  });

  int idn;
  String acc;
  String nma;
  double hrg;
  String im1;
  String ket;
  int qty;
}
