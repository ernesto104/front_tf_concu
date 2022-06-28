import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tf_concurrencia/bloc/infoBloc.dart';
import 'package:tf_concurrencia/model/createInfo.dart';
import 'package:tf_concurrencia/model/info.dart';
import 'package:tf_concurrencia/utils/edit_form.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var options = ['A', 'B', 'C'];
  String? _currentValue = 'A';

  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var lastNameController = TextEditingController();

  List<Info> infos = [
    Info(nombre: "nombre", apellido: "apellido", opcion: "opcion"),
    Info(nombre: "nombre1", apellido: "apellido2", opcion: "opcion2")
  ];

  var infoBloc = InfoBloc();

  saveForm() {
    var createInfo = CreateInfo();
    createInfo.nombre = nameController.text;
    createInfo.apellido = lastNameController.text;
    createInfo.opcion = _currentValue!;

    infoBloc.createInfo(createInfo).then((value) {
      if (value) {
        print('Se creo la info');
      } else {
        print('Error en el server');
      }
    });
  }

  deleteInfo(infoName) {
    infoBloc.deleteInfo(infoName).then((value) {
      if (value) {
        print('Se eliminó la info');
      } else {
        print('Error en el server');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    infoBloc.getInfos();

    return Scaffold(
        appBar: AppBar(
          title: const Text('TF Concurrencia'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Nombre: '),
                              Container(
                                height: 48,
                                width: 150,
                                child: TextFormField(
                                    controller: nameController,
                                    style: const TextStyle(fontSize: 15),
                                    decoration: const InputDecoration(
                                      hintText: 'Nombre',
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
                            height: 20,
                          ),
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
                                  saveForm();
                                }
                              },
                              child: const Text("Crear info"))
                        ],
                      )),
                  StreamBuilder(
                      stream: infoBloc.infoStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          infos = snapshot.data as List<Info>;
                          return infos.isNotEmpty
                              ? ListView.builder(
                                  itemCount: infos.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return SingleInfo(infos[index]);
                                  })
                              : Container();
                        } else {
                          return const SizedBox(
                              width: 400,
                              height: 550,
                              child: Center(
                                child: CircularProgressIndicator.adaptive(),
                              ));
                        }
                      }),
                ],
              )
            ],
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  ListTile SingleInfo(data) {
    return ListTile(
      title: Text('${data.nombre}  ${data.apellido}'),
      subtitle: Text('Opcion ${data.opcion}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return EditForm(infoBloc: infoBloc, name: data.nombre);
                    });
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                deleteInfo(data.nombre);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
    );
  }
}
