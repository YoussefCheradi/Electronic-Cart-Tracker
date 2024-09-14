import 'package:database/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'register.dart';
import 'dart:async';
import 'register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'user.dart';
import 'auth.dart';
import 'main.dart';

void main() => runApp(MaterialApp(
  home: forget(),
  debugShowCheckedModeBanner: false,
));

class forget extends StatefulWidget {
  const forget({super.key});


  @override
  State<forget> createState() => forgetscreen();
}

class forgetscreen extends State<forget> {
  
  TextEditingController emailController = TextEditingController();
  String email = '';
  bool visible = true;
  bool code = true;

  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset(String emailController) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController);
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Text(
            'Password reset email sent successfully!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
      );
    }on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              'ecrit email sous ca forme',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffffffff), Color(0xffe67e22)],
                  stops: [0.1, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 500, right: 600,left: 410),
                child: Image.asset(
                  'tsawer/image-removebg-preview3.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50,left: 140),
              child: IconButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => login()));
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  size: 40,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 520,left: 780,right: 800,bottom: 200),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black,width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  label: Center(
                    child: Container(
                      child: Text(
                        'Entrer votre email',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                style: TextStyle(fontSize: 20,color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 690,left: 780),
              child: ElevatedButton(
                  onPressed: (){
                    passwordReset(emailController.text.trim());
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 60, vertical: 25),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Bord arrondi du bouton
                      ),
                    ),
                    elevation: MaterialStateProperty.all<double>(15.0), // Élévation du bouton
                  ),
                  child: Text('Récupérer le mot de passe',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
            ),
          ],
        ),
      );
  }
}
