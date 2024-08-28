// ignore_for_file: sort_child_properties_last, prefer_final_fields, prefer_const_constructors, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_types_as_parameter_names, unused_field

import 'package:flutter/material.dart';
import 'package:cv_craft/auth/utility/globals.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();

 
}

class _FavoritesState extends State<Favorites> {
  List<String> _favorites = [];
   List<String> _favoriteImages = [];
  

  
  var image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: _favorites.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_favorites[index]),
       
          );
          
        },
      ),
      
    );
    
  }
void delete() async {
    
        setState(() {
          favoriteButton_0_01 = false;
          print(favoriteButton_0_01);
        });
      }
    
      void saved() async {
    
        setState(() {
          favoriteButton_0_01 = true;
          print(favoriteButton_0_01);
        });
      }


}



 
 