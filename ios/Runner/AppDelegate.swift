import UIKit
import Flutter
import YandexMapsMobile

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    YMKMapKit.setApiKey("9377ab8d-815d-487c-a5c4-2353c824e3fe")
    YMKMapKit.setLocale("ru_RU")
    GeneratedPluginRegistrant.register(with: self)

    // if #available(iOS 10.0, *) {
    //   UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    // }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
