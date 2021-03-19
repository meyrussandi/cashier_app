import 'package:cashier_app/models/pesanan_model.dart';
import 'package:flutter/cupertino.dart';

class MenuModel {
  static List<String> makanan = [
    'Code Smell',
    'Control Flow',
    'Interpreter',
    'Recursion',
    'Sprint',
    'Heisenbug',
    'Spaghetti',
    'Hydra Code',
    'Off-By-One',
    'Scope',
    'Callback',
    'Closure',
    'Automata',
    'Bit Shift',
    'Currying',
  ];

  List<String> get items => makanan;

  Makanan getById(int id) => Makanan(id, makanan[id % makanan.length]);

  Makanan getByPosition(int position) {
    return getById(position);
  }
}

@immutable
class Makanan {
  final int id;
  final String nama;
  final int harga = 5000;

  Makanan(this.id, this.nama);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Makanan && other.id == id;
}
