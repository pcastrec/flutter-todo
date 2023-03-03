enum Cat { course, sport, travel }

abstract class Task {
  String name = "";
  bool done = false;
  Cat category;

  Task(this.name, this.category);

  @override
  String toString() {
    return "{name: $name, category: $category}";
  }
}

class Course extends Task {
  Course(String name) : super(name, Cat.course);
}

class Sport extends Task {
  Sport(String name) : super(name, Cat.sport);
}

class Travel extends Task {
  Travel(String name) : super(name, Cat.travel);
}
