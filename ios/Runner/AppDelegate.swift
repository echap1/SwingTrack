import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let recordChannel = FlutterMethodChannel(name: "com.ethanchapman.swingtrack/record",
                                              binaryMessenger: controller.binaryMessenger)
    recordChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      // Note: this method is invoked on the UI thread.
      guard call.method == "record" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self?.record(result: result)
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func record(result: FlutterResult) {
    result(123434)
  }
}
