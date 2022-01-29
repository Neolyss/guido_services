class Bill {
  final String id;
  final String idCommand;
  final String date;
  final double serviceFee;
  final double deliveryFee;
  final double promotion;
  final List<Product> products;
  final String idClient;
  final String address;
  final String phone;
  final String commandDate;

  Bill(
  {
    required this.id,
    required this.idCommand,
    required this.date,
    required this.serviceFee,
    required this.deliveryFee,
    required this.promotion,
    required this.products,
    required this.idClient,
    required this.address,
    required this.phone,
    required this.commandDate,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
        id: json["factures"]["id_facture"],
        idCommand: json["factures"]["commande"],
        date: json["factures"]["date"],
        serviceFee: json["factures"]["fraisService"],
        deliveryFee: json["factures"]["fraisService"],
        promotion: json["factures"]["fraisLivraison"],
        products: Product.getProductsFromJson(json),
        idClient: json["client"]["fraisService"],
        address: json["client"]["fraisService"],
        phone: json["client"]["telephone"],
        commandDate: json["date_commande"],
    );
  }
}

class Product {
  final String name;
  final String model;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final ProductState state;

  Product({
    required this.name, required this.model, required this.quantity, required this.unitPrice, required this.totalPrice, required this.state,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        name: json["nom"],
        model: json["modele"],
        quantity: json["qtt"],
        unitPrice: json["prix_unitaire"],
        totalPrice: json["prix_total"],
        state: ProductStateExt.getState(json["etat"].toString()),
    );
  }

  static List<Product> getProductsFromJson(Map<String, dynamic> json) {
    List<Product> products = [];
    json["products"].map((i) => Product.fromJson(json)).forEach((e) => products.add(e));
    return products;
  }

}

enum ProductState {
  //'In stock','Available','Not available','Out of stock','Free gift','Packed','Dispatched','Arrived','Delivered','Other'
  inStock,
  available,
  notAvailable,
  outOfStock,
  freeGift,
  packed,
  dispatched,
  arrived,
  delivered,
  other
}

extension ProductStateExt on ProductState {
  String get name {
    switch (this) {
      case ProductState.inStock:
        return 'In stock';
      case ProductState.available:
        return 'Available';
      case ProductState.notAvailable:
        return 'Not available';
      case ProductState.outOfStock:
        return 'Out of stock';
      case ProductState.freeGift:
        return 'Free gift';
      case ProductState.packed:
        return 'Packed';
      case ProductState.dispatched:
        return 'Dispatched';
      case ProductState.arrived:
        return 'Arrived';
      case ProductState.delivered:
        return 'Delivered';
      default:
        return 'Other';
    }
  }

  static ProductState getState(String name) {
    switch (name) {
      case 'In stock':
        return ProductState.inStock;
      case 'Available':
        return ProductState.available;
      case 'Not available':
        return ProductState.notAvailable;
      case 'Out of stock':
        return ProductState.outOfStock;
      case 'Free gift':
        return ProductState.freeGift;
      case 'Packed' :
        return ProductState.packed;
      case 'Dispatched':
        return ProductState.dispatched;
      case 'Arrived':
        return ProductState.arrived;
      case 'Delivered':
        return ProductState.delivered;
      default:
        return ProductState.other;
    }
  }
}
