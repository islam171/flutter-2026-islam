void hello1() {

  final teacher = Major(title: "teacher");

  final Islam = Human(name: 'Islam', age: 21, height: 190);
  final Baha = Student(name: "Baha",
      age: 22,
      height: 180,
      major: teacher,
      year_course: 3);

  final islam2 =  Islam.copyWith(name: "Islam2");
  Baha.playBasketBall();

}



class Human {
  Human({required this.name, required this.age, required this.height}) {
    count++;
  }

  final String name;
  int age;
  double height;

  static int count = 0;

  String toString() {
    return 'Name: $name, age: $age, height: $height';
  }

  void grewUp() {
    this.age++;
  }


  Human copyWith({String? name, int? age, double? height}){
    return Human(name: name ?? this.name, age: age ?? this.age, height: height ?? this.height);
  }
}

class Major {
  Major({required this.title});

  final String title;
  String? desc;

  String toString() {
    return this.title;
  }
}

class Student extends Human with BasketBallPlayer {
  Student({
    required super.name,
    required super.height,
    required super.age,
    required this.major,
    required this.year_course,
  });

  final Major major;
  int year_course;

  @override
  String toString() {
    return super.toString() + ', major: $major, year: $year_course';
  }
}

extension on Student{
  void sayHello(){
    print('hello');
  }
}

mixin BasketBallPlayer{
  void playBasketBall(){
    print("play Basket");
  }
}

mixin FootBallPLayer{
  void playFootBall(){
    print("play FootBall");
  }
}