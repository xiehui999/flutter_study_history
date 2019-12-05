//import 'lib/student/student.dart' show Student, Person;  导入 show显示， hide只隐藏

void main() {
  var str1 = "ok?";
  String str2 = "It's ok";
  var str3 = """Dart Lang
  Hello,World!""";
  print("Name：$str1");
  var hex = 0xDEADBEEF;
  print("hex:  ${hex.toRadixString(16).toUpperCase()}->${hex}");
//  const time = new DateTime.now(); //Error，new DateTime.now()不是const常量
  var sayHello = (name) => 'Hello $name!';
  var callbacks = [];
  for (var i = 0; i < 3; i++) {
    // 在列表 callbacks 中添加一个函数对象，这个函数会记住 for 循环中当前 i 的值。
    print('${i}');
    callbacks.add(() => print('Save $i'));
  }
  callbacks.forEach((c) => c());

  //命名可选参数使用大括号{}，默认值用冒号:
  //位置可选参数使用方括号[]，默认值用等号=

  FunX(a, {b, c: 3, d: 4, e}) {
    print('$a $b $c $d $e');
  }

  FunY(a, [b, c = 3, d = 4, e]) {
    print('$a $b $c $d $e');
  }

  FunX(1, b: 3, d: 5);
  FunY(1, 3, 5);

  //取整 ~/
  int a = 3;
  int b = 2;
  print(a ~/ b); //输出1
  print(a / b); //输出1.5
  //级联操作符 ...
  Person p = new Person();

  p
    ..name = 'Coder'
    ..setCountry('China');
  print(p);
//if 语句在checked模式下，如果是非bool值会抛出异常
//  if (1) {
//    print('JavaScript is ok.');
//  } else {
//    print('Dart in production mode is ok.');
//  }

  var collection = [0, 1, 2];

  collection.forEach((x) => print(x)); //forEach的参数为Function
  for (var x in collection) {
    print(x);
  }
  // swith的参数可以是num，或者String
  var point = new Point(1, 2, 3);
  print(point);

  var logger = new Logger("UI");
  var logger2 = new Logger("UI2");
  logger.log("测试");
  logger2.log("测试");

  StringBuffer sb = new StringBuffer();
  sb.write("test");
  sb.write("test1");
  sb.write([1, 2, 34, 4]);
  print(sb.toString());

  var vegetables = new List();
  vegetables.add(1);
  vegetables.add(2);
  vegetables.add("test");
  vegetables.removeAt(vegetables.indexOf("test"));
  vegetables.remove(1);
  print(vegetables);
  var set = new Set();
  set.addAll(["1", "2", "3"]);
  print(set.containsAll(["1", "2"])); //TRUE

  // 获取两个集合的交集
  var nobleGases = new Set.from(['2', '1', "4"]);
  var intersection = set.intersection(nobleGases);
  print(intersection);
}

class Person {
  String name;
  String country;

  void setCountry(String country) {
    this.country = country;
  }

  String toString() => 'Name:$name\nCountry:$country';
}

class Point {
  num x;
  num y;
  num z;

  Point(this.x, this.y, z) {
    //第一个值传递给this.x，第二个值传递给this.y
    this.z = z;
  }

  num get sum => x + y + z;

  Point.fromeList(var list)
      : //命名构造函数，格式为Class.name(var param)
        x = list[0],
        y = list[1],
        z = list[2] {
    //使用冒号初始化变量
  }

  //当然，上面句你也可以简写为：
  //Point.fromeList(var list):this(list[0], list[1], list[2]);

  String toString() => 'x:$x  y:$y  z:$z';
}

class Logger {
  final String name;
  bool mute = false;
  static final Map<String, Logger> _cache = <String, Logger>{};

  Logger._internal(this.name);

  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      final logger = new Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  void log(String msg) {
    if (!mute) {
      print("${this.name}->${msg}");
    }
  }
}
