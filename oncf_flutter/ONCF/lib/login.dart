// import 'dart:async';
// import 'package:database/Essai/Essai-tableau.dart';
// import 'package:database/ReceptionRame/ReceptionRame_tableaux.dart';
// import 'package:database/Reparation-Module/Reparation-Module-tableau.dart';
// import 'package:database/loading.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';
// import 'register.dart';
// import 'main.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'user.dart';
// import 'auth.dart';
// import 'forgetpassword.dart';
//
// void main() => runApp(MaterialApp(
//   home: login(),
//   debugShowCheckedModeBanner: false,
// ));
//
// class login extends StatefulWidget {
//   @override
//   State<login> createState() => loginscreen();
// }
//
// class loginscreen extends State<login> {
//
//   final formKey = GlobalKey<FormState>();
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
//
//   String email = '';
//   String password = '';
//   String error = '';
//
//   final AuthService _auth = AuthService();
//
//   bool visible = true;
//   bool code = true;
//
//
//   @override
//
//   Widget build(BuildContext context) {
//
//     // final user = Provider.of<Usere?>(context);
//     // print(user);
//
//     return Scaffold(
//       key: scaffoldKey,
//       resizeToAvoidBottomInset: true,
//       body: Stack(
//         children: [
//           Container(
//             height: double.infinity,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                   colors: [Color(0xffffffff),Color(0xff0000ff)],
//                   stops: [0.1, 3]),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(top: 100, left: 22),
//               child: Text(
//                 'Hello\nLog In!',
//                 style: TextStyle(
//                   fontSize: 50,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 50,left: 340),
//             child: IconButton(
//               onPressed: (){
//
//                 Navigator.push(context,
//                     MaterialPageRoute(
//                         builder: (context) => home()));
//               },
//               icon: Icon(
//                 Icons.home,
//                 size: 40,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           Form(
//             key: formKey,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 300),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40),
//                   ),
//                 ),
//                 height: double.infinity,
//                 width: double.infinity,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 18, right: 18),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         TextFormField(
//                           validator: (value) {
//                             if (value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value!))
//                             {
//                               return 'Veuillez saisir votre email correct';
//                             }
//                             return null;
//                           },
//                           onChanged: (val){
//                             setState(() {
//                               email = val;
//                             });
//                           },
//                           decoration: InputDecoration(
//                             suffixIcon: Icon(
//                               Icons.mail,
//                               color: Colors.black,
//                             ),
//                             label: Text(
//                               'Gmail',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         TextFormField(
//                           validator: (value) {
//                             if (value!.length <6) {
//                               return 'Veuillez saisir votre password (+6)';
//                             }
//                             return null;
//                           },
//                             onChanged: (val){
//                             setState(() {
//                               password = val;
//                             });
//                           },
//                           obscureText: visible,
//                           decoration: InputDecoration(
//                             suffixIcon: IconButton(
//                                 icon: visible
//                                     ? Icon(Icons.visibility_off,
//                                     color: Colors.black)
//                                     : Icon(Icons.visibility, color: Colors.black),
//                                 onPressed: () {
//                                   setState(() {
//                                     visible = !visible;
//                                   });
//                                 }),
//                             label: Text(
//                               'Password',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 200),
//                           child: InkWell(
//                             onTap: () {
//
//                               Navigator.push(
//                                   context, MaterialPageRoute(
//                                   builder: (context) => forget()));
//                             },
//                             child: Text(
//                               'Forgot Password?',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 17,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 50,
//                         ),
//                         Center(
//                           child: ElevatedButton(
//                             onPressed: () async {
//                               // dynamic result = await _auth.signInAnon();
//                               // if(result == null){
//                               //   print('erreur sign in');
//                               // }else{
//                               //   print('sign in');
//                               //   print(result);
//                               //}
//                               if (formKey.currentState!.validate()) {
//
//                                 dynamic result = await _auth.LoginWhith(email, password);
//                                 final TextStyle snackBarTextStyle = TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 );
//                                 if(result == null){
//
//                                   final snackBar = SnackBar(
//                                       content: Text('Login Error',style: snackBarTextStyle,
//                                         textAlign: TextAlign.center,));
//                                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                                 }else{
//                                   final snackBar = SnackBar(
//                                       content: Text('Login Success',style: snackBarTextStyle,
//                                         textAlign: TextAlign.center,));
//                                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Essai_Table()));
//                                 }
//                               }
//                             },
//                             style: ButtonStyle(
//                               padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                                 EdgeInsets.symmetric(horizontal: 65, vertical: 10),
//                               ),
//                               backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColorLight),
//                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20.0), // Bord arrondi du bouton
//                                 ),
//                               ),
//                               elevation: MaterialStateProperty.all<double>(15.0), // Élévation du bouton
//                             ),
//                             child: Text(
//                               'Log in',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 25,
//                                   color: Colors.black,),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 70,
//                         ),
//                         Align(
//                           alignment: Alignment.bottomRight,
//                           child: Column(
//                             children: [
//                               Text(
//                                 "Don't have account?",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 13,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () {
//
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => register()));
//                                 },
//                                 child: Text(
//                                   'Sign up',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 17,
//                                       color: Colors.blue),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
