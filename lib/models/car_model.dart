class CarModel {
  String? ownerName;
  String? vehicleName;
  String? vehicleColor;
  String? image;
  String? email;
  String? id;
  CarModel(
      {this.ownerName,
      this.vehicleName,
      this.vehicleColor,
      this.image,
      this.id,
      this.email});

  CarModel.fromJson(Map<String, dynamic> json) {
    ownerName = json['ownerName'];
    vehicleName = json['vehicleName'];
    vehicleColor = json['vehicleColor'];
    image = json['image'];
    email = json['email'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ownerName'] = this.ownerName;
    data['vehicleName'] = this.vehicleName;
    data['vehicleColor'] = this.vehicleColor;
    data['image'] = this.image;
    data['email'] = this.email;
    data['id'] = this.id;
    return data;
  }
}
