import 'package:flutter/material.dart';

void main() {
  runApp(const VegiesApp());
}

class VegiesApp extends StatelessWidget {
  const VegiesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vegies List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: const Vegies(),
    );
  }
}

class Vegies extends StatelessWidget {
  const Vegies({super.key});

  final List<Map<String, String>> contacts = const [
    {
      "name": "Tindola",
      "image": "assets/images/vegimg.jpg",
    },
    {
      "name": "Bataka",
      "image": "assets/images/vegimg.jpg",
    },
    {
      "name": "Cobiz",
      "image": "assets/images/vegimg.jpg",
    },
    {
      "name": "Ringan",
      "image": "assets/images/vegimg.jpg",
    },
    {
      "name": "Bhinda",
      "image": "assets/images/vegimg.jpg",
    },
    {
      "name": "Karela",
      "image": "assets/images/vegimg.jpg",
    },
    {
      "name": "Tameta",
      "image": "assets/images/vegimg.jpg",
    },
    {
      "name": "Methi",
      "image": "assets/images/vegimg.jpg",
    },
    {
      "name": "Galka",
      "image": "assets/images/vegimg.jpg",
    },
    {
      "name": "Turiya",
      "image": "assets/images/vegimg.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vegies'),
        backgroundColor: const Color.fromARGB(255, 161, 80, 9),
      ),
      body: ListView.separated(
        itemCount: contacts.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(contact["image"]!),
              radius: 25,
            ),
            title: Text(contact["name"]!),
          );
        },
      ),
    );
  }
}
