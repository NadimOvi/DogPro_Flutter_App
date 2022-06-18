import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About the app'),
        centerTitle: true,
        backgroundColor: Color(0xff233f4b),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xff233f4b),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(

            children: <Widget> [
              const SizedBox(height: 15),
              Container(
                height: 150,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage("assets/dogimage.png"),
                    )
                ),
              ),

              Padding(
                padding: EdgeInsets.all(15),
                child: Text("We at Genofax™ are deeply interested in dogs as our integral domestic partners. We want to thoroughly understand the story of human-dog association and wish to bring the latest advances in genomic biology to improve the healthcare conditions of dogs as our pet. With this larger goal, we are unleashing the remarkable powers of genomics, machine learning, and artificial intelligence to help veterinarians take better care of dog health.\nWe humans have been continuously improving our lifespan. The average Australian life expectancy increased from 68.77 years in 1950 to 83.64 years today. The United Nations predicts the Australian life expectancy to reach nearly 93 years in 2100. Most of this increase is due to improved healthcare through modern science.",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                    textAlign: TextAlign.justify,
                ),
              ),

              const SizedBox(height: 15),
              Text("Powered by",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
              Container(

                height: 70,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage("assets/logo.png"),
                    )
                ),
              ),
              Text("Version : 1.1.3",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 25),
              /*Text("1.1.1",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),*/

            ],
          ),
        ),
      ),

    );
  }
}
