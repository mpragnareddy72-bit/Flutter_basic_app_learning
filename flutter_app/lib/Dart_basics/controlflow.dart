import 'dart:io';

void main(){
  print("hello world");

  // dtattype variablename = value;
  //datatype can be int, double string
  int a = 5;
  int b = 6;
  print(a+b);
  print(a.abs());
  print(a.abs);
  print(b.oneBitCount);

print("\n");
  //boolean variable name = false/true
  bool firstvalue = true;
  print(firstvalue);

  //strings
  print("\n");
  String name = "mosra pragna";
  print(name);
   name = '${name} reddy';
  print(name);
  String name1 = '${name} reddy';
  print(name1);
  print(name1.runtimeType);

  final value1 = DateTime.now();
  //const value2 = DateTime.now();

  print(value1);
  //print(value2);

  // null values
  String? somevalue;
  print(somevalue);

  //value4 = null;
  //print(value4?.length);
  //print(value4?.length??0);
  int value5 = 20;
  if (value5 >18){
    print("age gretaer than 18 that is $value5");
  }
  else if(value5<18){
    print("not eligible for vote");

  }
  else{
    print("age is exactly equal to 18");
  }

  //taking input from the keyboard
  print("enter your name: ");
  String?  names = stdin.readLineSync();
  print("hello $names");
}