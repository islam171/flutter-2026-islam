import 'package:flutter/cupertino.dart';

void hello1() {

  final teacher = Major(title: "teacher");

  final islam = Human(name: 'Islam', age: 21, height: 190);
  final baha = Student(name: "Baha",
      age: 22,
      height: 180,
      major: teacher,
      yearCourse: 3);

  final islam2 =  islam.copyWith(name: "Islam2");
  baha.playBasketBall();
  islam2.grewUp();
  baha.sayHello();
  baha.playBasketBall();
  baha.playFootBall();

}



class Human {
  Human({required this.name, required this.age, required this.height}) {
    count++;
  }

  final String name;
  int age;
  double height;

  static int count = 0;

  @override
  String toString() {
    return 'Name: $name, age: $age, height: $height';
  }

  void grewUp() {
    age++;
  }


  Human copyWith({String? name, int? age, double? height}){
    return Human(name: name ?? this.name, age: age ?? this.age, height: height ?? this.height);
  }
}

class Major {
  Major({required this.title});

  final String title;
  String? desc;

  @override
  String toString() {
    return title;
  }
}

class Student extends Human with BasketBallPlayer, FootBallPLayer {
  Student({
    required super.name,
    required super.height,
    required super.age,
    required this.major,
    required this.yearCourse,
  });

  final Major major;
  int yearCourse;

  @override
  String toString() {
    return  '${super.toString()}, major: $major, year: $yearCourse';
  }
}

extension on Student{
  String sayHello(){
    return "hello";
  }
}

mixin BasketBallPlayer{
  void playBasketBall(){
    debugPrint("play Basket");
  }
}

mixin FootBallPLayer{
  void playFootBall(){
    debugPrint("play FootBall");
  }
}