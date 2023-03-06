import Flutter
import UIKit

public class SwiftBackgroundListenersPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "background_listeners", binaryMessenger: registrar.messenger())
        let instance = SwiftBackgroundListenersPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        let rootViewController = UIApplication.shared.delegate!.window!!.rootViewController!
        let rootView = rootViewController.view!
        
        let label = getLabel()
        rootView.addSubview(label)
        addLabelConstraints(label: label, rootView: rootView)
        
        NetworkManager.sharedInstance.observeNetworkStatusChanged { status in
            label.isHidden = status
        }
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result("iOS " + UIDevice.current.systemVersion)
    }
    
    static func getLabel() -> PaddingLabel {
        let label = PaddingLabel()
        label.paddingTop = 8
        label.paddingLeft = 16
        label.paddingRight = 16
        label.paddingBottom = 12
        label.isHidden = true
        label.numberOfLines = 0
        label.textColor = .white
        label.backgroundColor = .red
        label.lineBreakMode = .byWordWrapping
        label.text = "You are not connected to the internet."
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0)
        label.sizeToFit()
        label.frame.size = label.bounds.size
        label.font = UIFont(name: label.font.fontName, size: 16)
        label.baselineAdjustment = .alignCenters
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    static func addLabelConstraints(label: UILabel, rootView: UIView) {
        let horizontalConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: rootView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: rootView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: rootView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint])
    }
}
