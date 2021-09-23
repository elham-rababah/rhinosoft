class Product {
  String id;
  String title;
  String uid;
  int quantity;
  String description;
  List<String> category;
  List<String> images;

  DateTime createAt;
  String tags;
  dynamic price;

  Product(
      {this.id,
        this.title,
        this.uid,
        this.quantity,

        this.description,
        this.category,
        this.images,

        this.createAt,
        this.tags,
        this.price});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    uid = json['uid'];
    quantity = json['quantity'];
    description = json['description'];
    category = json['category'].cast<String>();
    images = json['images'].cast<String>();
    createAt =
    json['createAt'] is String ? DateTime.parse(json['createAt']) : DateTime
        .parse(json['createAt'].toDate().toString());
    tags = json['tags'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['uid'] = this.uid;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    data['category'] = this.category;
    data['images'] = this.images;
    data['createAt'] = this.createAt ?? DateTime.now();
    data['tags'] = this.tags;
    data['price'] = this.price;
    return data;
  }
}
