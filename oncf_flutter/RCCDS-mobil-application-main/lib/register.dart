import 'package:database/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'auth.dart';
import 'main.dart';

void main() => runApp(MaterialApp(
  home: register(),
  debugShowCheckedModeBanner: false,
));

class register extends StatefulWidget {

  @override
  State<register> createState() => registerscreen();
}

class registerscreen extends State<register> {

  final formKey = GlobalKey<FormState>();


  String email = '';
  String password = '';
  String UserName = '';
  String error = '';

  final AuthService _auth = AuthService();

  bool visible = true;
  bool code = true;


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
            padding: const EdgeInsets.only(top: 800,left: 887),
            child: Column(
              children: [
                Text("Avez-vous un compte ?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black,
                  ),),
                InkWell(
                  onTap: (){

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>login())
                    );
                  },
                  child : Text('Se connecter !',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50,left: 340),
            child: IconButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => login()));
              },
              icon: Icon(
                Icons.home,
                size: 40,
                color: Colors.white,
              ),
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
                  padding: const EdgeInsets.only(left: 18,right: 18),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value!)) {
                              return 'Veuillez saisir votre Email';
                            }
                            return null;
                          },
                          onChanged: (val){
                            setState(() {
                              email = val;
                            });
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.mail,
                              color: Colors.black,),
                            label: Text('Email',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        TextFormField(
                          validator: (value) {
                            if (value!.length <6) {
                              return 'Veuillez saisir votre mot de passe';
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
                                icon: visible ? Icon(Icons.visibility_off,color: Colors.black) :
                                Icon(Icons.visibility,color: Colors.black),

                                onPressed: (){
                                  setState(() {
                                    visible = ! visible;
                                  });
                                }),
                            label: Text('Mot de passe',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 50,),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async{
                              if (formKey.currentState!.validate()) {
                                dynamic result = await _auth.registerWhith(email, password);
                                if(result == null){
                                  setState(() {
                                    error = 'votre enregistrement est echouer';
                                  });
                                }else{
                                  final TextStyle snackBarTextStyle = TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  );
                                  final snackBar = SnackBar(
                                      content: Text('Inscription réussie',style: snackBarTextStyle,
                                        textAlign: TextAlign.center,));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                                }
                              }
                              },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(horizontal: 65, vertical: 12),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0), // Bord arrondi du bouton
                                ),
                              ),
                              elevation: MaterialStateProperty.all<double>(15.0), // Élévation du bouton
                            ),
                            child : Text('Register',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black
                              ),),
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
