import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TODO APP",
      home: MyTodoApp(), //Set MyTodoApp as Home Screen
    );
  }
}

class MyTodoApp extends StatefulWidget {
  const MyTodoApp({super.key});

  @override
  State<MyTodoApp> createState() => _MyTodoAppState();
}

class _MyTodoAppState extends State<MyTodoApp> {

  List<String> tasks = [];
  TextEditingController addController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo App"),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: addController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter task",
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: addTask,
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(tasks[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => removeTask(index), // ✅ Fixed
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void addTask(){
    if(addController.text.isNotEmpty){
      setState(() {
        tasks.add(addController.text);
        addController.clear();
      });
    }
  }

  void removeTask(int index){
    setState(() {
      tasks.removeAt(index);
    });
  }
}
