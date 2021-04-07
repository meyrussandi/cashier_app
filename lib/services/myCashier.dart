// import 'package:cashier_app/models/makanan.dart';
// import 'package:flutter/foundation.dart';

// class MyCashier extends ChangeNotifier {
//   //global variabel
//   List<Makanan> _makanan = [];
//   List<Makanan> _myBaskets = [];
//   Makanan _activeMakanan = null;

//   //constructor
//   MyCashier() {
//     _makanan = [
//       Makanan(
//           id: 1,
//           name: "nasi",
//           price: 2000,
//           qty: 1,
//           pict:
//               "https://asset.kompas.com/crops/B9vcTHScIJaC9fPT8hl-qUYH0iQ=/3x0:700x465/750x500/data/photo/2020/09/08/5f577fce97a7f.jpg"),
//       Makanan(
//           id: 2,
//           name: "ayam",
//           price: 5000,
//           qty: 1,
//           pict:
//               "https://cdn-2.tstatic.net/tribunnews/foto/bank/images/resep-ayam-goreng-kuning-tabur-serundeng.jpg"),
//       Makanan(
//           id: 3,
//           name: "soto",
//           price: 8000,
//           qty: 1,
//           pict:
//               "https://radiodms.com/wp-content/uploads/2020/07/1.-resep-soto-ayam-1200x675.jpg"),
//       Makanan(
//           id: 4,
//           name: "mie",
//           price: 3000,
//           qty: 1,
//           pict:
//               "http://kbu-cdn.com/dk/wp-content/uploads/mie-goreng-sosis.jpg"),
//     ];

//     notifyListeners();
//   }

//   List<Makanan> get makanan => _makanan;
//   List<Makanan> get myBaskets => _myBaskets;
//   Makanan get activeMakanan => _activeMakanan;

//   setActiveMenu(Makanan m) {
//     _activeMakanan = m;
//   }

//   addToMyOrder(Makanan m) {
//     //cek first in the order
//     Makanan isThere = _myBaskets.firstWhere((element) => element.id == m.id,
//         orElse: () => null);
//     if (isThere != null) {
//       isThere.qty += 1;
//     } else {
//       _myBaskets.add(m);
//     }
//     notifyListeners();
//   }

//   removeToMyOrder(Makanan m) {
//     //cek first in the order
//     Makanan isThere =
//         _myBaskets.firstWhere((a) => a.id == m.id, orElse: () => null);
//     if (isThere != null && isThere.qty == 1) {
//       _myBaskets.remove(m);
//     } else {
//       isThere.qty -= 1;
//     }
//     notifyListeners();
//   }

//   getMyOrdersQty() {
//     int total = 0;
//     for (int i = 0; i < _myBaskets.length; i++) {
//       total += myBaskets[i].qty;
//     }
//     return total;
//   }
// }
