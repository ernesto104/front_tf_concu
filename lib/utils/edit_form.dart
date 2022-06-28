import 'package:flutter/material.dart';
import 'package:tf_concurrencia/bloc/infoBloc.dart';
import 'package:tf_concurrencia/model/createInfo.dart';

class EditForm extends StatefulWidget {
  final InfoBloc infoBloc;
  final String name;
  EditForm({Key? key, required this.infoBloc, required this.name})
      : super(key: key);

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  var lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var options = ['A', 'B', 'C'];
  String? _currentValue = 'A';

  saveEditForm() {
    var createInfo = CreateInfo();
    createInfo.nombre = widget.name;
    createInfo.apellido = lastNameController.text;
    createInfo.opcion = _currentValue!;

    Navigator.pop(context);
    widget.infoBloc.updateInfo(createInfo, widget.name).then((value) {
      if (value) {
        print('Se actualizó la info');
      } else {
        print('Error en el server');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(widget.name),
        content: SizedBox(
          height: 250,
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Apellido: '),
                      Container(
                        height: 47,
                        width: 150,
                        child: TextFormField(
                            controller: lastNameController,
                            style: const TextStyle(fontSize: 15),
                            decoration: const InputDecoration(
                              hintText: 'Apellido',
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Rellene este campo"; //validacion en caso no se ingrese nada desde el principio
                              }
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text('Opción: '),
                      const SizedBox(
                        width: 20,
                      ),
                      DropdownButton(
                          value: _currentValue,
                          items: options.map((String item) {
                            return DropdownMenuItem(
                                child: Text(item), value: item);
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _currentValue = value.toString();
                            });
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          saveEditForm();
                        }
                      },
                      child: const Text("Actualizar info"))
                ],
              )),
        ));
  }
}
