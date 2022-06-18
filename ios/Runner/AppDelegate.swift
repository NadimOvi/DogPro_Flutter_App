import UIKit
import Flutter
import GoogleMaps
/* import GooglePlaces */


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyBMHTFgIc-_X9A3EuFi7CJEiR8YUNJ08bo")
   /*  GMSPlacesClient.provideAPIKey("AIzaSyBMHTFgIc-_X9A3EuFi7CJEiR8YUNJ08bo") */
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
