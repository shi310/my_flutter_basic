class MyDeviceInfoModel {
  String brand;
  String model;
  String systemVersion;
  String id;

  MyDeviceInfoModel({
    required this.model,
    required this.id,
    required this.brand,
    required this.systemVersion,
  });
  
  factory MyDeviceInfoModel.fromJson(Map<String, dynamic> json) => MyDeviceInfoModel(
    model: json["model"] ?? '',
    id: json["id"] ?? '',
    brand: json["brand"] ?? '',
    systemVersion: json["systemVersion"] ?? '',
  );

  factory MyDeviceInfoModel.empty() => MyDeviceInfoModel(
    model: '',
    id: '',
    brand: '',
    systemVersion: '',
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "id": id,
    "brand": brand,
    "systemVersion": systemVersion,
  };
}