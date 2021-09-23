class Product {
  String id;
  String title;
  String uid;
  int quantity;
  int year;
  String condition;
  String description;
  List<String> category;
  List<String> images;
  String shippingDetails;
  bool isCancelled;
  bool isSelling;
  bool isSold;
  bool isReviews;
  bool isDraft;
  DateTime createAt;
  String paymentIntent;
  String tags;
  double price;

  Product(
      {this.id,
        this.title,
        this.uid,
        this.quantity,
        this.year,
        this.condition,
        this.description,
        this.category,
        this.images,
        this.shippingDetails,
        this.isCancelled,
        this.isSelling,
        this.isSold,
        this.isReviews,
        this.isDraft,
        this.createAt,
        this.paymentIntent,
        this.tags,
        this.price});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    uid = json['uid'];
    quantity = json['quantity'];
    year = json['year'];
    condition = json['condition'];
    description = json['description'];
    category = json['category'].cast<String>();
    images = json['images'].cast<String>();
    shippingDetails = json['shippingDetails'];
    isCancelled = json['isCancelled'] ?? false;
    isSelling = json['isSelling'] ?? false;
    isSold = json['isSold'] ?? false;
    isReviews = json['isReviews'] ?? false;
    isDraft = json['isDraft'] ?? false;
    createAt =
    json['createAt'] is String ? DateTime.parse(json['createAt']) : DateTime
        .parse(json['createAt'].toDate().toString());
    paymentIntent = json['paymentIntent'];
    tags = json['tags'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['uid'] = this.uid;
    data['quantity'] = this.quantity;
    data['year'] = this.year;
    data['condition'] = this.condition;
    data['description'] = this.description;
    data['category'] = this.category;
    data['images'] = this.images;
    data['shippingDetails'] = this.shippingDetails;
    data['isCancelled'] = this.isCancelled ?? false;
    data['isSelling'] = this.isSelling ?? false;
    data['isSold'] = this.isSold ?? false;
    data['isReviews'] = this.isReviews ?? false;
    data['isDraft'] = this.isDraft ?? false;
    data['createAt'] = this.createAt ?? DateTime.now();
    data['paymentIntent'] = this.paymentIntent;
    data['tags'] = this.tags;
    data['price'] = this.price;
    return data;
  }
}
