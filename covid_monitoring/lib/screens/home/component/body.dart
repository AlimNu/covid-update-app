import 'dart:convert';

import 'package:covid_monitoring/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;


class Body extends StatelessWidget {
  Future<Countries> fetchCountries() async {
    final response = await http.get('https://api.covid19api.com/countries');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Countries.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    String dropDownValue = 'Indonesia';
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: size.height * 0.35,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  image: DecorationImage(
                    image: AssetImage('assets/images/header.png'),
                  )),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.location_pin, color: kPrimaryLightColor,),
                SizedBox(width: 20,),
                Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropDownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      items: <String>['Indonesia', 'Two', 'Free', 'Four']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      style: TextStyle(color: kPrimaryLightColor),
                      underline: SizedBox(),
                      onChanged: (value) {},
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class Countries {
  final String country;
  final String slug;
  final String iso2;

  Countries({this.country, this.slug, this.iso2});

  factory Countries.fromJson(Map<String, dynamic> json){
    return Countries(
        country: json['Country'],
        slug: json['Slug'],
        iso2: json['ISO2']);
  }


}
