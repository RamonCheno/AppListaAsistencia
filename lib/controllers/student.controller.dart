import 'package:dio/dio.dart';
import 'package:lista_asistencia_actualizado/api/peticiones_http.dart';
import 'package:lista_asistencia_actualizado/controllers/group_student.controller.dart';
import 'package:lista_asistencia_actualizado/index/index.function.dart';
import 'package:lista_asistencia_actualizado/index/index.package.dart';
import 'package:lista_asistencia_actualizado/model/student_group.model.dart';

class StudentController {
  Dio dio = Dio();
  Future<List<StudentModel>> getStudentsByGroup(int idGroup) async {
    final Response response =
        await PeticionesHttp.httpGet("/students/listar?groupId=$idGroup");
    List<StudentModel> studentList = [];
    for (var item in response.data) {
      StudentModel studentModel = StudentModel.fromMap(item);
      studentList.add(studentModel);
    }
    return studentList;
  }

  // Pendiente en implementar
  Future getStudentByMatricula(String matricula) async {
    final Response response =
        await PeticionesHttp.httpGet("/students/obtener?matricula=$matricula");
    if (response.statusCode == 200) {
      debugPrint("${response.data}");
      debugPrint("${response.statusCode}");
      return true;
    } else if (response.statusCode == 404) {
      debugPrint("${response.data}");
      debugPrint("${response.statusCode}");
      return false;
    } else {
      // La solicitud no fue exitosa
      debugPrint(
          'Error al verificar la existencia del alumno. Código de estado: ${response.statusCode}');
      return false;
    }
  }

  Future<bool> addStudent(StudentModel studentM, int idGroup) async {
    GroupStudentController groupStudentController = GroupStudentController();
    try {
      final studentMap = studentM.toMap();
      final matricula = studentMap["matricula"];
      final existe = await getStudentByMatricula(matricula);
      if (!existe) {
        Response response =
            await PeticionesHttp.httpPost("/students/registrar/", studentMap);
        await groupStudentController.addStudentGroup(
            StudentGroupModel(fkAlumno: studentM.matricula, fkGrupo: idGroup));
        debugPrint("$response.statusCode");
        return true;
      } else {
        await groupStudentController.addStudentGroup(
            StudentGroupModel(fkAlumno: studentM.matricula, fkGrupo: idGroup));
        return true;
      }
      // else {
      //   await groupStudentController.addStudentGroup(
      //       StudentGroupModel(fkAlumno: studentM.matricula, fkGrupo: idGroup));
      // }
    } catch (error) {
      debugPrint("$error");
      return false;
    }
  }
}
