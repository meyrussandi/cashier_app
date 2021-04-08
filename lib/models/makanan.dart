// class Makanan {
//   int id;
//   String name;
//   double price;
//   int qty;
//   String pict;

//   Makanan({this.id, this.name, this.price, this.qty, this.pict});
// }

class Makanan {
  Makanan({
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

  factory Makanan.fromJson(Map<String, dynamic> json) => Makanan(
      idn: json["idn"] == null ? null : int.parse(json["idn"]),
      acc: json["acc"] == null ? null : json["acc"],
      nma: json["nma"] == null ? null : json["nma"],
      hrg: json["hrg"] == null ? null : double.parse(json["hrg"]),
      im1: json["im1"] == null ? null : json["im1"],
      ket: json["ket"] == null ? null : json["ket"],
      qty: 0);

  Map<String, dynamic> toJson() => {
        "idn": idn == null ? null : idn,
        "acc": acc == null ? null : acc,
        "nma": nma == null ? null : nma,
        "hrg": hrg == null ? null : hrg,
        "im1": im1 == null ? null : im1,
        "ket": ket == null ? null : ket,
      };
}
