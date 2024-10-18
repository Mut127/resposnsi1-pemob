import 'package:flutter/material.dart';
import 'package:responsi1_muthiakhanza_c/bloc/genre_bloc.dart';
import 'package:responsi1_muthiakhanza_c/model/genre.dart';
import 'package:responsi1_muthiakhanza_c/ui/genre_form.dart';
import 'package:responsi1_muthiakhanza_c/ui/genre_page.dart';
import 'package:responsi1_muthiakhanza_c/widget/warning_dialog.dart';

// ignore: must_be_immutable
class GenreDetail extends StatefulWidget {
  Genre? genre;
  GenreDetail({Key? key, this.genre}) : super(key: key);
  @override
  _GenreDetailState createState() => _GenreDetailState();
}

class _GenreDetailState extends State<GenreDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Genre',
          style: TextStyle(
            fontFamily: 'Comic Sans MS', // Menggunakan Comic Sans
          ),
        ),
        backgroundColor: Colors.orange, // Warna oranye untuk AppBar
      ),
      body: Container(
        color: Colors.yellow, // Latar belakang kuning
        padding: const EdgeInsets.all(16.0),
        child: Center(
          // Menengahkan kolom
          child: SizedBox(
            width: double.infinity, // Lebar sesuai halaman
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Menengahkan kolom secara vertikal
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Menengahkan kolom secara horizontal
              children: [
                _detailText("Judul", widget.genre!.bookTitle!),
                _detailText("Genre", widget.genre!.bookGenre!),
                _detailText("Cover Type", widget.genre!.coverType!),
                const SizedBox(height: 20),
                _tombolHapusEdit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        "$label : $value",
        style: const TextStyle(
          fontSize: 18.0,
          fontFamily: 'Comic Sans MS', // Menggunakan font Comic Sans
          color: Colors.black, // Teks warna hitam
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Menengahkan tombol
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent, // Warna oranye terang
            foregroundColor: Colors.black, // Warna teks hitam
          ),
          child: const Text(
            "EDIT",
            style: TextStyle(fontFamily: 'Comic Sans MS'), // Font Comic Sans
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GenreForm(genre: widget.genre!),
              ),
            );
          },
        ),
        const SizedBox(width: 10),
        // Tombol Hapus
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent, // Warna oranye terang
            foregroundColor: Colors.black, // Warna teks hitam
          ),
          child: const Text(
            "DELETE",
            style: TextStyle(fontFamily: 'Comic Sans MS'), // Font Comic Sans
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.yellowAccent, // Latar belakang kuning terang
      content: const Text(
        "Yakin ingin menghapus data ini?",
        style: TextStyle(
          fontFamily: 'Comic Sans MS', // Menggunakan font Comic Sans
        ),
      ),
      actions: [
        // Tombol Ya
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            GenreBloc.deleteGenre(id: (widget.genre!.id!)).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const GenrePage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
        // Tombol Batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
