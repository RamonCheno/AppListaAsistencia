import 'package:dio/dio.dart';
import 'package:lista_asistencia_actualizado/api/peticiones_http.dart';
import 'package:lista_asistencia_actualizado/index/index.function.dart';

class GroupController {
  Dio dio = Dio();

  Future<bool> addGroup(GroupModel groupModel) async {
    final groupMap = groupModel.toMap();
    final response =
        await PeticionesHttp.httpPost("/groups/register/", groupMap);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<GroupModel>> getGroups(int idUser) async {
    final response =
        await PeticionesHttp.httpGet("/groups/listar?idUser=$idUser");
    List<GroupModel> groupList = [];
    for (var item in response.data) {
      GroupModel groupModel = GroupModel.fromMap(item);
      groupList.add(groupModel);
    }
    return groupList;
  }

  Future<GroupModel> getGroup(int id) async {
    final response = await PeticionesHttp.httpGet("groups/obtener?groupId=$id");
    GroupModel groupModel = response.data;
    return groupModel;
  }
}
