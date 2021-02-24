class Sendactiveorders {
  String id;
  String itemtype;
  String itemdescription;
  String ordertotal;
  String pickupaddress;
  String pickupphnnumber;
  String pickupdate;
  String pickuptime;
  String deliveryaddress;
  String deliveryphnnumber;
  String arrivedate;
  String arrivetime;

  Sendactiveorders({
    this.id,
    this.itemtype,
    this.itemdescription,
    this.ordertotal,
    this.pickupaddress,
    this.pickupphnnumber,
    this.pickupdate,
    this.pickuptime,
    this.deliveryaddress,
    this.deliveryphnnumber,
    this.arrivedate,
    this.arrivetime,
  });
  factory Sendactiveorders.fromJson(Map<String, dynamic> json) {
    return Sendactiveorders(
      id: json['id'],
      itemtype: json['item_type'],
      itemdescription: json['item_description'],
      ordertotal: json['order_total'],
      pickupaddress: json['pickup_address'],
      pickupphnnumber: json['pickup_phn_number'],
      pickupdate: json['pickup_date'],
      pickuptime: json['pickup_time'],
      deliveryaddress: json['delivery_address'],
      deliveryphnnumber: json['delivery_phn_number'],
      arrivedate: json['arrive_date'],
      arrivetime: json['arrive_time'],
    );
  }
}

class Shopactiveorders {
  String shoporderid;
  String shopname;
  String itemname;
  String orderamount;
  String pickupshopname;
  String pickupaddress;
  String deliveryaddress;
  String deliverycontact;
  String deliverydate;
  String deliverytime;

  Shopactiveorders({
    this.shoporderid,
    this.shopname,
    this.itemname,
    this.orderamount,
    this.pickupshopname,
    this.pickupaddress,
    this.deliveryaddress,
    this.deliverycontact,
    this.deliverydate,
    this.deliverytime,
  });
  factory Shopactiveorders.fromJson(Map<String, dynamic> json) {
    return Shopactiveorders(
      shoporderid: json['shop_order_id'],
      shopname: json['shop_name'],
      itemname: json['item_name'],
      orderamount: json['order_amount'],
      pickupshopname: json['pickup_shop_name'],
      pickupaddress: json['pickup_address'],
      deliveryaddress: json['delivery_address'],
      deliverycontact: json['delivery_contact'],
      deliverydate: json['delivery_date'],
      deliverytime: json['delivery_time'],
    );
  }
}

class Restaurantactiveorders {
  String id;
  String restaurantname;
  String weight;
  String orderamount;
  String pickupcontactnumber;
  String pickupaddress;
  String deliveryaddress;
  String deliverycontact;
  String deliverydate;
  String deliverytime;

  Restaurantactiveorders({
    this.id,
    this.restaurantname,
    this.weight,
    this.orderamount,
    this.pickupcontactnumber,
    this.pickupaddress,
    this.deliveryaddress,
    this.deliverycontact,
    this.deliverydate,
    this.deliverytime,
  });
  factory Restaurantactiveorders.fromJson(Map<String, dynamic> json) {
    return Restaurantactiveorders(
      id: json['id'],
      restaurantname: json['restaurant_name'],
      weight: json['weight'],
      orderamount: json['order_amount'],
      pickupcontactnumber: json['pickup_contact_number'],
      pickupaddress: json['pickup_address'],
      deliveryaddress: json['delivery_address'],
      deliverycontact: json['delivery_contact'],
      deliverydate: json['delivery_date'],
      deliverytime: json['delivery_time'],
    );
  }
}

