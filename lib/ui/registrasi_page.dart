import 'package:flutter/material.dart';
import 'package:responsi1_muthiakhanza_c/bloc/registrasi_bloc.dart';
import 'package:responsi1_muthiakhanza_c/widget/success_dialog.dart';
import 'package:responsi1_muthiakhanza_c/widget/warning_dialog.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);

  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();
  final _konfirmasiPasswordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 230, 0),
              Colors.orange,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  child: const Text(
                    'REGISTRASI',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'ComicSans',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _namaTextField(),
                      const SizedBox(height: 16),
                      _emailTextField(),
                      const SizedBox(height: 16),
                      _passwordTextField(),
                      const SizedBox(height: 16),
                      _konfirmasiPasswordTextField(),
                      const SizedBox(height: 30),
                      _buttonRegistrasi(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _namaTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nama",
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.orange, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 230, 0), width: 1),
        ),
      ),
      controller: _namaTextboxController,
      validator: (value) {
        if (value!.length < 3) {
          return "Nama harus diisi minimal 3 karakter";
        }
        return null;
      },
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.orange, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 230, 0), width: 1),
        ),
      ),
      controller: _emailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        Pattern pattern = r'^[^@]+@[^@]+\.[^@]+';
        RegExp regex = RegExp(pattern.toString());
        if (!regex.hasMatch(value)) {
          return "Email tidak valid";
        }
        return null;
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.orange, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 230, 0), width: 1),
        ),
      ),
      controller: _passwordTextboxController,
      obscureText: true,
      validator: (value) {
        if (value!.length < 6) {
          return "Password harus diisi minimal 6 karakter";
        }
        return null;
      },
    );
  }

  Widget _konfirmasiPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Konfirmasi Password",
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.orange, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 230, 0), width: 1),
        ),
      ),
      controller: _konfirmasiPasswordTextboxController,
      obscureText: true,
      validator: (value) {
        if (value != _passwordTextboxController.text) {
          return "Konfirmasi password tidak sama";
        }
        return null;
      },
    );
  }

  Widget _buttonRegistrasi() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        elevation: 5, // Added elevation for shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
        ),
      ),
      child: const Text(
        "Registrasi",
        style: TextStyle(fontFamily: 'ComicSans'),
      ),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) _submit();
        }
      },
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    RegistrasiBloc.registrasi(
            nama: _namaTextboxController.text,
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SuccessDialog(
                description: "Registrasi berhasil, silahkan login",
                okClick: () {
                  Navigator.pop(context);
                },
              ));
    }, onError: (error) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
                description: "Registrasi gagal, silahkan coba lagi",
              ));
    });
  }
}
