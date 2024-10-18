import 'package:flutter/material.dart';
import 'package:responsi1_muthiakhanza_c/bloc/genre_bloc.dart';
import 'package:responsi1_muthiakhanza_c/model/genre.dart';
import 'package:responsi1_muthiakhanza_c/ui/genre_page.dart';
import 'package:responsi1_muthiakhanza_c/widget/warning_dialog.dart';

class GenreForm extends StatefulWidget {
  final Genre? genre;
  const GenreForm({Key? key, this.genre}) : super(key: key);

  @override
  _GenreFormState createState() => _GenreFormState();
}

class _GenreFormState extends State<GenreForm> {
  final _formKey = GlobalKey<FormState>();
  final _bookTitleController = TextEditingController();
  final _bookGenreController = TextEditingController();
  final _coverTypeController = TextEditingController();

  bool _isLoading = false;
  String _title = "Tambah Genre";
  String _submitButtonLabel = "Simpan";

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    if (widget.genre != null) {
      setState(() {
        _title = "Ubah Genre";
        _submitButtonLabel = "Ubah";
        _bookTitleController.text = widget.genre!.bookTitle!;
        _bookGenreController.text = widget.genre!.bookGenre!;
        _coverTypeController.text = widget.genre!.coverType!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: const TextStyle(fontFamily: 'Comic Sans MS'),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: Colors.yellow,
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: _bookTitleController,
                label: "Judul Buku",
                validator: (value) =>
                    value!.isEmpty ? "Judul buku harus diisi" : null,
              ),
              _buildTextField(
                controller: _bookGenreController,
                label: "Genre",
                validator: (value) =>
                    value!.isEmpty ? "Nama Genre harus diisi" : null,
              ),
              _buildTextField(
                controller: _coverTypeController,
                label: "Tipe Cover",
                validator: (value) =>
                    value!.isEmpty ? "Tipe Cover harus diisi" : null,
              ),
              const SizedBox(height: 20),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'Comic Sans MS',
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
      ),
      onPressed: _isLoading ? null : _onSubmit,
      child: Text(
        _submitButtonLabel,
        style: const TextStyle(fontFamily: 'Comic Sans MS'),
      ),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      if (widget.genre != null) {
        _updateGenre();
      } else {
        _saveGenre();
      }
    }
  }

  void _saveGenre() {
    final newGenre = Genre(
      id: null,
      bookTitle: _bookTitleController.text,
      bookGenre: _bookGenreController.text,
      coverType: _coverTypeController.text,
    );

    GenreBloc.addGenre(genre: newGenre).then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const GenrePage()),
      );
    }).catchError((_) {
      _showErrorDialog("Simpan gagal, silahkan coba lagi");
    }).whenComplete(() {
      setState(() => _isLoading = false);
    });
  }

  void _updateGenre() {
    final updatedGenre = Genre(
      id: widget.genre!.id!,
      bookTitle: _bookTitleController.text,
      bookGenre: _bookGenreController.text,
      coverType: _coverTypeController.text,
    );

    GenreBloc.updateGenre(genre: updatedGenre).then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const GenrePage()),
      );
    }).catchError((_) {
      _showErrorDialog("Permintaan ubah data gagal, silahkan coba lagi");
    }).whenComplete(() {
      setState(() => _isLoading = false);
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => WarningDialog(description: message),
    );
  }
}
