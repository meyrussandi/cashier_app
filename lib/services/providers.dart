import 'dart:convert';
import 'dart:io';

import 'package:cashier_app/models/makanan.dart';
import 'package:cashier_app/models/menu_model.dart';
import 'package:cashier_app/models/pesanan_model.dart';
import 'package:cashier_app/services/dbService.dart';
import 'package:cashier_app/utils/constanst.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

class MenuProvider extends ChangeNotifier {
  //global variabel
//  List<Makanan> _makanan = [];
  List<Makanan> _myBaskets = [];
  Makanan _activeMakanan = null;
  Menu menu;

//  List<Makanan> get makanan => _makanan;
  List<Makanan> get myBaskets => _myBaskets;
  Makanan get activeMakanan => _activeMakanan;

  void loadMenu() async {
    menu = await DBService().fetchMenu();
    notifyListeners();
  }

  setActiveMenu(Makanan m) {
    _activeMakanan = m;
  }

  // setPrice() {
  //   Makanan m = menu.items.firstWhere(
  //       (element) => element.idn == _myBaskets[index].idn,
  //       orElse: () => null);
  //   _myBaskets[index].hrg = m.hrg * _myBaskets[index].qty;
  //   notifyListeners();
  // }

  addToMyOrder(Makanan m) {
    //cek first in the order
    Makanan isThere = _myBaskets.firstWhere((element) => element.idn == m.idn,
        orElse: () => null);
    if (_myBaskets.contains(m)) {
      isThere.qty += 1;
    } else {
      m.qty = 1;
      _myBaskets.add(m);
    }
    notifyListeners();
  }

  removeToMyOrder(Makanan m) {
    //cek first in the order
    Makanan isThere =
        _myBaskets.firstWhere((a) => a.idn == m.idn, orElse: () => null);
    if (_myBaskets.contains(m)) {
      print("contains");
      if (isThere.qty == 1) {
        print("remove");
        _myBaskets.remove(m);
      } else {
        print("minus");
        isThere.qty -= 1;
      }
    }
    // if (isThere != null && isThere.qty == 1) {
    //   print("masuk");
    //   // _myBaskets.remove(m);
    // } else {
    //   // isThere.qty -= 1;
    // }
    notifyListeners();
  }

  getMyOrdersQty() {
    int total = 0;
    for (int i = 0; i < _myBaskets.length; i++) {
      total += myBaskets[i].qty;
    }
    return total;
  }

  getMyOrderTotalPrice() {
    double total = 0;
    for (int i = 0; i < _myBaskets.length; i++) {
      total += (myBaskets[i].hrg * myBaskets[i].qty);
    }
    return total;
  }

  getMyOrderPrice(var mb) {
    return mb.hrg * mb.qty;
  }

  clearMyBasket() {
    myBaskets.clear();
    notifyListeners();
  }
}

// class PesananProvider extends ChangeNotifier {
//   List<PesananModel> _pesanan;
//   Menu _menu;
//   Pesanan pesanan;

//   final List<int> _itemsId = [];
//   PesananProvider() {
//     loadPesanan();
//   }

//   void loadPesanan() async {
//     pesanan = await DBService().getPesanan();
//     print("data pesanan di provider: " + pesanan.toString());
//     notifyListeners();
//   }

//   set menu(Menu newMenu) {
//     _menu = newMenu;
//     notifyListeners();
//   }

//   List<Makanan> get items => _itemsId.map((id) => _menu.getById(id)).toList();

//   double get totalPrice =>
//       items.fold(0, (total, current) => total + current.hrg);

//   void add(Makanan makanan) {
//     _itemsId.add(makanan.idn);
//     notifyListeners();
//   }

//   void remove(Makanan makanan) {
//     _itemsId.remove(makanan.idn);
//     notifyListeners();
//   }
// }
