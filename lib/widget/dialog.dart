import 'package:flutter/material.dart';
import 'package:todo/class/classes.dart';

class DialogBox extends StatefulWidget {
  final Task? task;

  const DialogBox({super.key, this.task});

  @override
  State<StatefulWidget> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final TextEditingController formCtrl = TextEditingController();
  final List<DropdownMenuItem> items = [];
  Cat? selected;

  @override
  void initState() {
    super.initState();
    formCtrl.text = widget.task?.name ?? '';
    selected = widget.task?.category;
    items.addAll(
      List.generate(
        Cat.values.length,
        (index) => DropdownMenuItem(
          value: Cat.values[index],
          child: Text(Cat.values[index].name),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (form.currentState!.validate()) {
      Task? _task = widget.task;
      switch (selected!) {
        case Cat.course:
          _task = Course(formCtrl.text);
          break;
        case Cat.sport:
          _task = Sport(formCtrl.text);
          break;
        case Cat.travel:
          _task = Travel(formCtrl.text);
          break;
      }
      Navigator.pop(context, _task);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Success !')));
    }
  }

  void _onCancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Task'),
      content: Form(
        key: form,
        child: Wrap(
          children: [
            TextFormField(
              // initialValue: widget.task?.name,
              controller: formCtrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter something';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Task name',
                hintText: 'Enter task name',
              ),
            ),
            DropdownButtonFormField(
              items: items,
              value: widget.task?.category,
              validator: (value) => null,
              onChanged: (value) => selected = value,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _onCancel,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _onSubmit,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
