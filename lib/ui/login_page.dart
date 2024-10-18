import 'package:flutter/material.dart';
import 'package:responsi1_muthiakhanza_c/bloc/login_bloc.dart';
import 'package:responsi1_muthiakhanza_c/helpers/user_info.dart';
import 'package:responsi1_muthiakhanza_c/ui/genre_page.dart';
import 'package:responsi1_muthiakhanza_c/ui/registrasi_page.dart';
import 'package:responsi1_muthiakhanza_c/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double
            .infinity, // Menyebarkan container agar mencakup seluruh layar
        decoration: const BoxDecoration(
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
                    'LOGIN',
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
                      _emailTextField(),
                      const SizedBox(height: 16),
                      _passwordTextField(),
                      const SizedBox(height: 30),
                      _buttonLogin(),
                      const SizedBox(height: 30),
                      _menuRegistrasi(),
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
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
      style: const TextStyle(fontFamily: 'ComicSans'),
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
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
      style: const TextStyle(fontFamily: 'ComicSans'),
    );
  }

  Widget _buttonLogin() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        "Login",
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
    LoginBloc.login(
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then((value) async {
      if (value.code == 200) {
        await UserInfo().setToken(value.token!);
        await UserInfo().setUserID(int.parse(value.userID.toString()));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GenrePage()),
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
            description: "Login gagal, silahkan coba lagi",
          ),
        );
      }
    }, onError: (error) {
      print(error);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const WarningDialog(
          description: "Login gagal, silahkan coba lagi",
        ),
      );
    });
  }

  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text(
          "Registrasi",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'ComicSans',
            fontSize: 16,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistrasiPage()),
          );
        },
      ),
    );
  }
}
