import 'package:btk_flutter_egitimi/models/student.dart';
import 'package:btk_flutter_egitimi/screens/student_add.dart';
import 'package:btk_flutter_egitimi/screens/student_edit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Salih()));
}

class Salih extends StatefulWidget {
  @override
  _SalihState createState() => _SalihState();
}

class _SalihState extends State<Salih> {
  var mesaj = "Öğrenci Takip Sistemi";

  Student selectedStudent = Student.withID(0, "", "", 0);
//ilk başta boş değerler göndermediğinde hata veriyor.
  List<Student> students = [
    Student.withID(1, "Salih", "Öztürk", 99),
    Student.withID(2, "Nafiye", "Ateş", 100),
    Student.withID(3, "Olcay", "Esir", 40),
    Student.withID(4, "Anıl", "Doğan", 30)
  ];

  // var ogrenciler = ["Salih Öztürk", "Nafiye Ateş", "Olcay Esir"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mesaj),
      ),
      body: buildBody(context),
    );
  }

/*   String sinavHesapla(int puan) {
    String mesaj = "";
    if (puan >= 50) {
      mesaj = "Geçti";
    } else if (puan >= 40) {
      mesaj = "Bütünlemeye Kaldi";
    } else {
      mesaj = "Kaldi";
    }
    return mesaj;
  } */

  void mesajGoster(BuildContext context, String mesaj) {
    var alert = AlertDialog(
      title: Text("ÖĞRENCİ GEÇME DURUMU"),
      content: Text(mesaj),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            alert); //context bu şekilde hata vereceği için Kendi widgte imizi oluşturuyoruz
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          //Liste ekrana sığması ve gözükmesi için Expanded çok önemli
          child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://cdn.pixabay.com/photo/2015/09/06/14/59/books-927394_960_720.jpg"),
                  ),
                  title: Text(students[index].firstName +
                      " " +
                      students[index].lastName),
                  subtitle: Text("Sınavdan Aldığı Not:" +
                      students[index].grade.toString() +
                      "[" +
                      students[index].getStatus +
                      "]"),
                  trailing: buildStatusIcon(students[index]
                      .grade), //Trailing en sağ tarafa icon koyarken LEADİNG en SOLA
                  onTap: () {
                    setState(() {
                      selectedStudent = students[index];
                      /*     seciliOgrenci = students[index].firstName +
                          " " +
                          students[index].lastName; */
                    });

                    print(selectedStudent.firstName);
                  },
                );
              }),
          /*   child: ListView(//Statik olarak eklendi
              children: <Widget>[
                Text("Salih Öztürk"),
                Text("Nafiye Ateş"),
                Text("Olcay Esir"),
              ],
            ), */
        ),
        Text("Seçili Öğrenci: " + selectedStudent.firstName),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                color: Colors.greenAccent,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Yeni Öğrenci"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentAdd(students)));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                color: Colors.amberAccent,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.update),
                    SizedBox(
                      width:
                          5.0, //Icon ile güncelle yazısı arasında 5lik boşluk yaptım.
                    ),
                    Text("Güncelle"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentEdit(selectedStudent)));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1, //herkese ekranda 1 pay verdim
              child: RaisedButton(
                color: Colors.redAccent,
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Sil"),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    students.remove(selectedStudent);
                  });
//SET STATE diyerek o alanı kullanan bir yer varsa onu yeniden ekrana çiz demek
                  var mesaj = "Silindi " + selectedStudent.firstName;
                  mesajGoster(context, mesaj);
                },
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if (grade > 70) {
      return Icon(Icons.done);
    } else if (grade >= 50) {
      return Icon(Icons.album);
    } else {
      return Icon(Icons.clear);
    }
  }
}
