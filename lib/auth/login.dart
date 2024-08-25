// ignore_for_file: unnecessary_import, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_new, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobs_link/auth/register.dart';
import 'package:jobs_link/screens/userpage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
 
 TextEditingController emailController = TextEditingController();
 TextEditingController passwordController = TextEditingController();

bool _obscureText = true;

Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Login success!!!"),
          backgroundColor: Colors.green));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Userpage()));
    } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found' ){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("account is non-existent!!!"),
              backgroundColor: Colors.red));
          } else if (e.code == 'wrong password'){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("inaccurate password"),
              backgroundColor: Colors.red));
          } else{
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Error: ${e.message ?? 'An unknown error occurred'}'),
              backgroundColor: Colors.red));
          }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        centerTitle: true,
        title:Text("Login"),
        
      ),
      body:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: emailController,
                          decoration: InputDecoration(
               enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey)
                ),
                prefixIcon: Icon(Icons.email),
                labelText: "Email",
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: passwordController,
              obscureText:_obscureText,
                          decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey)
                ),
                prefixIcon: Icon(Icons.lock_person_outlined),
                suffixIcon:IconButton(
                 icon:Icon(_obscureText? Icons.visibility_off : Icons.visibility),
                 onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                    });
                    }
                ),
                labelText: "Password",
              ),
            ),
          ),
       
          SizedBox(height: 10),
          Padding(padding: EdgeInsets.symmetric(horizontal: 50,vertical: 20),),
          ElevatedButton(
            
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.white),
            
            ),
            child: Text('Login'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:(context)=>Userpage()),
                );
             
            }),
            
          new GestureDetector(
   onTap: () {
    Navigator.push(context, MaterialPageRoute(builder:(context)=>Register()),
    );
  },
  child: new Text("Don't have an account?",
  style:TextStyle(decoration: TextDecoration.underline),
  ),
  
)
      
           
        ],),
        )
     
  );

}
}