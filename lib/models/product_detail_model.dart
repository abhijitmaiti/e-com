class ProductDetailModel {
  ProductDetailModel({
      String? id, 
      String? title, 
      String? description, 
      num? price, 
      num? offerPrice, 
      num? deliveryCharge, 
      bool? cod, 
      num? star5, 
      num? star4, 
      num? star3, 
      num? star2, 
      num? star1, 
      List<Options>? options,}){
    _id = id;
    _title = title;
    _description = description;
    _price = price;
    _offerPrice = offerPrice;
    _deliveryCharge = deliveryCharge;
    _cod = cod;
    _star5 = star5;
    _star4 = star4;
    _star3 = star3;
    _star2 = star2;
    _star1 = star1;
    _options = options;
}

  ProductDetailModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _price = json['price'];
    _offerPrice = json['offer_price'];
    _deliveryCharge = json['delivery_charge'];
    _cod = json['cod'];
    _star5 = json['star_5'];
    _star4 = json['star_4'];
    _star3 = json['star_3'];
    _star2 = json['star_2'];
    _star1 = json['star_1'];
    if (json['options'] != null) {
      _options = [];
      json['options'].forEach((v) {
        _options?.add(Options.fromJson(v));
      });
    }
  }
  String? _id;
  String? _title;
  String? _description;
  num? _price;
  num? _offerPrice;
  num? _deliveryCharge;
  bool? _cod;
  num? _star5;
  num? _star4;
  num? _star3;
  num? _star2;
  num? _star1;
  List<Options>? _options;
ProductDetailModel copyWith({  String? id,
  String? title,
  String? description,
  num? price,
  num? offerPrice,
  num? deliveryCharge,
  bool? cod,
  num? star5,
  num? star4,
  num? star3,
  num? star2,
  num? star1,
  List<Options>? options,
}) => ProductDetailModel(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  price: price ?? _price,
  offerPrice: offerPrice ?? _offerPrice,
  deliveryCharge: deliveryCharge ?? _deliveryCharge,
  cod: cod ?? _cod,
  star5: star5 ?? _star5,
  star4: star4 ?? _star4,
  star3: star3 ?? _star3,
  star2: star2 ?? _star2,
  star1: star1 ?? _star1,
  options: options ?? _options,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  num? get price => _price;
  num? get offerPrice => _offerPrice;
  num? get deliveryCharge => _deliveryCharge;
  bool? get cod => _cod;
  num? get star5 => _star5;
  num? get star4 => _star4;
  num? get star3 => _star3;
  num? get star2 => _star2;
  num? get star1 => _star1;
  List<Options>? get options => _options;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['price'] = _price;
    map['offer_price'] = _offerPrice;
    map['delivery_charge'] = _deliveryCharge;
    map['cod'] = _cod;
    map['star_5'] = _star5;
    map['star_4'] = _star4;
    map['star_3'] = _star3;
    map['star_2'] = _star2;
    map['star_1'] = _star1;
    if (_options != null) {
      map['options'] = _options?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Options {
  Options({
      String? id, 
      String? option, 
      num? quantity, 
      List<Images>? images,}){
    _id = id;
    _option = option;
    _quantity = quantity;
    _images = images;
}

  Options.fromJson(dynamic json) {
    _id = json['id'];
    _option = json['option'];
    _quantity = json['quantity'];
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
  }
  String? _id;
  String? _option;
  num? _quantity;
  List<Images>? _images;
Options copyWith({  String? id,
  String? option,
  num? quantity,
  List<Images>? images,
}) => Options(  id: id ?? _id,
  option: option ?? _option,
  quantity: quantity ?? _quantity,
  images: images ?? _images,
);
  String? get id => _id;
  String? get option => _option;
  num? get quantity => _quantity;
  List<Images>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['option'] = _option;
    map['quantity'] = _quantity;
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Images {
  Images({
      num? position, 
      String? image, 
      String? productOption,}){
    _position = position;
    _image = image;
    _productOption = productOption;
}

  Images.fromJson(dynamic json) {
    _position = json['position'];
    _image = json['image'];
    _productOption = json['product_option'];
  }
  num? _position;
  String? _image;
  String? _productOption;
Images copyWith({  num? position,
  String? image,
  String? productOption,
}) => Images(  position: position ?? _position,
  image: image ?? _image,
  productOption: productOption ?? _productOption,
);
  num? get position => _position;
  String? get image => _image;
  String? get productOption => _productOption;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['position'] = _position;
    map['image'] = _image;
    map['product_option'] = _productOption;
    return map;
  }

}