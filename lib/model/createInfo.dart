class CreateInfo {
  String nombre = '';
  String apellido = '';
  String opcion = '';

  Map<String, dynamic> toJson() =>
      {"nombre": nombre, "apellido": apellido, "opcion": opcion};
}
