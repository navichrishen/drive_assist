class Vehicle {
  String? id;
  final String vehicleBrand;
  final String vehicleManufactureYear;
  final String vehicleModel;

  Vehicle({
    this.id,
    required this.vehicleBrand,
    required this.vehicleManufactureYear,
    required this.vehicleModel,
  });

  factory Vehicle.fromJson(String id, Map<String, dynamic> json) {
    return Vehicle(
      id: id,
      vehicleBrand: json['vehicleBrand'] ?? '',
      vehicleManufactureYear: json['vehicleManufactureYear'] ?? '',
      vehicleModel: json['vehicleModel'] ?? '',
    );
  }
}
