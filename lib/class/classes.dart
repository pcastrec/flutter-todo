enum THEME { course, sport, travel }

abstract class Task {
  String name = "";
  THEME theme;

  Task(this.name, this.theme);

  @override
  String toString() {
    return "{name: $name, theme: $theme}";
  }
}

class Course extends Task {
  Course(String name) : super(name, THEME.course);
}

class Sport extends Task {
  Sport(String name) : super(name, THEME.sport);
}

class Travel extends Task {
  Travel(String name) : super(name, THEME.travel);
}
