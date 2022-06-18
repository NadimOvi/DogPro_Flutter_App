import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RatingView extends StatefulWidget {
  const RatingView({Key? key}) : super(key: key);

  @override
  _RatingViewState createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  var _ratingPageController = PageController();
  var _starPosition = 200.0;
  var _rating = 0;
  var _selectedChipIndex = -1;


  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0,
    minLaunches: 1,
    googlePlayIdentifier: 'com.genofax.dog_breed',
    appStoreIdentifier: '4TUT6MGDN8',
  );



  @override
  void initState() {
    // TODO: implement initState


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15)
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Container(
            height: max(300, MediaQuery.of(context).size.height * 0.3),
            child: PageView(
              controller: _ratingPageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildThanksNote(),
                _causeOfRating(),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.teal,
                child: MaterialButton(
                  onPressed: (){},
                  child: Text('Done'),
                  textColor: Colors.white,
                ),
              )
          ),
          Positioned(
            right: 0,
              child: MaterialButton(
                onPressed: (){},
                child: Text('Skip'),)),
          AnimatedPositioned(
              top: _starPosition,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    5, (index) => IconButton(
                  icon: index < _rating ? Icon(Icons.star,size: 32,) : Icon(Icons.star_border, size: 32,) ,
                  color: Colors.red,
                  onPressed: (){
                    /*_ratingPageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                    setState(() {
                      _starPosition = 30.0;
                      _rating = index +1 ;
                    });*/
                    setState(() {
                      _starPosition = 30.0;
                      _rating = index +1 ;
                      print(_rating.toString());

                      rateMyApp.init().then((_) {
                        if (rateMyApp.shouldOpenDialog) {
                          rateMyApp.showRateDialog(
                            context,
                            title: 'Rate this app', // The dialog title.
                            message: 'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.', // The dialog message.
                            rateButton: 'RATE', // The dialog "rate" button text.
                            noButton: 'NO THANKS', // The dialog "no" button text.
                            laterButton: 'MAYBE LATER', // The dialog "later" button text.
                            listener: (button) { // The button click listener (useful if you want to cancel the click event).
                              switch(button) {
                                case RateMyAppDialogButton.rate:
                                  print('Clicked on "Rate".');
                                  break;
                                case RateMyAppDialogButton.later:
                                  print('Clicked on "Later".');
                                  break;
                                case RateMyAppDialogButton.no:
                                  print('Clicked on "No".');
                                  break;
                              }

                              return true; // Return false if you want to cancel the click event.
                            },
                            ignoreNativeDialog: Platform.isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
                            dialogStyle: const DialogStyle(), // Custom dialog styles.
                            onDismissed: () => rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
                            // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
                            // actionsBuilder: (context) => [], // This one allows you to use your own buttons.
                          );

                          // Or if you prefer to show a star rating bar (powered by `flutter_rating_bar`) :


                        }
                      });



                    });


                  },
                )),
              ),
              duration: Duration(milliseconds: 300))
        ],
      ),
    );
  }

  _buildThanksNote () {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Thanks for using DogPro",
          style: TextStyle(
            fontSize: 24,
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text("We\'d love to get your feedback"),
        Text("Rate This app!"),
      ],
    );
  }


  _causeOfRating(){
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("What could be better?"),
              Wrap(
                spacing: 8.0,
                alignment: WrapAlignment.center,
                children: List.generate(6, (index) => InkWell(
                  onTap: (){
                    setState(() {
                      _selectedChipIndex = index;
                    });

                  },
                  child: Chip(
                    backgroundColor: _selectedChipIndex == index? Colors.red : Colors.grey[300],
                    label: Text("Text ${index + 1}"),
                  ),
                )),
              ),
              SizedBox(height: 16,),
              InkWell(
                onTap: (){},
                child: Text(
                  'Want to tell us more?',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        replacement: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Tell us more"),
            Chip(label: Text('Text ${_selectedChipIndex + 1}')),
            TextField(

            )
          ],
        ),)
      ],
    );
  }
}


