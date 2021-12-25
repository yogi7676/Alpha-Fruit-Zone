class CartItemModel {
  static const VENDORIMAGE = "image";
  static const PRODUCTNAME = "productName";
  static const QUANTITY = "quantity";
  static const PRICEDETAILS = 'priceDetails';
  static const UNITS = 'units';
  static const COST = "cost";
  static const PRODUCTPRICE = "price";
  static const PRODUCT_ID = "productId";
  static const BUSINESS_NAME = "vendor";
  static const VENDORADDRESS = "address";
  static const MEASURE = "measure";
  static const SELLINGID = 'sellingId';
  static const VENDORID = 'vendorId';

  String? vendorImage;
  String? productName;
  int? quantity;
  String? priceDetails;
  int? units;
  double? cost;
  String? productId;
  String? businessname;
  double? productPrice;
  String? vendorAddress;
  String? sellingId;
  String? vendorID;
  String? measure;

  CartItemModel(
    this.vendorImage,
    this.productName,
    this.quantity,
    this.productId,
    this.businessname,
    this.productPrice,
    this.vendorAddress,
    this.sellingId,
    this.vendorID,
    this.measure,
    this.priceDetails,
    this.units,
    this.cost,
  );

  CartItemModel.fromFirestore(Map<String, dynamic> data) {
    vendorImage = data[VENDORIMAGE];
    productName = data[PRODUCTNAME];
    quantity = data[QUANTITY];
    priceDetails = data[PRICEDETAILS];
    units = data[UNITS];
    cost = data[COST];
    productId = data[PRODUCT_ID];
    businessname = data[BUSINESS_NAME];
    productPrice = data[PRODUCTPRICE].toDouble();
    vendorAddress = data[VENDORADDRESS];
    sellingId = data[SELLINGID];
    vendorID = data[VENDORID];
    measure = data[MEASURE];
  }

  Map toFirestore() => {
        VENDORIMAGE: vendorImage,
        PRODUCTNAME: productName,
        QUANTITY: quantity,
        PRICEDETAILS: priceDetails,
        UNITS: units,
        COST: cost,
        PRODUCT_ID: productId,
        BUSINESS_NAME: businessname,
        PRODUCTPRICE: productPrice,
        VENDORADDRESS: vendorAddress,
        SELLINGID: sellingId,
        VENDORID: vendorID,
        MEASURE: measure
      };

  @override
  String toString() {
    return '$productId,$sellingId,$vendorID';
  }

  String toQuantity() {
    return quantity == 1 ? '' : quantity.toString();
  }

  String toPrice() {
    return productPrice!.toInt().toString();
  }
}
