class ModifierModel {
  String modifierName;
  String uid;
  bool isRequired;
  bool onlyOne;
  List<Children> children;
  DateTime createAt;

  ModifierModel(
      {this.modifierName,
      this.isRequired = false,
      this.children,
      this.onlyOne = true});

  ModifierModel.fromJson(Map<String, dynamic> json) {
    modifierName = json['modifierName'];
    isRequired = json['isRequired'];
    onlyOne = json['onlyOne'];
    uid = json['uid'];
    createAt = json['createAt'] is String
        ? DateTime.parse(json['createAt'])
        : DateTime.parse(json['createAt'].toDate().toString());
    if (json['children'] != null) {
      children = new List<Children>();
      json['children'].forEach((v) {
        children.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modifierName'] = this.modifierName;
    data['isRequired'] = this.isRequired;
    data['onlyOne'] = this.onlyOne;
    data['uid'] = this.uid;
    data['createAt'] = this.createAt ?? DateTime.now();

    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String label;
  int price;

  Children({this.label, this.price});

  Children.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['price'] = this.price;
    return data;
  }
}
