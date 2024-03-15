import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private let channelName = "com.example/anime_store"
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)
        
        channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard let args = call.arguments as? [String: Any],
                  let urlString = args["url"] as? String,
                  let url = URL(string: urlString) else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
                return
            }
            
            let task: URLSessionDataTask
            switch call.method {
            case "fetchAnimeList":
                task = self.sendRequest(url: url, result: result)
            case "fetchAnimeCharacters":
                task = self.sendRequest(url: url, result: result)
            default:
                result(FlutterMethodNotImplemented)
                return
            }
            task.resume()
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func sendRequest(url: URL, result: @escaping FlutterResult) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    result(FlutterError(code: "NETWORK_ERROR", message: error.localizedDescription, details: nil))
                } else if let data = data, let string = String(data: data, encoding: .utf8) {
                    result(string)
                } else {
                    result(FlutterError(code: "UNKNOWN_ERROR", message: "Unknown error", details: nil))
                }
            }
        }
    }
}
