import 'package:flutter/material.dart';
import 'package:fluttersandblock/pages/character_detail.dart';
import '../APi/datapost.dart';
import 'dart:convert';
import '../model/character_model.dart';

class CharacterList extends StatefulWidget {
  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  late Future<List<Character>> _characters;
  void initState() {
    super.initState();
    _characters = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Image.network(
          'https://sw6.elbenwald.de/media/cb/af/55/1699141798/E1078672_3.jpg',
          height: 200,
          fit: BoxFit.contain,
        ),
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Character>>(
        future: _characters,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final chracterss = snapshot.data!;
            return ListView.builder(
              itemCount: chracterss.length,
              itemBuilder: (context, index) {
                final c = chracterss[index];
                return ListTile(
                  hoverColor: Colors.greenAccent,
                  onTap:
                      () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CharacterDetail(c: c),
                          ),
                        ),
                      },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(c.image),
                    minRadius: 25,
                    maxRadius: 35,
                  ),
                  title: Text(c.name, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 4, 227, 168))),
                  subtitle: Text('${c.status} • ${c.species} • ${c.gender}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
