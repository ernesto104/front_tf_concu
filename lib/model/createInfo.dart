class CreateInfo {
  String nombre = '';
  String apellido = '';
  String opcion = '';

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "opcion": opcion,
        "metodo": "POST"
      };

  Map<String, dynamic> toUpdateJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "opcion": opcion,
        "metodo": "PUT"
      };

  Map<String, dynamic> toDeleteJson(nombre) => {
        "nombre": nombre,
        "apellido": "unknown",
        "opcion": "unknown",
        "metodo": "DELETE"
      };
}
