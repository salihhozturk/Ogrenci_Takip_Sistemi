import 'package:btk_flutter_egitimi/models/student.dart';
import 'package:btk_flutter_egitimi/validation/student_validator.dart';
import 'package:flutter/material.dart';

class StudentAdd extends StatefulWidget {
  List<Student> students;
  StudentAdd(List<Student> students) {
    this.students = students;
  }
  @override //üzerine yazmak
  State<StatefulWidget> createState() {
    return _StudentAddState(students);
  }
}

class _StudentAddState extends State with StudentValidationMixin {
  List<Student> students;
  //hem state hemde studentMixin den miras aldık
  var student = Student.withoutInfo();
  var formKey = GlobalKey<
      FormState>(); //alanlar kaydolması için forma ulaşmam lazımdı onun için de bu komutu yazdım

  _StudentAddState(List<Student> students) {
    this.students = students;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Yeni Öğrenci Ekle"),
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                buildFirstNameField(),
                buildLastNameField(),
                buildGradeField(),
                buildSubmitButton(),
              ],
            ),
          ),
        ));
  }

  Widget buildFirstNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Adı", hintText: "Salih"),
      validator: validateFirstName,
      onSaved: (String value) {
        student.firstName = value;
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: "Öğrenci SoyAdı", hintText: "Öztürk"),
      validator: validateLastName,
      onSaved: (String value) {
        student.lastName = value;
      },
    );
  }

  Widget buildGradeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Aldığı  Not", hintText: "65"),
      validator: validateGrade,
      onSaved: (String value) {
        student.grade = int.parse(value);
      },
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          //validate et yani doğrula doğruysa true döner ve kaydet diyoruz {
          formKey.currentState
              .save(); //ilgili alanların ONSAVE ini çalıştırıyor.
          students.add(student);
          saveStudent();
          Navigator.pop(context);
        }
      },
    );
  }

  void saveStudent() {
    print(student.firstName);
    print(student.lastName);
    print(student.grade);
  }
}
