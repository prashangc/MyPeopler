import UIKit
import Flutter
import FirebaseCore
import GoogleMaps
// import background_locator_2
// import workmanager

// func registerPlugins(registry: FlutterPluginRegistry) -> () {
//     if (!registry.hasPlugin("BackgroundLocatorPlugin")) {
//         GeneratedPluginRegistrant.register(with: registry)
//     }
// }


@main
@objc class AppDelegate: FlutterAppDelegate {
  /// Registers all pubspec-referenced Flutter plugins in the given registry.  
    // static func registerPlugins(with registry: FlutterPluginRegistry) {
    //         GeneratedPluginRegistrant.register(with: registry)
    //    }



  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any
]?
    
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyAlgQYiaTmRTnKbr7nA9h-IXLFzz9HkJaM")
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    // BackgroundLocatorPlugin.setPluginRegistrantCallback(registerPlugins)
    // WorkmanagerPlugin.registerTask(withIdentifier: "task-identifier")
    // UNUserNotificationCenter.current().delegate = self
    // UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*15))
        // WorkmanagerPlugin.setPluginRegistrantCallback { registry in  
        //     // The following code will be called upon WorkmanagerPlugin's registration.
        //     // Note : all of the app's plugins may not be required in this context ;
        //     // instead of using GeneratedPluginRegistrant.register(with: registry),
        //     // you may want to register only specific plugins.
        //    GeneratedPluginRegistrant.register(with: registry)
        // }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  //  override func userNotificationCenter(_ center: UNUserNotificationCenter,
  //                                        willPresent notification: UNNotification,
  //                                        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
  //        completionHandler(.alert) // shows banner even if app is in foreground
  //    }
}

