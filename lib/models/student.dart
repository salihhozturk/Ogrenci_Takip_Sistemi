class Student {
  int id;
  String firstName;
  String lastName;
  String _status;
  int grade;
  Student.withID(int id, String firstName, String lastName, int grade) {
    //güncelleme ve silme için bu yapıcıyı kullanıcam
    //Yapıcı Consturctor yapıyorum
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.grade = grade;
  }
  //DEFAULT YAPICI İD SİZ OLAN YANİ BU AŞAĞIDAKİ ekleme işlemi yaparken bu constructor kullanıcam
  Student(String firstName, String lastName, int grade) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.grade = grade;
  }
  Student.withoutInfo() {}
  String get getStatus {
    String message = "";
    if (this.grade >= 50) {
      message = "Geçti";
    } else if (this.grade >= 40) {
      message = "Bütünlemeye Kaldi";
    } else {
      message = "Kaldi";
    }
    return message;
  }
}
