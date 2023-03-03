import 'package:flutter/material.dart';
import 'package:todo/class/classes.dart';
import 'package:todo/widget/dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Todo List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _tasks.add(Sport('Basket'));
      _tasks.add(Sport('Baseball'));

      _tasks.add(Travel('Russie'));
      _tasks.add(Travel('Italy'));
      _tasks.add(Travel('Hongrie'));
      _tasks.add(Travel('Angleterre'));
    });
  }

  void _onPress({Task? task}) async {
    Task? nTask = await showDialog(
        context: context, builder: (_) => DialogBox(task: task));
    if (nTask != null) {
      setState(() {
        if (task == null) {
          _tasks.add(nTask);
        } else {
          task.name = nTask.name;
          task.category = nTask.category;
        }
      });
    }
  }

  void _onDelete(Task task) {
    setState(() {
      _tasks.remove(task);
    });
  }

  List<Widget> renderList() {
    List<ExpansionTile> listes = [];

    for (Cat category in Cat.values) {
      List<ListTile> tiles = [];
      List<Task> list =
          _tasks.where((element) => element.category == category).toList();
      if (list.isNotEmpty) {
        for (Task task in list) {
          tiles.add(ListTile(
            title: Text(task.name),
            trailing: Wrap(
              children: [
                IconButton(
                  onPressed: () => _onPress(task: task),
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () => _onDelete(task),
                  icon: const Icon(Icons.delete_outline_outlined),
                ),
              ],
            ),
            leading: Checkbox(
              value: task.done,
              onChanged: (value) => setState(() {
                task.done = value!;
              }),
            ),
          ));
        }
      } else {
        tiles.add(const ListTile(
          title: Text('Nothing'),
        ));
      }
      listes.add(ExpansionTile(
        title: Text(
          category.name.toUpperCase(),
          textAlign: TextAlign.center,
        ),
        children: tiles,
      ));
    }

    return listes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(32),
          children: renderList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPress,
        child: const Icon(Icons.add),
      ),
    );
  }
}
