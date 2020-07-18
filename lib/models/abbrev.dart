class Abbrev {
  String pt;
  String en;

  Abbrev({this.pt, this.en});

  Abbrev.fromJson(Map<String, dynamic> json) {
    pt = json['pt'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pt'] = this.pt;
    data['en'] = this.en;
    return data;
  }
}
