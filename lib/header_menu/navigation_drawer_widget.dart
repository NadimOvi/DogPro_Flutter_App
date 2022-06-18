import 'dart:io';

import 'package:dog_breed/Map/MapShow.dart';
import 'package:dog_breed/header_menu/about_this_app.dart';
import 'package:dog_breed/header_menu/contact_us.dart';
import 'package:dog_breed/header_menu/rating_view.dart';
import 'package:dog_breed/header_menu/share_app.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0,
    minLaunches: 1,
    remindDays: 0,
    remindLaunches: 0,
    googlePlayIdentifier: 'com.genofax.dog_breed',
    appStoreIdentifier: '1613874773',
  );


  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    double physicalPixelWidth = mediaQuery.size.width * mediaQuery.devicePixelRatio;
    double physicalPixelHeight = mediaQuery.size.height * mediaQuery.devicePixelRatio;
    bool? isVisible;

    if(physicalPixelWidth>1300.0){
      isVisible = false;
      print("height is above 1000");
    }else{
      isVisible = true;
      print("height is below 1000");
    }


    return Drawer(
    child: Material(
      color: Color(0xff233f4b),

      child: ListView(
        children: <Widget> [
            InkWell(
              child: Container(
                  padding: padding.add(EdgeInsets.fromLTRB(20, 30, 20, 10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage("assets/dogimage.png"),
                        )
                    ),
                  ),

                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          buildMenuItem(
            text: 'Pet Clinic',
            icon: Icons.local_hospital_rounded,
            onCLicked: () {
              selectedItem(context,4);
            },
          ),

          Visibility(
            visible: isVisible,
            child: buildMenuItem(
              text: "Share App",
              icon: Icons.share_outlined,
              onCLicked: () {
                selectedItem(context,0);
              },
            ),
          ),
          const SizedBox(height: 5),
          buildMenuItem(
            text: 'Contact us',
            icon: Icons.contact_page_outlined,
            onCLicked: () => selectedItem(context,1),
          ),
          const SizedBox(height: 5),
          buildMenuItem(
            text: 'About this app',
            icon: Icons.info_outline,
            onCLicked: () => selectedItem(context,2),
          ),
          const SizedBox(height: 5),
          buildMenuItem(
            text: 'Rate this app',
            icon: Icons.star_rate_sharp,
            onCLicked: () => selectedItem(context,3),
          ),
          const SizedBox(height: 20),
          Divider(color: Colors.white70),
          const SizedBox(height: 10),
          InkWell(
            child: Container(
              padding: padding.add(EdgeInsets.fromLTRB(20, 0, 20, 0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Powered by",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage("assets/logo.png"),
                        )
                    ),
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
      )
    );
  }


    Widget buildMenuItem({
      required String text,
      required IconData icon,
      VoidCallback? onCLicked,
  }){
      final color = Colors.white;
      final hoverColor = Colors.white70;

      return ListTile(
        leading: Icon(icon, color: color),
        title: Text(text, style: TextStyle(color: color),),
        hoverColor: hoverColor,
        onTap: onCLicked,
      );
    }

    void selectedItem(BuildContext context, int index) {
      Navigator.of(context).pop();
      switch(index) {
        case 0:
          /*Navigator.of(context).push(MaterialPageRoute(
              builder:(context) => ShareApp(),
          ));*/

          Share.share("https://apps.apple.com/au/app/dogpro-dog-profiling/id1613874773");
          break;
        case 1:
          Navigator.of(context).push(MaterialPageRoute(
            builder:(context) => ContactUs(),
          ));
          break;
        case 2:
          Navigator.of(context).push(MaterialPageRoute(
            builder:(context) => AboutApp(),
          ));
          break;
        case 3:
          /*openRatingDialog(context);*/
         /* Navigator.of(context).push(MaterialPageRoute(
              builder:(context) => RatingView(),
          ));*/

          openDialog(context);

          break;
        case 4:
          Navigator.of(context).push(MaterialPageRoute(
            builder:(context) => MapShows(),
          ));
          break;

      }
    }

openRatingDialog(BuildContext context){
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: RatingView(),
        );
      });
}

  void openDialog(BuildContext context) {
    rateMyApp.init().then((_) {

      rateMyApp.conditions.forEach((condition) {
        if(condition is DebuggableCondition){
          print(condition.valuesAsString);
        }
      });


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
  }
}
