class Info {
  String nombre = '';
  String apellido = '';
  String opcion = '';

  Info({required this.nombre, required this.apellido, required this.opcion});

  factory Info.fromJson(Map<String, dynamic> infoJson) {
    return Info(
        nombre: infoJson['nombre'],
        apellido: infoJson['apellido'],
        opcion: infoJson['opcion']);
  }
}
