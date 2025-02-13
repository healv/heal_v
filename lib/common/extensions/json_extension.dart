extension JsonExtension on Object? {
  Map<String, Object?>? get asJsonObject => switch (this) { Map<String, Object?> object? => object, _ => null };

  String? get asJsonString => switch (this) { String object? => object, _ => null };
}
