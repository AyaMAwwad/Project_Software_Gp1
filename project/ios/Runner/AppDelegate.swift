import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {//AIzaSyDrgXyoZlKMUDQIet_5ywTkLwdPC4BEwYo
    GMSServices.provideAPIKey("AIzaSyDrgXyoZlKMUDQIet_5ywTkLwdPC4BEwYo")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
