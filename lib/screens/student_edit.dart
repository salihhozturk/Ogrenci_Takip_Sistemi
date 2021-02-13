import 'package:btk_flutter_egitimi/models/student.dart';
import 'package:btk_flutter_egitimi/validation/student_validator.dart';
import 'package:flutter/material.dart';

class StudentEdit extends StatefulWidget {
  Student
      selectedStudent; //Tek bir öğrenci gönderdiğimiz için güncelleme kısmında liste yerine tek bir student yaptım
  StudentEdit(Student selectedStudent) {
    this.selectedStudent = selectedStudent;
  }
  @override //üzerine yazmak
  State<StatefulWidget> createState() {
    return _StudentAddState(selectedStudent);
  }
}

class _StudentAddState extends State with StudentValidationMixin {
  Student selectedStudent;
  //hem state hemde studentMixin den miras aldık

  var formKey = GlobalKey<
      FormState>(); //alanlar kaydolması için forma ulaşmam lazımdı onun için de bu komutu yazdım

  _StudentAddState(Student selectedStudent) {
    this.selectedStudent = selectedStudent;
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
      initialValue: selectedStudent.firstName,
      decoration: InputDecoration(labelText: "Öğrenci Adı", hintText: "Salih"),
      validator: validateFirstName,
      onSaved: (String value) {
        selectedStudent.firstName = value;
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      initialValue: selectedStudent.lastName,
      decoration:
          InputDecoration(labelText: "Öğrenci SoyAdı", hintText: "Öztürk"),
      validator: validateLastName,
      onSaved: (String value) {
        selectedStudent.lastName = value;
      },
    );
  }

  Widget buildGradeField() {
    return TextFormField(
      initialValue: selectedStudent.grade.toString(),
      decoration: InputDecoration(labelText: "Aldığı  Not", hintText: "65"),
      validator: validateGrade,
      onSaved: (String value) {
        selectedStudent.grade = int.parse(value);
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
          saveStudent();
          Navigator.pop(context);
        }
      },
    );
  }

  void saveStudent() {
    print(selectedStudent.firstName);
    print(selectedStudent.lastName);
    print(selectedStudent.grade);
  }
}
