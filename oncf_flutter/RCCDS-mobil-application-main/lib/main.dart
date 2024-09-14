import 'package:database/ReceptionRame/ReceptionRame_tableaux.dart';
import 'package:database/loading.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'dart:async';
import 'register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'forgetpassword.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // Initialisation pour le Web
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBvj0d7wNmR22_VEds8WN8j9bQvhMSyA_c",
          appId: "1:1019891820257:web:1234567890abcdefg", // Remplacez par votre appId Web
          messagingSenderId: "1019891820257",
          projectId: "projet-login-3cef0"),
    );
  } else {
    // Initialisation pour les plateformes mobiles
    await Firebase.initializeApp();
  }

  runApp(MaterialApp(
    home: login(),
    debugShowCheckedModeBanner: false,
  ));
}

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => loginScreen();
}

class loginScreen extends State<login> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();


  String email = '';
  String password = '';
  String error = '';

  final AuthService _auth = AuthService();

  bool visible = true;
  bool code = true;


  @override

  Widget build(BuildContext context) {

    // final user = Provider.of<Usere?>(context);
    // print(user);

    return Scaffold(
      key: scaffoldKey,
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
            padding: const EdgeInsets.only(top: 800,left: 860),
            child: Column(
              children: [
                Text(
                  "Vous n'avez pas de compte ?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () {

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => register()));
                  },
                  child: Text(
                    "S'inscrire",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 500,left: 700,right: 700,bottom: 200),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xfffdebd0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value!))
                            {
                              return 'Veuillez saisir votre Email correct';
                            }
                            return null;
                          },
                          onChanged: (val){
                            setState(() {
                              email = val;
                            });
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.mail,
                              color: Colors.black,
                            ),
                            label: Text(
                              'Email',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.length <6) {
                              return 'Veuillez saisir un mot de passe (+6 caracteres)';
                            }
                            return null;
                          },
                          onChanged: (val){
                            setState(() {
                              password = val;
                            });
                          },
                          obscureText: visible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: visible
                                    ? Icon(Icons.visibility_off,
                                    color: Colors.black)
                                    : Icon(Icons.visibility, color: Colors.black),
                                onPressed: () {
                                  setState(() {
                                    visible = !visible;
                                  });
                                }),
                            label: Text(
                              'Mot de passe',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 320),
                          child: InkWell(
                            onTap: () {

                              Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context) => forget()));
                            },
                            child: Text(
                              'Mot de passe oublié?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              // dynamic result = await _auth.signInAnon();
                              // if(result == null){
                              //   print('erreur sign in');
                              // }else{
                              //   print('sign in');
                              //   print(result);
                              //}
                              if (formKey.currentState!.validate()) {

                                dynamic result = await _auth.LoginWhith(email, password);
                                final TextStyle snackBarTextStyle = TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                );
                                if(result == null){

                                  final snackBar = SnackBar(
                                      content: Text('Erreur de connexion',style: snackBarTextStyle,
                                        textAlign: TextAlign.center,));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }else{
                                  final snackBar = SnackBar(
                                      content: Text('Connexion réussie',style: snackBarTextStyle,
                                        textAlign: TextAlign.center,));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ReceptionRameTable()));
                                }
                              }
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0), // Bord arrondi du bouton
                                ),
                              ),
                              elevation: MaterialStateProperty.all<double>(15.0), // Élévation du bouton
                            ),
                            child: Text(
                              'Se connecter',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
