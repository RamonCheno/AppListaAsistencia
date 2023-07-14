import 'package:dio/dio.dart';
import 'package:lista_asistencia_actualizado/api/peticiones_http.dart';
import 'package:lista_asistencia_actualizado/index/index.package.dart';
import 'package:lista_asistencia_actualizado/model/student_group.model.dart';

class GroupStudentController {
  Dio dio = Dio();
  Future addStudentGroup(StudentGroupModel studentGroupModel) async {
    // const path = "http://192.168.1.106/groups/registrar/student/";
    final studentGroupMap = studentGroupModel.toMap();
    final response = await PeticionesHttp.httpPost(
        "/groups/registrar/student/", studentGroupMap);
    if (response.statusCode == 200) {
      debugPrint("Success");
    } else {
      debugPrint("error");
    }
  }
}
