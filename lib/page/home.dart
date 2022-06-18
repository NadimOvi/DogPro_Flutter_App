import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dog_breed/api/api_service.dart';
import 'package:dog_breed/get_started_all_page/get_started_1st_page.dart';
import 'package:dog_breed/get_started_all_page/get_started_2nd_page.dart';
import 'package:dog_breed/get_started_all_page/get_started_3rd_page.dart';
import 'package:dog_breed/header_menu/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/RecentBreedHistoryList.dart';
import '../upload_result/recent_history_result.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var scaffoldKey = GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen> {
  final CarouselController _controller = CarouselController();
  List<Data>? dataHistoryList = [];

  ApiService apiService = ApiService();

  Future<RecentBreedHistoryList> getHistoryList() async {
    final response = await http.get(
      Uri.parse("https://genofax.com/api/breed/history"),
    );
    var data = await jsonDecode(response.body.toString());
    if (response.statusCode == 200) {

      setState(() {
        final dataJson = RecentBreedHistoryList.fromJson(data);
        dataHistoryList = dataJson.data;
        print(response.statusCode);
      });


      return RecentBreedHistoryList.fromJson(data);
    } else {
      setState(() {
        super.initState();
      });
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    setState(() {
      this.getHistoryList();
      FirebaseAnalytics.instance.logEvent(name: 'Homepage_Screen',parameters: {
        'note':"stay Home page",
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Color(0xff233f4b),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Image.asset("assets/images/menu_bar_icon.png"),
            ),
          ),
          title: Center(
            child: Container(
              child: Text(
                'DogPro',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              margin: const EdgeInsets.fromLTRB(0, 0, 50, 0),
            ),
          ),
          backgroundColor: Color(0xff233f4b),
        ),
        drawer: NavigationDrawerWidget(),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Classify Dog Breed",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 20),
                          child: Text(
                            "Identify a dog's breed, learn about its temperament, find similar dogs, and more. Upload a photo or take a picture with your phone to try it.",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                          child: Container(
                            width: 350,
                            child: RecommendedCard(
                              image: 'assets/images/first_image.jpg',
                              name: "Identify your dog's breed",
                              press: () {},
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FirstPage(),
                              ),
                            );
                          }),
                      InkWell(
                        child: Container(
                          width: 350,
                          child: RecommendedCard(
                            image: 'assets/images/second_image.jpg',
                            name: "Search breeds based on different dog attributes",
                            press: () {},
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SecondPage(),
                            ),
                          );
                        },
                      ),
                      InkWell(
                        child: Container(
                          width: 350,
                          child: RecommendedCard(
                            image: 'assets/images/third_image.jpg',
                            name: "Learn about different dog breeds",
                            press: () {},
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ThirdPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),



                Container(
                  child: Padding(
                    padding: /*EdgeInsets.symmetric(horizontal: 20.0),*/
                      EdgeInsets.fromLTRB(20, 20, 0, 20),
                    child: Text(
                      "Recent Search",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                Container(
                  child: Column(
                    children: [
                      CarouselSlider(
                          carouselController: _controller,
                          items: dataHistoryList?.map(
                            (item) {
                              return Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  child: Stack(
                                    children: [
                                      /*Image.network(
                                        item.imageUrl.toString(),
                                        fit: BoxFit.cover,
                                        width: 1000,
                                      ),*/
                                      CachedNetworkImage(
                                        imageUrl: item.imageUrl.toString(),
                                        width: 1000,
                                        fit: BoxFit.cover,

                                      ),
                                      Positioned(
                                          bottom: 0.0,
                                          left: 0.0,
                                          right: 0.0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(200, 0, 0, 0),
                                                Color.fromARGB(0, 0, 0, 0),
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            )),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 10,
                                            ),
                                            child: Text(
                                              item.response!.data!.first.breed
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RecentHistoryResultShow(
                                                        item),
                                              ),
                                            );
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                          )),

                      /*CarouselSlider.builder(
                          itemCount: dataHistoryList==null?0:dataHistoryList!.length,
                          itemBuilder: (BuildContext context, int itemIndex){
                            return Container();
                          },)*/

                      Padding(padding: EdgeInsets.only(bottom: 50))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}



class RecommendedCard extends StatelessWidget {
  const RecommendedCard(
      {Key? key, required this.image, required this.name, required this.press})
      : super(key: key);
  static const kPrimaryColor = Color(0xFF0C9869);
  static const kTextColor = Color(0xFF505050);
  static const kBackGroundColor = Color(0xFFFFFFFF);
  static double kDefaultPadding = 20.0;

  final String image, name;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,

        /*right: kDefaultPadding,*/
      ),
      width: size.width * 0.8,
      child: Column(
        children: <Widget>[
          Image.asset(image),
          GestureDetector(
            onTap: press(),
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                  color: Color(0xff18baa5),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 80,
                        color: kPrimaryColor.withOpacity(0.23))
                  ]),
              child: Row(
                children: <Widget>[
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: name,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    )
                  ]))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
