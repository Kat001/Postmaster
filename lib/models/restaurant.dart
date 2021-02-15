class Restaurant {
  String id;
  String name;
  String address;
  String contact;

  Restaurant({
    this.name,
    this.id,
    this.address,
    this.contact,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      contact: json['contact'],
      address: json['address'],
    );
  }
}
