class UserAuth {
  String uid;
  String phone;
  String name;
  // String address;
  List favourites;
  Map<String, dynamic> cart;
  List orders;

  UserAuth({
    this.uid,
    this.phone,
    this.name,
    // this.address,
    this.favourites,
    this.cart,
    this.orders,
  });
}
