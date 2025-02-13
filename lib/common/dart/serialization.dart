abstract base class MapSerializable {
  const MapSerializable();

  factory MapSerializable.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  Map<String, dynamic> toJson();
}
