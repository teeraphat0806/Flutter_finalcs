import 'package:flutter/material.dart';
import '../model/character_model.dart';

class CharacterDetail extends StatefulWidget {
  final Character c;
  const CharacterDetail({super.key, required this.c});

  @override
  State<CharacterDetail> createState() => _CharacterDetailState();
}

class _CharacterDetailState extends State<CharacterDetail> {
  @override
  Widget build(BuildContext context) {
    final c = widget.c;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Text(
          c.name,
          style: const TextStyle(
            color: Color.fromARGB(255, 1, 231, 120),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ภาพ
            ClipRRect(
              borderRadius: const BorderRadius.only(),
              child: Image.network(
                c.image,
                width: double.infinity,
                height: 320,
                fit: BoxFit.cover,
              ),
            ),

            Transform.translate(
              offset: const Offset(0, -20), // ขยับขึ้น 40px
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.name,
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    infoRow("Species", c.species),
                    infoRow("Gender", c.gender),
                    infoRow("Status", c.status),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              fontSize: 20,
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.black87, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
