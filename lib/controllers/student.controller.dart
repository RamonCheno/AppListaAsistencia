import 'package:dio/dio.dart';
import 'package:lista_asistencia_actualizado/index/index.function.dart';

class StudentController {
  Future<List<StudentModel>> getStudent() async {
    final response = await Dio().get("http://127.0.0.1:8000/students/2");
    List<StudentModel> studentList = [];
    for (var item in response.data) {
      StudentModel studentModel = StudentModel.fromMap(item);
      studentList.add(studentModel);
    }
    return studentList;
  }
}
