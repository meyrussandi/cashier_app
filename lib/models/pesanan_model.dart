import 'package:cashier_app/models/menu_model.dart';
import 'package:flutter/cupertino.dart';

class PesananModel extends ChangeNotifier {
  late MenuModel _menu;

  final List<int> _itemsId = [];

  set menu(MenuModel newMenu) {
    _menu = newMenu;
    notifyListeners();
  }

  List<Makanan> get items => _itemsId.map((id) => _menu.getById(id)).toList();

  int get totalPrice =>
      items.fold(0, (total, current) => total + current.harga);

  void add(Makanan makanan) {
    _itemsId.add(makanan.id);
    notifyListeners();
  }

  void remove(Makanan makanan) {
    _itemsId.remove(makanan.id);
    notifyListeners();
  }
}
