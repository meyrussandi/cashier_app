class Pesanan {
  String name;
  String table;
  String total;

  Pesanan({this.name, this.table, this.total});

  factory Pesanan.fromJson(Map<String, dynamic> json) {
    return Pesanan(
      name: json['name'] as String,
      table: json['table'] as String,
      total: json['total'] as String,
    );
  }
}
