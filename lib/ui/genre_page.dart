import 'package:flutter/material.dart';
import 'package:responsi1_muthiakhanza_c/bloc/logout_bloc.dart';
import 'package:responsi1_muthiakhanza_c/bloc/genre_bloc.dart';
import 'package:responsi1_muthiakhanza_c/model/genre.dart';
import 'package:responsi1_muthiakhanza_c/ui/login_page.dart';
import 'package:responsi1_muthiakhanza_c/ui/genre_detail.dart';
import 'package:responsi1_muthiakhanza_c/ui/genre_form.dart';

class GenrePage extends StatefulWidget {
  const GenrePage({Key? key}) : super(key: key);
  @override
  _GenrePageState createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Genre',
          style: TextStyle(
            fontFamily: 'Comic Sans MS', // Mengganti font menjadi Comic Sans
          ),
        ),
        backgroundColor: Colors.orange, // Mengubah warna AppBar menjadi oranye
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(
                Icons.add,
                size: 26.0,
                color: Colors.black,
              ),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GenreForm()));
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Logout',
                style:
                    TextStyle(color: Colors.black, fontFamily: 'Comic Sans MS'),
              ),
              trailing: const Icon(
                Icons.logout,
                color: Colors.orange,
              ),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: Container(
        color: Colors.yellow, // Mengubah latar belakang menjadi kuning
        child: FutureBuilder<List>(
          future: GenreBloc.getGenres(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListGenre(
                    list: snapshot.data,
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class ListGenre extends StatelessWidget {
  final List? list;
  const ListGenre({Key? key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemGenre(
            genre: list![i],
          );
        });
  }
}

class ItemGenre extends StatelessWidget {
  final Genre genre;
  const ItemGenre({Key? key, required this.genre}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GenreDetail(
                      genre: genre,
                    )));
      },
      child: Card(
        color: Colors.orange,
        child: ListTile(
          title: Text(
            genre.bookTitle!,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Comic Sans MS', // Mengganti font menjadi Comic Sans
            ),
          ),
          subtitle: Text(
            genre.bookGenre!,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Comic Sans MS',
            ),
          ),
          trailing: Text(
            genre.coverType!,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Comic Sans MS',
            ),
          ),
        ),
      ),
    );
  }
}
