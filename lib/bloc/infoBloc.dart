import 'package:rxdart/rxdart.dart';
import 'package:tf_concurrencia/bloc/infoprovider.dart';
import 'package:tf_concurrencia/model/createInfo.dart';
import 'package:tf_concurrencia/model/info.dart';

class InfoBloc {
  InfoProvider infoProvider = InfoProvider();

  final _infoController = BehaviorSubject<List<Info>>();

  Stream<List<Info>> get infoStream => _infoController.stream;
  Function(List<Info>) get changeInfos =>
      _infoController.sink.add; //faltaria modificar
  List<Info> get infos => _infoController.value;

  void getInfos() async {
    var response = await infoProvider.getAllInfo();
    changeInfos(response);
  }

  Future<bool> createInfo(CreateInfo createInfo) async {
    var response = await infoProvider.createInfo(createInfo);
    if (response == true) {
      getInfos();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateInfo(CreateInfo createInfo, infoName) async {
    var response = await infoProvider.updateInfo(createInfo, infoName);
    if (response == true) {
      getInfos();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteInfo(infoName) async {
    var response = await infoProvider.deleteInfo(infoName);
    if (response == true) {
      getInfos();
      return true;
    } else {
      return false;
    }
  }
}
